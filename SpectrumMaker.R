# design and return an absorbance spectrum for a sample over a
# range of wavelengths from 400 nm to 750 nm in steps of 1 nm
makeSpectrum = function(p.position = c(450, 550, 650), 
                        p.width = c(30, 30, 20), 
                        p.height = c(25, 10, 50),
                        show.curves = FALSE, 
                        add.noise = TRUE,
                        sd.noise = 0.005){
  wavelength = seq(400, 750, 1)
  num.peaks = length(p.position)
  abs = matrix(0, nrow = length(wavelength), ncol = num.peaks)
  for (i in 1: num.peaks){
    abs[ , i] = (1/sqrt(2*pi*p.width[i]^2))*
      exp(-(wavelength - p.position[i])^2/(2*pi*p.width[i]^2)) * p.height[i]
  }
  absorbance = rowSums(abs)
  # abs1 = (1/sqrt(2*pi*p.width[1]^2))*
  #   exp(-(wavelength - p.position[1])^2/(2*pi*p.width[1]^2)) * p.height[1]
  # abs2 = (1/sqrt(2*pi*p.width[2]^2))*
  #   exp(-(wavelength - p.position[2])^2/(2*pi*p.width[2]^2)) * p.height[2]
  # abs3 = (1/sqrt(2*pi*p.width[3]^2))*
  #   exp(-(wavelength - p.position[3])^2/(2*pi*p.width[3]^2)) * p.height[3]
  # absorbance = abs1 + abs2 + abs3
  if (add.noise == TRUE) {
    absorbance = absorbance + rnorm(length(wavelength), mean = 0, sd = sd.noise)
  }
  plot(wavelength, absorbance, type = "l", col="blue", lwd = 2,
       ylim = c(0, max(absorbance)))
  grid()
  if (show.curves == TRUE) {
    for (i in 1:num.peaks) {
      lines(wavelength, abs[ , i], type = "l", lty = 2, col = "red")
    }
  # lines(wavelength, abs1, type = "l", lty = 2, col = "red")
  # lines(wavelength, abs2, type = "l", lty = 2, col = "red")
  # lines(wavelength, abs3, type = "l", lty = 2, col = "red")
  }
  out = list("wavelengths" = wavelength, "absorbance" = absorbance)
  invisible(out)
}


