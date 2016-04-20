library(shiny)

# load in the file BL.RData, which contains two objects: rawdata
# and std.conc

# rawdata is a data frame with 351 rows (which span wavelengths from
# 400 nm to 750 nm), and 20 columns for the wavelengths, noise-free 
# absorbance and transmittance values for a standard sample (5.0 mM in  
# analyte), noise-free power spectra for the reference and for the 
# standard sample, eb values, and absorbances for a blank and for 13 
# standards, each of which included random noise drawn from a normal 
# distribution characterized by a standard deviation of 0.2% T.

# std.conc is a vector of length 14 that contains the concentrations
# of analyte in a blank and in 13 standards

load(file = "BL.RData")

shinyServer(function(input, output) {
  
  # actions for Investigation 1
  
  output$image_1a = renderImage({
    list(src = "www/Cuvettes.png")
  }, deleteFile = FALSE)
  
  # actions for 1nvestigation 2
  
  datasetInput = reactive({
    switch(
      input$radio_2a,
      "Power" = head(rawdata[ , c(1, 4, 5)]),
      "Transmittance" = head(rawdata[ , c(1, 3, 2)]),
      "Absorbance" = head(rawdata[ , c(1, 2, 3)])
    )
  })
  
  output$plot_2a = renderPlot({
    if (input$radio_2a == "Power") {
      plot(
        rawdata$wavelength, rawdata$p_ref, type = "l",
        lwd = 2, col = "blue", ylim = c(0,1), 
        xlab = "wavelength (nm)",
        ylab = "power (arb. units)"
      )
      lines(
        rawdata$wavelength, rawdata$p_sam,
        type = "l", lwd = 2, col = "red"
      )
      legend(x = "topleft", legend = c("reference", "sample"), bty = "n",
             col = c("blue", "red"), lty = c(1, 1), lwd = c(2, 2)
      )
    }
    if (input$radio_2a == "Transmittance") {
      plot(
        rawdata$wavelength, rawdata$trans, type = "l",
        lwd = 2, col = "blue", ylim = c(0, 1), 
        xlab = "wavelength (nm)",
        ylab = "transmittance"
      )
    }
    if (input$radio_2a == "Absorbance") {
      plot(
        rawdata$wavelength, rawdata$abs, type = "l", lwd = 2,
        col = "blue", ylim = c(0, 1.2), xlab = "wavelength (nm)",
        ylab = "absorbance"
      )
    }
  })
  
  output$table_2a = renderTable({
    datasetInput() 
  }, digits = c(1, 0, 4, 4), align = rep("c", 4))
  
  output$download_2a = downloadHandler(
    filename = "beersLaw.csv",
    content = function(file) {
      write.csv(rawdata[ , c(1, 4, 5)], file)
    }
  )
  
  # actions for investigation 3
  
  caldata_3a = reactive({
    conc = noquote(sprintf("%.3f", std.conc[c(1, 3, 4, 6, 7, 8)]))
    abs = as.numeric(rawdata[input$slider_3a - 399, 
                                    c(7, 9, 10, 12, 13, 14)])
    data.frame(conc, abs)
  })
  
  calmodel_3a = reactive({
    if (input$check_3a == TRUE) { 
      conc = std.conc[c(1, 3, 4, 6, 7, 8)]
      abs = as.numeric(rawdata[input$slider_3a - 399, 
                               c(7, 9, 10, 12, 13, 14)])
      summary(lm(abs ~ conc))
    }
  })
  
  output$plot_3a = renderPlot({
    if (input$check_3a == FALSE) {
        matplot(rawdata$wavelength, 
            as.matrix(rawdata[, c(7, 9, 10, 12, 13, 14)]), 
            type = "l", lty = 1, lwd = 2, col = "blue",
            xlab = "wavelength (nm)", ylab = "absorbance", 
            ylim = c(0, 0.2))
    abline(v = input$slider_3a, col = "red", lwd = 2)
    } else {
      conc = std.conc[c(1, 3, 4, 6, 7, 8)]
      abs = as.numeric(rawdata[input$slider_3a - 399, 
                               c(7, 9, 10, 12, 13, 14)])
      plot(conc, abs, pch = 19, cex = 1.2, col = "blue", 
           xlab = "concentration (mM)", ylab = "absorbance", 
           ylim = c(0, 0.2))
      abline(lm(abs ~ conc), col = "red", lwd = 2)
    }
  })
  
  output$table_3a = renderTable({
    caldata_3a()
  }, digits = c(1, 4, 4), align = rep("c", 3))
  
  output$table_3b = renderPrint({
    calmodel_3a()
  })
  
  # actions for Investigation 4
  
  calmodel_4a = reactive({
    # abs = as.numeric(rawdata[250, c(7:20)])
    abs = as.numeric(rawdata[input$slider_4b - 399, c(7:20)])
    conc = std.conc
    data = data.frame(conc, abs)
    data = data[data$conc >= input$slider_4a[1] & 
                      data$conc <= input$slider_4a[2], ]
    summary(lm(data$abs ~ data$conc))
  })
  
  output$plot_4a = renderPlot({
    plot(std.conc, rawdata[input$slider_4b - 399, 7:20], pch = 19,
         col = "blue", xlab = "concentration (mM)", 
         ylab = "absorbance", ylim = c(0, 1.5))
    abs = as.numeric(rawdata[input$slider_4b - 399, c(7:20)])
    conc = std.conc
    data = data.frame(conc, abs)
    data = data[data$conc >= input$slider_4a[1] & 
                  data$conc <= input$slider_4a[2], ]
    if (length(data$conc) >= 2) {
      mod = lm(data$abs ~ data$conc)
      abline(mod, col = "blue", lwd = 2)
      rect(input$slider_4a[1],-1,input$slider_4a[2],2, border = NA,  
           col = rgb(255, 229, 204, 100, max = 255))
    }
  })
  
  output$plot_4b = renderPlot({
    index = 7:20
    conc = std.conc
    df = data.frame(index, conc)
    df = df[df$conc >= input$slider_4a[1] &
              df$conc <= input$slider_4a[2], ]
    matplot(rawdata$wavelength, as.matrix(rawdata[ , df$index]), 
            type = "l", lty = 1, col = "blue", lwd = 2, 
            xlab = "wavelength (nm)", ylab = "absorbance")
    abline(v = input$slider_4b, col = "red", lwd = 2)
  })
  
  output$table_4a = renderPrint({
    calmodel_4a()
  })
  
 # actions for Investigation 5 
  
  output$plot_5a = renderPlot({
    matplot(rawdata$wavelength, as.matrix(rawdata[ , 7:15]),
            type = "l", lty = 1, col = "blue", lwd = 2,
            xlab = "wavelength (nm)", ylab = "absorbance",
            ylim = c(0, 0.4))
    abline(v = input$slider_5a, lty = 1, col = "red", lwd = 2)
    abline(v = input$slider_5a - input$slider_5b, lty = 2,
           col = "red", lwd = 2)
    legend(
      x = "topleft", 
      legend = c("analytical wavelength", "interfering wavelength"),
      col = c("red", "red"), lty = c(1, 2), lwd = c(2, 2), bty = "n"
    )
  })
  
  output$plot_5b = renderPlot({
    p1 = rawdata$p_ref[input$slider_5a - 399]
    p2 = rawdata$p_ref[input$slider_5a - input$slider_5b - 399]
    eb1 = rawdata$eb[input$slider_5a - 399]/1000
    eb2 = rawdata$eb[input$slider_5a - input$slider_5b - 399]/1000
    conc = seq(0,2,0.02)
    abs1 = -log10((p1*10^-(eb1*conc))/(p1))
    plot(conc, abs1, type = "l", lty = 1, lwd = 2, col = "red",
         xlab = "concentration (mM)", ylab = "absorbance",
         main = "analytical wavelength with negative offset",
         ylim = c(0, 0.4))
    abs2 = -log10((p1*10^-(eb1*conc) + p2*10^-(eb2*conc))/(p1 + p2))
    lines(conc, abs2, lty = 2, lwd = 2, col = "red")
    legend(
      x = "topleft", 
      legend = c("analytical wavelength only", "both wavelengths"),
      col = c("red", "red"), lty = c(1, 2), lwd = c(2, 2), bty = "n"
    )
  })
  
  output$plot_5c = renderPlot({
    matplot(rawdata$wavelength, as.matrix(rawdata[ , 7:15]),
            type = "l", lty = 1, col = "blue", lwd = 2,
            xlab = "wavelength (nm)", ylab = "absorbance",
            ylim = c(0, 0.4))
    abline(v = input$slider_5a, lty = 1, col = "red", lwd = 2)
    abline(v = input$slider_5a + input$slider_5b, lty = 2,
           col = "red", lwd = 2)
    legend(
      x = "topleft", 
      legend = c("analytical wavelength", "interfering wavelength"),
      col = c("red", "red"), lty = c(1, 2), lwd = c(2, 2), bty = "n"
    )
  })
  
  output$plot_5d = renderPlot({
    p1 = rawdata$p_ref[input$slider_5a - 399]
    p2 = rawdata$p_ref[input$slider_5a + input$slider_5b - 399]
    eb1 = rawdata$eb[input$slider_5a - 399]/1000
    eb2 = rawdata$eb[input$slider_5a + input$slider_5b - 399]/1000
    conc = seq(0,2,0.02)
    abs1 = -log10((p1*10^-(eb1*conc))/(p1))
    plot(conc, abs1, type = "l", lty = 1, lwd = 2, col = "red",
         xlab = "concentration (mM)", ylab = "absorbance",
         main = "analytical wavelength with positive offset",
         ylim = c(0, 0.4))
    abs2 = -log10((p1*10^-(eb1*conc) + p2*10^-(eb2*conc))/(p1 + p2))
    lines(conc, abs2, lty = 2, lwd = 2, col = "red")
    legend(
      x = "topleft", 
      legend = c("analytical wavelength only", "both wavelengths"),
      col = c("red", "red"), lty = c(1, 2), lwd = c(2, 2), bty = "n"
    )
  })
  
  # actions for Investigation 6
  
  output$plot_6a = renderPlot({
    matplot(rawdata$wavelength, as.matrix(rawdata[ , 7:15]),
            type = "l", lty = 1, col = "blue", lwd = 2,
            xlab = "wavelength (nm)", ylab = "absorbance",
            ylim = c(0, 0.4))
    abline(v = input$slider_6a, lty = 1, col = "red", lwd = 2)
  })
  
  output$plot_6b = renderPlot({
    p_ref = rawdata$p_ref[input$slider_6a - 399]
    p_stray = p_ref * input$slider_6b/100
    eb = rawdata$eb[input$slider_6a - 399]/1000
    conc = seq(0,2,0.02) 
    abs1 = -log10((p_ref * 10^-(eb*conc))/p_ref)
    abs2 = -log10((p_ref * 10^-(eb*conc) + p_stray)/(p_ref + p_stray))
    plot(conc, abs1, type = "l", lwd = 2, col = "red", 
         xlab = "concentration (mM)", ylab = "absorbance", 
         ylim = c(0,0.4))
    lines(conc, abs2, lty = 2, lwd = 2, col = "red")
    legend(x = "topleft", 
           legend = c("without stray light", "with stray light"),
           col = c("red", "red"), lty = c(1, 2), lwd = c(2, 2), 
           bty = "n")
  })
  
  caldata_6a = reactive({
    conc = c(0, 0.2, 0.4, 0.6, 0.8, 1, 2)
    p_ref = rawdata$p_ref[input$slider_6a - 399]
    p_stray = p_ref * input$slider_6b/100
    eb = rawdata$eb[input$slider_6a - 399]/1000
    abs = -log10((p_ref * 10^-(eb*conc))/p_ref)
    conc = noquote(sprintf("%.3f", conc))
    data.frame(conc, abs)
  })
  
  caldata_6b = reactive({
    conc = c(0, 0.2, 0.4, 0.6, 0.8, 1, 2)
    p_ref = rawdata$p_ref[input$slider_6a - 399]
    p_stray = p_ref * input$slider_6b/100
    eb = rawdata$eb[input$slider_6a - 399]/1000
    abs = -log10((p_ref * 10^-(eb*conc) + p_stray)/(p_ref + p_stray))
    conc = noquote(sprintf("%.3f", conc))
    data.frame(conc, abs)
  })
  
  output$table_6a = renderTable({
    caldata_6a()
  }, align = c("c", "c", "c"), digits = c(1, 1, 4))
  
  output$table_6b = renderTable({
    caldata_6b()
  }, align = c("c", "c", "c"), digits = c(1, 1, 4))
  
  # actions for Investigation 7
  
  output$plot_7b = renderPlot({
    if (input$radio_7b == "no") {
    p_ref = rawdata$p_ref[649 - 399]
    eb = rawdata$eb[649 - 399]/1000
    conc = seq(0,2,0.02) 
    abs1 = -log10((p_ref * 10^-(eb*conc))/p_ref)
    plot(conc, abs1, type = "l", lwd = 2, col = "red",
         xlab = "concentration (mM)", ylab = "absorbance",
         ylim = c(0, 0.4))
    ka = 10^-input$slider_7b
    root = rep(0,101)
    for (i in 1:101) {
      eqn = function(x){
        x^2 + ka * x - ka * conc[i]/1000
      }
      root[i] = uniroot(eqn, lower = 0, upper = 0.1, 
                        tol = 1e-18)$root * 1000
    }
    if (input$radio_7a == "HA") {
      conc_ha = (conc - root)
      abs2 = -log10((p_ref * 10^-(eb*conc_ha))/p_ref)
      lines(conc, abs2, type = "l", lty = 2, lwd = 2, col = "red")
      legend(x = "topleft", 
             legend = c("no acid-base chemistry", 
                        "w/ acid-base chemistry: only HA absorbs"), 
             col = c("red", "red"), lty = c(1, 2), lwd = c(2, 2), 
             bty = "n")
    } else {
      conc_a = root
      abs2 = -log10((p_ref * 10^-(eb*conc_a))/p_ref)
      lines(conc, abs2, type = "l", lty = 2, lwd = 2, col = "red")
      legend(x = "topleft",
             legend = c("no acid-base chemistry",
                        "w/ acid-base chemistry: only A absorbs"),
             col = c("red", "red"), lty = c(1, 2), lwd = c(2,2), 
             bty = "n")
    }
    } else {
      p_ref = rawdata$p_ref[649 - 399]
      eb = rawdata$eb[649 - 399]/1000
      conc = seq(0,2,0.02) 
      abs1 = -log10((p_ref * 10^-(eb*conc))/p_ref)
      plot(conc, abs1, type = "l", lwd = 2, col = "red",
           xlab = "concentration (mM)", ylab = "absorbance",
           main = "solution buffered", ylim = c(0, 0.4))
      ka = 10^-input$slider_7b
      h = 10^-input$slider_7c
      alpha_ha = h^2/(h^2 + ka * h)
      alpha_a = 1 - alpha_ha
      if (input$radio_7a == "HA") {
        conc_ha = alpha_ha * conc
        abs2 = -log10((p_ref * 10^-(eb*conc_ha))/p_ref) 
        lines(conc, abs2, type = "l", lty = 2, lwd = 2, col = "red")
        legend(x = "topleft", 
               legend = c("no acid-base chemistry", 
                          "w/ acid-base chemistry: only HA absorbs"), 
               col = c("red", "red"), lty = c(1, 2), lwd = c(2, 2),
               bty = "n")
      } else {
        conc_a = alpha_a * conc
        abs2 = -log10((p_ref * 10^-(eb*conc_a))/p_ref)
        lines(conc, abs2, type = "l", lty = 2, lwd = 2, col = "red")
        legend(x = "topleft",
               legend = c("no acid-base chemistry",
                          "w/ acid-base chemistry: only A absorbs"),
               col = c("red", "red"), lty = c(1, 2), lwd = c(2,2), 
               bty = "n")
      }
    }
  })
  
  output$image_reva = renderImage({
    list(src = "www/abstranpower.png")
  }, deleteFile = FALSE)
  
})
