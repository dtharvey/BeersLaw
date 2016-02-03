# design and return an absorbance spectrum for a sample over a
# range of wavelengths from 400 nm to 750 nm in steps of 1 nm
makeSpectrum = function(p.position = c(450, 550, 650), 
                        p.width = c(30, 30, 20), 
                        p.height = c(25, 10, 50)){
  wavelength = seq(400, 750, 1)
  abs1 = (1/sqrt(2*pi*p.width[1]^2))*
    exp(-(wavelength - p.position[1])^2/(2*pi*p.width[1]^2)) * p.height[1]
  abs2 = (1/sqrt(2*pi*p.width[2]^2))*
    exp(-(wavelength - p.position[2])^2/(2*pi*p.width[2]^2)) * p.height[2]
  abs3 = (1/sqrt(2*pi*p.width[3]^2))*
    exp(-(wavelength - p.position[3])^2/(2*pi*p.width[3]^2)) * p.height[3]
  absorbance = abs1 + abs2 + abs3
  plot(wavelength, absorbance, type = "l", col="blue", lwd = 2)
  lines(wavelength, abs1, type = "l", lty = 2, col = "red")
  lines(wavelength, abs2, type = "l", lty = 2, col = "red")
  lines(wavelength, abs3, type = "l", lty = 2, col = "red")
  spectrum = data.frame(wavelength,absorbance)
  invisible(spectrum)
}


