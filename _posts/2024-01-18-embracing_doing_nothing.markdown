---
title:  "Embracing doing nothing"
date:   2024-01-18 00:00:00 +0800
categories: SDR
excerpt: "Sometimes doing nothing is the best course of action. A symbol timing tracking situation is presented."
header:
  image: "great_pyramid_cropped_c.jpg"
---

We already understand what symbol timing tracking (aka "clock recovery" or "timing recovery") is and why it's important for the successful recovery of a digital signal. Using the following "eye diagram" as reference:

![Eye pattern][eye_pattern]{:.center-image}
*Image credit: [Wikipedia][eye_pattern_wikipedia]*
{: style="text-align: center;"}

we see that the maximum gap in the "eye" corresponds to the 0 point in the x-axis, representing the timing phase. This is our best chance at recovering our data. At any other sampling point the gap in the eye is smaller, indicating a penalty in the signal SNR. Notice how the eye is completely closed at timing phase -0.5 or 0.5: when our timing error is so bad, our chances of making mistakes are very high.

Symbol timing tracking is important because transmitter and receiver run with different clocks, so, even if we manage to achieve a pretty good initial timing phase estimation, the different pace of the clocks will make this phase drift, forward or backwards and we will see how our signal quality drops until the point we lose it. I have dedicated some time to review some of the classical algorithms, such as [M&M][m_m] or [D'Andrea][dandrea]. I'm going to dedicate this brief note to explain the process that took me to undestand why timing tracking was not required in one particular application. 

This example is going to be again based on [AIS][AIS]. AIS is a maritime safety system that ships use to broadcast its location (coming from a GPS receiver) among other important information (speed, bearing, etc.). AIS was developed in the 1990s and it uses practical technology from this date, which predates the era of SDR and more sophisticated communication systems. The signal specs for our purposes in this note, can be summarized as:
* [GMSK modulation][GMSK].
* 9600 baud.
* Typical message length is 168 bits, including training sequence, markers and other overheads, about 200 symbols ("symbol" and "bit" are used interchangeably here since GMSK encodes one bit per symbol.)
* Frequency band: around 162 MHz.

Let's say that we are tasked with designing a symbol tracking module for AIS. There is one more relevant piece of information that we find in the AIS standard ([recommendation ITU-R M.1371-5 (02/2014)][AIS_standard]):

![AIS spec][AIS_spec]{:.center-image}

This _ppm_ means "parts per million", so an AIS transponder is expected to transmit at a symbol rate within the [9599.99995, 9600.00005] baud range. This means that, in the worst-case scenario, after 1/50e-6 = 20k seconds we are going to receive one bit less (or more) of what would be expected at the exact symbol rate of 9600 baud, or, in other words, after 20k seconds our timing phase error is going to have accumulated to ±1 normalized units. For a working system we should aim for a bigger margin since we have already seen that an error of ±0.5 is critical. We should design our system to stay within a timing phase error of [-0.25, 0.25] units. For a transmitter with a clock error rate of 50 ppm, starting with a perfect knowledge of the timing phase (timing phase error = 0), the error will increase to 0.25 after 20k*0.25 = 5k seconds or about one hour and 23 minutes.

What does this means in terms on our AIS signal? In practical matters, very little, since our AIS message only last for about 21 ms (200 symbols/9600 symbols/s = 20.83 ms). With an error rate of 50 ppm, after 21 ms we should expect a phase error of 21e-3*50e-6 = 1.05e-6 normalized units, which in practice is nothing, much below anything we can measure.

However, this is only one half of the equation, the _transmitting side_. The other half comes from the _receiving_ side. What's the expected error rate on a typical SDR hardware? It depends. Amateur hardware is already coming out with decent specs, see for instance, the [RTL-SDR V3][RTL_SDR_V3] that comes with a temperature-controlled cristal oscilator (TCXO) with ±1 ppm frequency stability, which is pretty good.

![TCXO][TCXO]{:.center-image}
*"[SMD Cystal Oscillator TCXO](https://commons.wikimedia.org/w/index.php?curid=23855851)" by [Appaloosa](https://commons.wikimedia.org/wiki/User:Appaloosa) is licensed under CC BY 3.0.*
{: style="text-align: center;"}

Speaking about frequency stability, ±1 ppm means that an oscillator labeled as 1 MHz should be expected to resonate at a frequency in the range of [999999, 1000001] Hz. This is the starting point to translate this spec to a timing phase error rate. The next step comes from understanding that in common SDR designs this oscillator drives is the source from all the different clocks required by different hardware modules, including the important analog-to-digital converter (ADC). The ADC is programmed to run a some specific sampling rate and this sampling rate is derived from the oscillator using some phase-locked loop or equivalent circuitry. The main idea is that the oscillator frequency is going to be multiplied by some rational number into our intended sampling rate.

It's typical 


[eye_pattern]:           /images/Doing_nothing/Binary_PSK_eye_diagram.svg.png
[eye_pattern_wikipedia]: https://en.wikipedia.org/wiki/Eye_pattern
[m_m]:                   /sdr/m_m_analysis/
[dandrea]:               /sdr/dandrea_clock_recovery/
[AIS]:                   https://en.wikipedia.org/wiki/Automatic_identification_system
[GMSK]:                  https://en.wikipedia.org/wiki/Minimum-shift_keying#Gaussian_minimum-shift_keying
[AIS_standard]:          https://www.itu.int/dms_pubrec/itu-r/rec/m/R-REC-M.1371-5-201402-I!!PDF-E.pdf
[AIS_spec]:              /images/Doing_nothing/AIS_spec.png
[RTL_SDR_V3]:            https://www.rtl-sdr.com/wp-content/uploads/2018/02/RTL-SDR-Blog-V3-Datasheet.pdf
[TCXO]:                  /images/Doing_nothing/SMD_Cystal_Oscillator_TCXO.png
