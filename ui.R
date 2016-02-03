library(shiny)

shinyUI(fluidPage(
  withMathJax(),
  tags$style(HTML("
                  p {
                  font-size: 18px;
                  font-weight: bold;
                  }
  
                  h4 {
                  font-size: 18px;
                  }

                  ")),
  tabsetPanel(
    tabPanel("Home",
             fluidRow(
               column(
                 width = 10, 
                 offset = 1,
               h1("Introduction to Beer's Law", align = "center"),
               br(),
               HTML("<p>Most introductory courses in chemistry include a
                 brief introduction to Beer's law, often in the
                 context of a laboratory experiment in which you
                 determine the concentration of a species, which
                 typically we call the analyte, by measuring its 
                 absorbance in a spectrophotometer and comparing its 
                 absorbance to that for one or more standard 
                 solutions. In this learning module we take a
                 closer look at Beer's law using the following series 
                 of investigations:</p>"),
               HTML("<ul> 
                    <li> 
                    <h4>Investigation 0: Recalling Beer's Law</h4>
                    </li> 
                    <li> 
                    <h4>Investigation 1: Absorbance Spectra</h4>
                    </li>
                    <li> 
                    <h4>Investigation 2: Calibration Curves</h4>
                    </li>
                    <li> 
                    <h4>Investigation 3: Fundamental Limitation to 
                     Beer's Law</h4>
                    </li>
                    <li> 
                    <h4>Investigation 4: Instrumental Limitation to 
                      Beer's Law: Polychromatic Radiation</h4>
                    <li>
                    <h4>Investigation 5: Instrumental Limitation to
                      Beer's Law: Stray Radiation</h4>
                    </li>
                    <li>
                    <h4>Investigation 6: Chemical Limitation to Beer's
                      Law</h4>
                    </li>
                    </ul>"),
               HTML("<p>You will find a more detailed discussion of 
                      the topics covered in this learning module in 
                      Chapter 10 of <em>Analytical Chemistry 2.0</em>, 
                      which is available using this 
                      <a href = http://bit.ly/1r3wJoz>link</a>.</p>")
             )
    )),
    tabPanel("Investigation 0",
             fluidRow(
               column(
                 width = 4,
                 h4("Recalling Beer's Law"),
                 helpText(
                   "The figure to the right shows two sets of four
                   cuvettes, each of which contains a solution of
                   the same analyte. The relative concentration of 
                   analyte in each cuvette is shown at the top of the  
                   figure. For each set of cuvettes there is a view    
                   from the side and a view from the top. The    
                   absorbance for each cuvette and for each of its   
                   views is indicated by the number within the   
                   cuvette. The scale on the figure's right side gives  
                   the dimensions of the cuvettes."
                 ),
                 helpText(
                   "Write out the mathematical equation for Beer's
                   law and explain how the information in this figure 
                   is consistent with your equation."
                 )
               ),
               column(
                 width = 8,
                br(),
                br(),
                imageOutput("image_0a")
               )
             )),
    tabPanel("Investigation 1",
             fluidRow(
               column(
                 width = 3,
                 h4("Absorbance Spectra"),
                 helpText(
                  "You are familiar with Beer's law in which
                  absorbance, \\(\\textit{A}\\), is a function of the
                  analyte's concentration, \\(\\textit{C}\\), the
                  pathlength light takes through the sample, 
                  \\(\\textit{b}\\), and the analyte's molar 
                  absorptivity, \\(\\epsilon\\).
                  $$A = \\epsilon bC$$
                  A spectrophotometer, however, does not measure
                  absorbance; instead, it measures the power of light
                  transmitted by a sample, \\(\\textit{P}_{sam}\\) 
                  relative to the power of light transmitted
                  by a reference, \\(\\textit{P}_{ref}\\). For
                  example, the plot to the right shows
                  \\(\\textit{P}_{sam}\\) in red and
                  \\(\\textit{P}_{ref}\\) in blue; the first six
                  values for each are shown in the table on the far
                  right."
                 ),
                 helpText(
                  "Download the data for \\(\\textit{P}_{ref}\\) and
                  for \\(\\textit{P}_{sam}\\) using the button below 
                  and create two plots, one that shows the sample's
                  transmittance as a function of the wavelength and
                  one that shows the sample's absorbance as a
                  function of the wavelength. When finished,
                  use the radio buttons below to check your work."
                 ),
                 radioButtons(
                   "radio_1a", label = h4("Display Format"),
                   choices = list("Power",
                                  "Transmittance",
                                  "Absorbance"),
                   selected = "Power"
                 ),
                 downloadButton("download_1a", "Download")
               ),
               column(
                 width = 6,
                plotOutput("plot_1a"),
                br(),
                helpText("The source of visible light is a 
                tungesten-halogen lamp. The source's original power 
                spectrum is from Thor labs (www.thorlabs.com) 
                and gives power as a function of wavelength from 
                400 nm to 850 nm in 10 nm intervals. This data 
                set was trimmed to the range 400 nm to 750 nm, 
                additional values at 1 nm intervals were added 
                using a linear interpolation over the 10 nm 
                intervals, and the result was stored as the 
                reference power spectrum. The power spectrum 
                for the sample is simulated data.")
                ),
               column(
                 width = 3,
                 align = "center",
                 br(),
                 br(),
                 br(),
                 tableOutput("table_1a")
               )
             )),
    tabPanel("Investigation 2",
             fluidRow(
               column(
                 width = 3,
                 h4("Calibration Curves"),
                 helpText(
                  "We know from Beer's law
                  $$A = \\epsilon bC$$
                  that there is a linear relationship between
                  absorbance and the concentration of analyte. The 
                  plot on the right displays the absorbance spectra 
                  for a blank and for five standard solutions of 
                  analyte with concentrations of 0.200, 0.400, 0.600, 
                  0.800, and 1.000 mM. Unlike the spectra in 
                  Investigation 1, noise with a standard deviation of 
                  0.2%T is added to the spectra. The table on the far 
                  right the shows the absorbance values for the blank 
                  and for the standards at the wavelength selected by 
                  the slider."),
                 helpText("Use the slider to select the optimum 
                  wavelength for a calibration curve and then use the 
                  calibration data to prepare a calibration curve, 
                  including the equation for the calibration curve. 
                  Explain the reason(s) for your choice of wavelength. 
                  When you are finished, use the check box to review 
                  your work. Using the slider to change the 
                  wavelength, how sensitive is your calibration model 
                  to the choice of wavelength?"
                 ),
                 sliderInput(
                   "slider_2a", "Analytical Wavelength (nm)", 
                    min = 400, max = 750, value = 400, step = 1
                 ),
                 checkboxInput("check_2a", label = "Show Model?", 
                               value = FALSE)
               ),
               column(
                 width = 6,
                plotOutput("plot_2a", height = "325px"),
                verbatimTextOutput("table_2b")
                ),
               column(
                 width = 3,
                 br(),
                 align = "center",
                 "Data for Calibration Standards",
                 br(),
                 "(concentrations in mM)",
                 tableOutput("table_2a")
               )
             )),
    tabPanel("Investigation 3",
             fluidRow(
               column(
                 width = 3,
                 h4("Fundamental Limitation to Beer's Law"),
                 helpText(
                  "The derivation of Beer's law makes several
                  important assumptions, one of which is that the
                  individual units of analyte—whether molecules or
                  ions—behave as independent absorbers. This
                  generally is true when the analyte's concentration
                  is sufficiently small, but is no longer true when
                  the concentration is sufficiently large."),
                 helpText("Using the
                  sliders below, explore how the choice of wavelength
                  and the analyte's concentration affect the 
                  calibration curve (note: the range of concentrations 
                  must include at least two points to return a slope
                  and an intercept). Over what range of concentrations 
                  do you obtain a linear calibration curve? Does the
                  choice of wavelength make a difference?"),
                 helpText("The highlighting in the upper plot shows 
                  the points included in the calibration curve, the
                  results for which are summarized on the right. The
                  spectra for the standards included in the
                  calibration curve are shown in the plot at the 
                  bottom of the page."),
                 sliderInput(
                   "slider_3b", "Analytical Wavelength (nm)", 
                    min = 400, max = 750, step = 1, value = 400
                 ),
                 sliderInput(
                   "slider_3a", "Concentration Range (mM)", min = 0,
                   max = 10, step = 0.1, value = c(0, 10)
                 )
               ),
               column(
                 width = 5,
                 plotOutput("plot_3a", height = "325px"),
                 plotOutput("plot_3b", height = "325px")
               ),
               column(
                 width = 4,
                 br(),
                 br(),
                 verbatimTextOutput("table_3a"))
             )),
    tabPanel("Investigation 4",
             fluidRow(
               column(
                 width = 4,
                 h4("Instrumental Limitation to Beer's Law"),
                 h5("Polychromatic Radiation"),
                 helpText("Another important assumption in the 
                          derivation of Beer's law is that the source
                          emits just a single wavelength of light. 
                          As we know from Investigation 1, the source
                          is continuous, emitting light at all 
                          wavelengths in our analytical window
                          of 400 nm to 750 nm."),
                 helpText("To explore the consequence of polychromatic
                          radiation for Beer's law, we will examine  
                          how the simultaneous absorbance of two  
                          wavelengths of light affects a calibration 
                          curve. The two sliders allow you to select 
                          the analytical wavelength (the wavelength 
                          for which we wish to measure and to report 
                          the absorbance), and to select the 
                          second, interfering wavelength of light. 
                          The four graphs to the right show the 
                          wavelengths selected and the resulting 
                          calibration curves. Results when using the 
                          analytical wavelength only are shown using a 
                          solid red line and results when including 
                          the second wavelength are shown using a 
                          dashed red line."),
                 helpText("The effect of polychromatic radiation may
                          lead to negative or to positive deviations
                          from Beer's law. What conditions favor a 
                          negative deviation? What conditions favor a
                          positive deviation? If you set the 
                          analytical wavelength to match the optimum 
                          wavelength from Investigation 2, is the
                          effect of the interferring wavelength the
                          same when the offset is positive and when
                          the offset is negative? If no, propose an
                          explanation for why."),
                 sliderInput(
                   "slider_4a", "Analytical Wavelength (nm)", 
                   min = 450, max = 700, step = 1, value = 450
                 ),
                 sliderInput(
                   "slider_4b", "Offset (± nm)", min = 0, 
                   max = 50, step = 5, value = 25
                 )
                 ),
               column(
                 width = 4,
                 align = "center",
                 plotOutput("plot_4a", height = "325px"),
                 plotOutput("plot_4b", height = "325px")
               ),
               column(
                 width = 4,
                 align = "center",
                 plotOutput("plot_4c", height = "325px"),
                 plotOutput("plot_4d", height = "325px")
               )
               )
             ),
    tabPanel("Investigation 5",
             fluidRow(
               column(
                 width = 4,
                 h4("Instrumental Limitation to Beer's Law"),
                 h5("Stray Radiation"),
                 helpText("Another important assumption in the 
                          derivation of Beer's law is that all
                          radiation that reaches the detector passes
                          through the sample. When this is not the 
                          case—whether from source radiation that 
                          bypasses the sample or outside light that  
                          leaks into the spectrometer—the result is
                          a deviation from Beer's law."),
                 helpText("Using the sliders below, explore the 
                          affect on Beer's law of stray radiation.
                          For this simulation, we assume that the
                          stray light is not absorbed by the analyte
                          and that the relative amount of stray light 
                          is the same for all wavelengths."),
                 helpText("Is the effect of stray light the same at 
                          all wavelengths? What conditions favor the 
                          greatest deviations from Beer's law? What 
                          conditions favor the smallest deviation from 
                          Beer's law?"),
                 sliderInput("slider_5a", 
                             "Analytical Wavelength (nm)",
                             min = 400, max = 750, step = 1, 
                             value = 400),
                 sliderInput("slider_5b", "% Stray Light",
                             min = 0, max = 25, step = 1,
                             value = 0)
               ),
               column(
                 width = 5,
                 plotOutput("plot_5a", height = "325px"),
                 plotOutput("plot_5b", height = "325px")
               ),
               column(
                 width = 3,
                 align = "center",
                 br(),
                 helpText("Calibration Data w/o Stray Light"),
                 helpText("(concentrations in mM)"),
                 tableOutput("table_5a"),
                 br(),
                 helpText("Calibration Data w/ Stray Light"),
                 helpText("(concentrations in mM)"),
                 tableOutput("table_5b")
               )
             )
             ),
    tabPanel("Investigation 6",
             fluidRow(
               column(
                 width = 6,
                 h4("Chemical Limitations to Beer's Law"),
                 helpText("In exploring the fundamental and the 
                          instrumental limitations to Beer's law
                          we assumed—without comment—that we did not
                          need to consider the analyte's reactivity; 
                          that is, we assumed that in the absence of a
                          fundamental or an instrumental limitation, a
                          plot of absorbance vs. concentration is 
                          a straight-line for all concentrations of 
                          analyte. Let's test this assumption by 
                          assuming that our analyte is a weak acid and 
                          that only its conjugate weak acid form (or
                          its conjguate weak base form) absorbs light. 
                          Use the sliders and the radio button to 
                          explore how the choice of wavelength, the 
                          value of the analyte's 
                          \\(\\textrm{p}{K}_{a}\\), and the 
                          identity of the absorbing species affects 
                          the Beer's law calibration curve. Can you 
                          explain your results in terms of the 
                          analyte's acid-base chemistry?"),
                 sliderInput("slider_6a", 
                             "Analytical Wavelength (nm)",
                             min = 400, max = 750, step = 1, 
                             value = 400),
                 sliderInput("slider_6b", 
                             "Analyte's \\(\\textrm{p}{K}_{a}\\)",
                             min = 0, max = 14, step = 1,
                             value = 5),
                 radioButtons("radio_6a", "Absorbing Species", 
                              choices = c("HA", 
                                          "\\(\\textrm{A}^{-}\\)"),
                              selected = "HA", inline = "TRUE"),
                 helpText("How might controlling pH affect the 
                          calibration curve? For an analyte with a
                          \\(\\textrm{p}{K}_{a}\\) of 5, explore the                     
                          affect of pH by entering different values   
                          in the text box. What is the optimum pH when
                          HA is the absorbing species? When 
                          \\(\\textrm{A}^{-}\\) is the absorbing
                          species?"),
                 radioButtons("radio_6b", "Buffer pH?",
                              choices = c("yes", "no"), 
                              selected = "no", inline = "TRUE"),
                 sliderInput("slider_6c", "Select pH", min = 0, 
                             max = 14, step = 0.2, value = 7)
               ),
               column(
                 width = 6,
                 plotOutput("plot_6a", height = "325px"),
                 plotOutput("plot_6b", height = "325px")
               )
             ))
  )
))