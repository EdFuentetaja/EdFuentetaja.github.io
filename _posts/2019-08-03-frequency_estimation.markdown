---
title:  "Frequency Estimation"
date:   2019-08-03 00:00:00 +0800
categories: SDR
excerpt: "Some notes on the estimation of the frequency of simple phasors."
header:
  image: "545328main_memphis_2006_lg_2_cropped_c.jpg"
---

There is something on the last article, concerned with [frequency shifting][frequency_shifting], that called my attention while I was preparing it.
I was showing there a synthesized [phasor][phasor] in the frequency domain, something that can be produced with the following Octave code:

{% highlight matlab %}
    % FFT plotting, with thanks to Jason R
    % https://dsp.stackexchange.com/questions/2970/how-to-make-frequency-axis-for-even-and-odd-fft-length
    function plot_fft(s, fs);
        n=numel(s);
        df = fs/n;
        ff = (0:(n-1))*df;
        ff(ff >= fs/2) = ff(ff >= fs/2) - fs;
        plot(fftshift(ff), 20*log10((abs(fftshift(fft(s))))/n), '*-');
    end

    t = (0:999);
    f = 12345;
    fs = 96000;
    s=cos(2*pi*t*f/fs) + i*sin(2*pi*t*f/fs);
    plot_fft(s, fs);

{% endhighlight %}

which produces the following figure:
![Phasor in frequency domain][phasor_1]{:.center-image}

but... is this correct? Shouldn't a phasor produce a single "line" spectrum, with all its energy focused in one single frequency bin?

Surely the problem is that I forgot again to "window" the signal, one of DSP's capital sins:

{% highlight matlab %}
    ws = s .* hamming(numel(s));
    plot_fft(ws,fs);
{% endhighlight %}

![Windowed phasor in frequency domain][phasor_2]{:.center-image}

Nope, this is still not good... Actually the Wikipedia's article on [window functions][window_function] does a good job at explaining what's going on. The problem is that the Fourier transform (as well as the DFT used here) assumes that the signal is _periodic_. A phasor is indeed periodic, however the period in samples of our phasor is (as described in the mentioned frequency shifting article):

$$\dfrac{|f| f_s}{GCD(f, f_s)^2}$$

which in our case is 5267200 samples. We are presenting 1000 samples instead to the DFT, so from the point of view of the DFT we are presenting a non-periodic set of samples. The discontinuity between one period to the next is producing the "spectrum leakage" to the neighbor frequency bins.

For confirmation, let's see what happens if we present to the DFT the exact number of samples that makes our set truly periodic:

{% highlight matlab %}
    t = (0:f*fs/(gcd(f,fs)^2)-1);
    ...
    % Notice that we are not using a window function:
    plot_fft(s,fs);
{% endhighlight %}


![Periodic phasor in frequency domain][phasor_3]{:.center-image}

Bingo, no leakage whatsoever as it should be and no need to "window" our signal either. Take those -200 dB values from the plot as zero power since that's pretty much the resolution of our floating point computation.

Being presented with a phasor of unknown frequency (a carrier signal for instance), if we were able to estimate its frequency (and therefore its period), then we should be able to produce an undistorted representation of our signal in the frequency domain by presenting the DFT with the appropriate number of samples corresponding with our signal's period and we won't need to apply any window function to them beforehand. This high magic is called [coherent sampling][coherent_sampling].

There is a caveat, as there always is. This coherent sampling is unmerciful to inaccuracies in the estimation of our signal's period. Let's say we are short of one sample (out of 5267200!):

{% highlight matlab %}
    t = (0:f*fs/(gcd(f,fs)^2)-1 -1);
    ...
    plot_fft(s,fs);
{% endhighlight %}


![Slightly unperiodic phasor in frequency domain][phasor_4]{:.center-image}

... the leakage is back!

Then the question is: how can the frequency of a phasor or carrier signal be estimated and how accurate can we get? Let's do a zoom in to the first spectrum, the one produced with 1000 samples:

![Zoomed-in phasor in frequency domain][phasor_5]{:.center-image}

Because of our "incoherent" sampling we see how our phasor frequency doesn't completely match one single frequency bin. If we have to say something, its frequency would be somewhere in between 12285 and 12384 Hz, probably closer to the later.

"Understanding DSP" by Richard Lyons offers a wonderful [spectral peak location][peak-location-algorithm] "trick":

$$m_{peak} = m_k + real(\dfrac{X(m_{k-1})-X(m_{k+1})}{2X(m_k)-X(m_{k-1})-X(m_{k+1})})$$

where $$X$$ is the DFT of our signal, $$m_k$$ is the bin for the maximum value in $$X$$ and $$m_{k-1}$$ and $$m_{k+1}$$ are the previous and following bins respectively. This expression gives us an estimate for our phasor frequency of 12343.78 Hz which is indeed a very good estimate.

Lyon's trick is however a bit short in explanations and references. Picked with interest, I'll like to give it a go, following a path that has been traveled by many others before, to see where I get.

## Derivation of a frequency estimation trick

I think I'm going to use "trick" instead of algorithm from now on. Anyway, given our phasor (including also an amplitude $$A$$ and phase $$\theta$$ for good measure):

$$s_n=A e^{j (2 \pi n f/fs + \theta)} = A e^{j \theta} e^{j 2 \pi n f/fs}$$

and the DFT expression:

$$S_k=\sum_{n=0}^{N-1}{s_n e^{-j 2 \pi k n / N}}$$

then

$$S_k=A e^{j \theta} \sum_{n=0}^{N-1}{e^{j 2 \pi n (f/fs - k/N)}} = A e^{j \theta} \sum_{n=0}^{N-1}{[e^{j 2 \pi (f/fs - k/N)}]^n}$$

Thanks to the [geometric sum formula][geometric_series], making $$r = e^{j 2 \pi (f/fs - k/N)}$$ we get

$$S_k=A e^{j \theta} \dfrac{1-r^n}{1-r} = A e^{j \theta} \dfrac{1-e^{j 2 \pi N f/fs} e^{j 2 \pi k}}{1 - e^{j 2 \pi f/fs} e^{-j2 \pi k/N}}$$

where luckily $$e^{j 2 \pi k}$$ is 1 for all values of k and making $$a = e^{j 2 \pi f/fs}$$ and $$b = e^{j 2 \pi/N}$$ then

$$S_k=A e^{j \theta} \dfrac{b^k(1-a^N)}{b^k-a}$$

and therefore

$$S_{k+i}=A e^{j \theta} \dfrac{b^{k+i}(1-a^N)}{b^{k+i}-a} = A e^{j \theta} \dfrac{b^k(1-a^N)}{b^k-a/b^i}$$

It's straightforward now to compute their ratio:

$$\dfrac{S_{k+i}}{S_{k}}=\dfrac{b^k-a}{b^k-a/b^i}$$

notice how the phase and amplitude cancelled out. From here $$a$$ can be derived:

$$a = \dfrac{b^{k+i}(S_{k+i}-S_k)}{S_{k+i}-S_k b^i}$$

and the frequency estimated as $$f = \dfrac{f_s}{2 \pi} atan2(imag(a), real(a))$$,

In the absence of noise this is an exact expression. Probably not too far from Lyon's one where he uses some more tricks to approximate the output from the atan2. However I'm not going to compromise here with accuracy because I believe the computation of this estimate is not expensive, just a few complex multiplications and an atan2 that can be evaluated using a lookup table.

Additionaly, having a general expression gives us the freedom to plugin in different frequency bins and combine them to produce better estimates in the presence of noise. For instance, what I'm doing next is find the peak in the spectrum and then do the average of the $$a$$ values for $$i$$ at [-2, -1, 1, 2], a couple of bins before and after the peak. Noise is added in steps to the input signal and the estimated frequency and its error are computed at each SNR level. It looks like this:

![frequency estimation error vs SNR][frequency_error_vs_snr]{:.center-image}

About 10 Hz of error at 0 dB SNR using a DFT of 256 points, not bad. Below -10 dB the highest peak in the spectrum is not so likely to be the one from our phasor, completely messing up the estimation, but if you happen to roughly know the frequency you are looking for, then you can still expect this method to give you a decent estimate even at lower SNRs, with a degradation following the previous curve, which unfortunately looks faster than linear.

Related to this topics there is the ["A new detection technique for digital radio communication systems applied spectrum phase interpolation"][paper] paper by Hitoshi Kitayoshi that is relevant to our topic at hand. There the author applies a particular "hanning" window to the signal and follows a similar approach to what I do here. If I have some time I'd like to study it in more detail but I'd leave it here for now.

[frequency_shifting]:    /sdr/frequency_shifting/
[peak-location-algorithm]: https://www.embedded.com/design/configurable-systems/4007643/DSP-Tricks-Spectral-peak-location-algorithm
[phasor]:                https://en.wikipedia.org/wiki/Phasor
[window_function]:       https://en.wikipedia.org/wiki/Window_function
[coherent_sampling]:     https://en.wikipedia.org/wiki/Coherent_sampling
[geometric_series]: https://en.wikipedia.org/wiki/Geometric_series
[paper]:                https://www.researchgate.net/publication/251764659_A_new_detection_technique_for_digital_radio_communication_systems_applied_spectrum_phase_interpolation

[phasor_1]:     /images/Frequency_estimation/phasor_1.png
[phasor_2]:     /images/Frequency_estimation/phasor_2.png
[phasor_3]:     /images/Frequency_estimation/phasor_3.png
[phasor_4]:     /images/Frequency_estimation/phasor_4.png
[phasor_5]:     /images/Frequency_estimation/phasor_5.png
[frequency_error_vs_snr]: /images/Frequency_estimation/frequency_error_vs_snr.png