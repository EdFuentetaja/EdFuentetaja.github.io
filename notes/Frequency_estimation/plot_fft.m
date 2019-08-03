function plot_fft(s, fs)

  n=numel(s);
  df = fs/n;
  ff=(0:(n-1))*df;
  ff(ff >= fs/2) = ff(ff >= fs/2) - fs;
  % now, X and f are aligned with one another; if you want frequencies in strictly
  % increasing order, fftshift() them
  %plot(fftshift(ff), 20*log10(abs(fftshift(fft(s)))), '*-');
  plot(fftshift(ff), 20*log10((abs(fftshift(fft(s))))/n), '*-');
  %plot(20*log10(abs(fft(s))), '*-');
  %plot(fftshift(ff), (arg(fftshift(fft(s)))), '*-');

  grid on
  %h = findobj(gca, 'type', 'line');
  set(gca, "fontsize", 16)
  xlabel("Frequency (Hz)")
  ylabel("Magnitude (dB)")
  ylabel("Power (dB)")
end