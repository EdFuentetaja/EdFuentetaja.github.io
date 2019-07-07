---
title:  "D'Andrea (1990) clock recovery"
date:   2019-07-06 00:00:00 +0800
categories: SDR
excerpt: "Analysis of the D'Andrea (1990) clock recovery method."
header:
  image: "Clockwork_-_Flickr_-_Stiller_Beobachter_cropped_c.jpg"
---

We are making slow progress here, finally reaching developments from the 90s. This post is concerned with the popular paper by D'Andrea, Mengali and Reggiannini from 1990, ["A digital approach to clock recovery in generalized MSK."][paper] Drs. Mengali and D'Andrea are also the authors of the expensive ["Synchronization Techniques for Digital Receivers,"][book] one of the few books in this specialized subject.

In this paper the authors develop a practical clock recovery method for MSK signals cleverly exploiting a pattern that shows in the complex base-band signal and is the basis for a number of derived methods that followed in the literature. Working in the complex domain is a change in this series, the other posts in this series recover the clock from the signal differential phase. This can be understood as an improvement since extracting the differential phase from the complex signal is inherently a noisy step, avoiding it can open the way to the next level in performance.

The authors went on a systematic search that lead them to the discovery of the following fourth-order non-linear transformation of the complex signal:

$$\tilde{c}(t) = \tilde{z}^2(t)\tilde{z}^{*2}(t-T)$$

where $$\tilde{z}(t)$$ is the received baseband complex signal $$s(t)$$ plus noise $$n(t)$$, and $$T$$ is the symbol period in samples.

They approximate the expected value of this $$\tilde{c}(t)$$ for MSK signals as:

$$E\{\tilde{c}(t)\} = -\dfrac{1}{2}(1+cos\dfrac{2\pi t}{T})$$

a periodic signal with the key properties of having the same frequency as the symbol rate of our original $$s(t)$$ and its same symbol phase.

With this transformation the authors put together an "S-curve" that can be used for clock tracking and acquisition:

$$S(\epsilon) = E\{Re\{\dot{c}(kT + \epsilon)\} | \epsilon\}$$

That's the expected value of the real part of the derivative of $$\tilde{c}(t)$$, where $$\epsilon$$ is the timing error.

An S-curve gives us a control signal that can be used to adjust the timing. When we are late we want it to be positive so we can use it to hinder our clock accordingly, and likewise, we want it to be negative when we are early to use it to advance our clock. When we are synchronized we want its value to be as small as possible. Its slope at zero gives us an idea of how fast it can help us to synchronize. With a low slope it will take longer to synchronize. The next chart shows examples of two proverbial S-curves:

![Idealized S-curve][s_curve]{:.center-image}

Let's take a look now at what this transformation does to a GMSK signal. Here we have the differential phase of an AIS message with 9600 bauds, oversampled with T=10 and with a bit of noise added:

![Example signal (phase difference)][example_input]

It's a bit noisy but its eye diagram comes out well defined and it should not be a challenge for the clock recovery algorithm to work with it. This diagram has been prepared with the help from this simple interactive [javascript tool][eye_diagram_tool].

![Eye diagram for the example signal's differential phase][diff_phase_eye]{:.center-image}

Surely enough, the spectrum of $$Re\{\dot{c}(t)\}$$, the derivative of the real component of $$\tilde{c}(t)$$, shows a strong peak at 9600, our symbol rate:

![Spectrum of the derivative of the real component of c(t)][s_spectrum]{:.center-image}

And its eye diagram shows the properties we are looking for in a S-curve:

![Eye diagram of the S-curve][s_curve_eye]{:.center-image}

Notice however that this curve shows a bias of one quarter of the symbol period $$T$$.

Average all the symbol periods from the eye diagram, the result (an approximation to its expected value) shows like this:

![Mean S-curve][s_curve_mean]{:.center-image}

Which is a robust S-curve centered at about one quarter of the symbol period $$T$$.

The most important detrimental effect to this method is the effect of series of consecutive symbol values in the data stream. Logically a long series of zeros or ones in the MSK signal produce a single tone frequency that doesn't give any chance for the clock recovery. This is the reason why encoding schemas limit this effect by introducing ["bit stuffing,"][bit_stuffing] effectively breaking those long sequences by introducing alternating symbols in the data stream.

![Annotated eye diagram of the S-curve][s_curve_eye_2]{:.center-image}

Moreover, the harmonics that showed up in the S-curve spectrum presented before are coming from those sequences of consecutive symbol values.

## SNR analysis

Following a similar approach to Guobing et al in ["Blind Frequency and Symbol Rate Estimation for MSK Signal under low SNR"][paper2] we can estimate how is the SNR of D'Andrea's fourth-order transformation in comparison to the original signal's SNR.

Being of constant envelope, the power of an MSK signal goes with $$\dfrac{A^2}{2}$$, where $$A$$ is the amplitude of the signal. As far as the noise, we say its power is equal to the square of its standard deviation or $$\sigma^2$$. Then, the power of our fourth order transformation:

$$\tilde{z}^2(t)\tilde{z}^{*2}(t-T) = (s(t)+n(t))^2(s(t-T)+n(t-T)^{*2}$$

can be approximated, as far as power computation is concerned, by:

$$(\dfrac{A^2}{2})^4 + 4(\dfrac{A^2}{2})^3\sigma^2 + 6(\dfrac{A^2}{2})^2\sigma^4 + 4\dfrac{A^2}{2}\sigma^6 + \sigma^8$$

The first term in the summation is our signal while the rest are its noise components. Normalizing $$\sigma$$ to 1, the SNR is approximated by:
$$\dfrac{(\dfrac{A^2}{2})^4}{4(\dfrac{A^2}{2})^3 + 6(\dfrac{A^2}{2})^2 + 4\dfrac{A^2}{2} + 1}$$

In comparison to our $$s(t)$$ SNR which is $$\dfrac{A^2}{2}$$, we can see that the SNR of our fourth order transformation is about half (3 dB less) for strong signals, about a fourth (6 dB less) when the SNR of s(t) is zero (A is $$\sqrt{2}$$) and decreases rapidly for lower SNRs:

![SNR comparison][snr_comparison]{:.center-image}

We can see then how the degradation of this transformation is worse in presence of noise in comparison to the original signal $$s(t)$$. Still, it seems remarkably reliable, even when a considerable amount of noise is added to our original signal, to the point that its eye diagram starts to get all murky:

![Noisy signal differential phase eye diagram][diff_phase_eye_noise]{:.center-image}

the averaged S-curve still looks pretty much unaltered:

![S-curve of a noisy signal][s_curve_mean_noise]{:.center-image}

Of course we are using we whole signal to average the S-curve, this approach might not be practical in some applications where low latency is critical.

## Conclusion

This method shows great potential and an exploration of its limitations shows a number of avenues for further improvement:

* A data-driven approach: given that some symbol repetitions are detrimental to the method, they can be detected and skipped from the clock recovery stage, or perhaps the S-curve coming from those repeated symbols can be manipulated to make it better behaved.

* S-curve noise reduction: a number of different schemas can be applied to reduce the noise from the S-curve. The most immediate is to average values from a number of periods. The tradeoff here is that the longer our averaging, the more delay is added and the longer it will take for the method to synchronize, should this method be used for clock _acquisition_. An extended approach presented in some later papers by the same authors considered the autocorrelation also at multiples of $$T$$, taking in consideration that the sign flips at even multiples.

I'll leave it here for now.


[paper]:             https://www.researchgate.net/publication/3153478_A_digital_approach_to_clock_recovery_in_generalized_MSK
[book]:              https://www.springer.com/gp/book/9780306457258
[eye_diagram_tool]:  https://github.com/EdFuentetaja/EdFuentetaja.github.io/blob/master/tools/eye_diagram/eye_diagram.html
[bit_stuffing]:      https://en.wikipedia.org/wiki/Bit_stuffing
[paper2]:            https://pdfs.semanticscholar.org/1d4d/e1778988f346e4f1fe21ddd6b8d4266ed33d.pdf

[example_input]:     /images/DAndrea/phase_diff.png
[s_curve]:           /images/DAndrea/s_curve.png
[s_spectrum]:        /images/DAndrea/s_spectrum.png
[diff_phase_eye]:    /images/DAndrea/diff_phase_eye.png
[s_curve_eye]:       /images/DAndrea/s_curve_eye.png
[s_curve_mean]:      /images/DAndrea/s_curve_mean.png
[s_curve_eye_2]:     /images/DAndrea/s_curve_eye_2.png
[snr_comparison]:    /images/DAndrea/snr_comparison.png
[diff_phase_eye_noise]:    /images/DAndrea/diff_phase_eye_noise.png
[s_curve_mean_noise]:      /images/DAndrea/s_curve_mean_noise.png
