# source and run the function to make the standard spectrum
# using the function's default values
source(file = "SpectrumMaker.R")
std.spec = makeSpectrum()

# read in power spectrum for source (which we treat as reference),
# add in additional values by interpolation, and print to review;
# data from Thor Labs (www.thorlabs.com) and is for a tungsten-
# halogen lamp
source = read.csv(file = "source.csv")
wavelength = seq(1:351)
power = seq(1:351)
for (j in seq(400,740,10)) {
  for(i in 0:9){
    lambda = j + i
    p = 0.1 * (lambda - j) * (source$power[0.1*(j-390)+1] - source$power[0.1*(j-400)+1]) + source$power[0.1*(j-400)+1]
    wavelength[j + i - 399] = lambda
    power[j + i - 399] = p
  }
  wavelength[351] = 750
  power[351] = source$power[36]
}
source = data.frame(wavelength, power)
plot(source, type = "l", col = "blue", lwd = 2, ylim = c(0,1))

# create a dataframe, fill with zeros, and name columns
df = as.data.frame(matrix(0, nrow = 351, ncol = 20))
colnames(df) = c("wavelength", "abs", "trans", "p_ref", "p_sam", "eb", 
                 "0_mM", "0.1_mM", "0.2_mM", "0.4_mM", "0.5_mM", 
                 "0.6_mM", "0.8_mM", "1.0_mM", "2.0_mM", "4.0_mM", 
                 "5.0_mM", "6.0_mM", "8.0_mM", "10.0_mM"
                 )

# fill the first six columns with pure data (no noise or corrections
# for fundamental limitation to Beer's law); eb values are calculated
# using a concentration of 0.005 M for the standard spectrum
df$wavelength = seq(400,750,1)
df$abs = std.spec$absorbance
df$trans = 10^-df$abs
df$p_ref = source$power
df$p_sam = df$trans * df$p_ref
df$eb = df$abs/0.005

# vectors with concentrations of standards (in mM) and with
# corrections to account for fundamental limitation to Beer's law
conc = c(0, 0.1, 0.2, 0.4, 0.5, 0.6, 0.8, 1.0, 2.0, 4.0, 5.0, 6.0,
         8.0, 10.0)
corr = c(1.000, 0.9987, 0.9974, 0.9948, 0.9934, 0.9922, 0.9896, 
         0.9870, 0.9624, 0.9271, 0.9040, 0.8835, 0.8316, 0.7733)

# loop to calculate the absorbance of standards (the factor of 1000
# accounts for use of mM concentrations), with corrections included
# to account for the fundamental limitation of Beer's law and with
# 0.2%T noise added to the data
for (i in 7:20){
  for (j in 1:351) {
    df[j, i] = df[j, 6] * (conc[i - 6]/1000) * corr[i - 6]
    df[j, i] = -log10(10^-df[j, i] + rnorm(1, 0, 0.002))
  }
}

# check to see if data looks okay
matplot(df$wavelength, as.matrix(df[ , 7:20]),
        type = "l", lty = 1, lwd = 2, col = "blue",
        xlab = "wavelength", ylab = "absorbance")
head(df)
