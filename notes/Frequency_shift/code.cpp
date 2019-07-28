
#include <iostream>
#include <complex>
#include <fstream>

#include <gtest/gtest.h>

int16_t to_int16(int32_t v) {

    // Saturate to the [-32768, 32767] range
    return (v > 32767)? 32767 : (v < -32768)? -32768 : (int16_t)v;
}

int16_t to_int16(float v) {

    v = roundf(v);
    // Saturate to the [-32768, 32767] range
    return (v > 32767.0f)? 32767 : (v < -32768.0f)? -32768 : (int16_t)v;
}

std::complex<int16_t> multiply_i16(const std::complex<int16_t>& a, const std::complex<int16_t>& b) {

    int32_t re_a = std::real(a);
    int32_t im_a = std::imag(a);
    int32_t re_b = std::real(b);
    int32_t im_b = std::imag(b);

    int32_t re_c = re_a*re_b - im_a*im_b;
    int32_t im_c = re_a*im_b + im_a*re_b;

    return std::complex<int16_t>(to_int16(re_c >> 15), to_int16(im_c >> 15));
}

void main()
{
    float fs = 96000.0f;
    float fd =  3000.0f;

    float rads_per_sample = 2.0f*M_PI*fd/fs;

    std::complex<int16_t> phasor(32767, 0);
    std::complex<int16_t> pps[2];
    pps[0] = std::complex<int16_t>(to_int16(cosf(rads_per_sample)*32768.0f),
                                   to_int16(sinf(rads_per_sample)*32768.0f));
    pps[1] = std::complex<int16_t>(std::real(pps[0])+1, std::imag(pps[0]));

    std::cout << "p_0: " << pps[0] << std::endl;
    std::cout << "p_1: " << pps[1] << std::endl;

    unsigned int counter = 0;
    unsigned int pps_to_use = 1;
    std::ofstream ofs("pp.txt");
    for (unsigned int i=0; i<100000; i++) {
        ofs << std::real(phasor) << "," << std::imag(phasor) << std::endl;
        phasor = multiply_i16(phasor, pps[pps_to_use]);

        // Calculate the squared magnitude of the phasor
        {
            int32_t x = (int32_t)std::real(phasor);
            int32_t y = (int32_t)std::imag(phasor);
            int32_t m = x*x + y*y;
            if (m > 32768*32768) {
                pps_to_use = 0; // Too big, use the small one
            } else {
                pps_to_use = 1; // Too small, use the big one
            }
        }

        /*
        counter++;
        if (counter >= 512) {
            float x = ((float)std::real(phasor))/32768.0f;
            float y = ((float)std::imag(phasor))/32768.0f;
            float magnitude = sqrtf(x*x + y*y);
            phasor = std::complex<int16_t>(roundf((float)std::real(phasor)/magnitude),
                                           roundf((float)std::imag(phasor)/magnitude));
            counter = 0;
        }
        */
    }
    ofs.close();
}