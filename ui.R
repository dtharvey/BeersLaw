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
        
                  h5 {
                  font-size: 16px;
                  font-weight: bold;
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
                    <h4>Investigation 1: Recalling Beer's Law</h4>
                    </li> 
                    <li> 
                    <h4>Investigation 2: Absorbance Spectra</h4>
                    </li>
                    <li> 
                    <h4>Investigation 3: Calibration Curves</h4>
                    </li>
                    <li> 
                    <h4>Investigation 4: Fundamental Limitation to 
                     Beer's Law</h4>
                    </li>
                    <li> 
                    <h4>Investigation 5: Instrumental Limitation to 
                      Beer's Law: Polychromatic Radiation</h4>
                    <li>
                    <h4>Investigation 6: Instrumental Limitation to
                      Beer's Law: Stray Radiation</h4>
                    </li>
                    <li>
                    <h4>Investigation 7: Chemical Limitation to Beer's
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
    tabPanel("Investigation 1",
             fluidRow(
               column(
                 width = 4,
                 h4("Recalling Beer's Law"),
                 helpText(
                   "You may recall that Beer's law describes how a sample's
                    absorbance, \\(\\textit{A}\\), is a function of the
                    analyte's concentration, \\(\\textit{C}\\), the
                    pathlength light travels through the sample, 
                    \\(\\textit{b}\\), and the analyte's molar 
                    absorptivity, \\(\\epsilon\\)
                    $$A = \\epsilon bC$$"
                    ),
                 h5("Questions"),
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
                  "1. Show that the information in this figure   
                  is consistent with the equation for Beer's Law."
                  ),
                 helpText(
                   "2. Although the meanings of absorbance, pathlength,  
                   and concentration are self-explantory, the meaning
                   of molar absorptivity is less so. Define molar 
                   absorptivity and give its units."
                 ),
                 helpText(
                   "3. What is the value of \\(\\epsilon\\) in terms
                   of X?"
                 )
               ),
               column(
                 width = 8,
                br(),
                br(),
                imageOutput("image_1a")
               )
             )),
    tabPanel("Investigation 2",
             fluidRow(
               column(
                 width = 4,
                 h4("Absorbance Spectra"),
                 helpText(
                  "Although Beer's law is defined in terms of absorbance,
                  a spectrophotometer actually measures transmittance, 
                  \\(\\textit{T}\\), which is a ratio of the power of 
                  light transmitted by a sample, \\(\\textit{P}_{sam}\\), 
                  and the power of light transmitted by a reference,
                  \\(\\textit{P}_{ref}\\) 
                  $$T=\\frac{{P}_{sam}}{{P}_{ref}}$$"),
                 h5("Questions"),
                 helpText(
                  "The plot on the right shows \\(\\textit{P}_{sam}\\) 
                  in red and \\(\\textit{P}_{ref}\\) in blue, with 
                  the first six values for each spectrum  shown in 
                  the table on the far right."
                 ),
                 helpText(
                  "1. What are the mathematical relationships between 
                  absorbance and transmittance, and between 
                  transmittance and the analyte's concentration?"),
                 helpText(
                  "2. Use the button below to download the data for 
                  \\(\\textit{P}_{ref}\\) and for 
                  \\(\\textit{P}_{sam}\\) and create two plots, one 
                  that shows the sample's transmittance as a function 
                  of the wavelength and one that shows the sample's 
                  absorbance as a function of the wavelength. When 
                  your are finished, you can use the radio buttons 
                  below to check your work."
                 ),
                 radioButtons(
                   "radio_2a", label = h4("Display Format"),
                   choices = list("Power",
                                  "Transmittance",
                                  "Absorbance"),
                   selected = "Power"
                 ),
                 downloadButton("download_2a", "Download")
               ),
               column(
                 width = 5,
                plotOutput("plot_2a"),
                br(),
                helpText("The source of visible light is a 
                tungesten-halogen lamp. The original power spectrum for 
                the source is from Thor labs (www.thorlabs.com) 
                and gives power as a function of wavelength from 
                400 nm to 2600 nm in 10 nm intervals. This data 
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
                 tableOutput("table_2a")
               )
             )),
    tabPanel("Investigation 3",
             fluidRow(
               column(
                 width = 5,
                 h4("Calibration Curves"),
                 helpText(
                  "We know from Beer's law
                  $$A = \\epsilon bC$$
                  that there is a linear relationship between
                  absorbance and the concentration of analyte. A plot 
                  of the absorbance as a function of concentration for
                  a series of standard solutions of the analyte
                  is called a calibration curve, the equation for which 
                  allows us to determine the concentration of analyte 
                  in a sample given its absorbance."),
                 h5("Questions"),
                 helpText(
                  "The plot on the right shows absorbance spectra 
                  for a blank and for five standard solutions of 
                  analyte with concentrations of 0.200, 0.400, 
                  0.600, 0.800, and 1.000 mM. Unlike the spectra in 
                  Investigation 1, noise with a standard deviation of 
                  0.2%T is added to the spectra. The table on the far 
                  right shows the absorbance values for the blank 
                  and for the standards at the wavelength selected by 
                  the slider."),
                 helpText(
                  "1. The slider's default position is a 
                  wavelength of 450 nm. Use the absorbance data in 
                  the table to prepare a calibration curve and complete
                  a regression analysis to determine the calibration
                  curve's equation. When you are finished, use the 
                  check box to review your work."),
                 helpText(
                  "2. Use the slider and the show model checkbox to
                  explore how the choice of wavelength affects the 
                  calibration curve's slope and its 
                  \\(\\textit{y}\\)-intercept. Do your observations 
                  make sense given Beer's law? Why or why not?"
                  ),
                 helpText(
                  "3. If you are developing a quantitative analytical 
                  method for this analyte, which wavelength will you
                  select for your analysis? Explain the reason(s) for 
                  your selection."
                 ),
                 sliderInput(
                   "slider_3a", "Analytical Wavelength (nm)", 
                    min = 400, max = 750, value = 450, step = 1
                 ),
                 checkboxInput("check_3a", label = "Show Model?", 
                               value = FALSE)
               ),
               column(
                 width = 5,
                plotOutput("plot_3a", height = "325px"),
                verbatimTextOutput("table_3b")
                ),
               column(
                 width = 2,
                 br(),
                 align = "center",
                 "Data for Calibration Standards",
                 br(),
                 "(concentrations in mM)",
                 tableOutput("table_3a")
               )
             )),
    tabPanel("Investigation 4",
             fluidRow(
               column(
                 width = 4,
                 h4("Fundamental Limitation to Beer's Law"),
                 helpText(
                  "The derivation of Beer's law makes several
                  important assumptions, one of which is that the
                  individual units of analyte—whether molecules or
                  ions—behave as independent absorbers."),
                 h5("Questions"),
                 helpText(
                  "1. Do you expect that concentration will affect 
                  whether an analyte behaves as an independent 
                  absorber? Why of why not? If yes, do you expect that
                  an analyte is more likely to behave as an independent 
                  absorber at high concentrations or at low 
                  concentrations? Why?"),
                 helpText(
                  "2. Use the slider below to explore how the 
                  analyte's concentration affects the calibration curve 
                  using your analytical wavelength from  
                  Investigation 3. Over what range of concentrations 
                  do you obtain a useful calibration curve? What 
                  criteria did you use to make your choice and why?"),
                 helpText(
                   "3. What is the difference between extrapolation and
                   interpolation? Given your results from the previous
                   question, discuss the wisdom of extrapolating or
                   interpolating a Beer's law calibration curve to 
                   determine the concentration of analyte in a sample." 
                 ),
                 sliderInput(
                   "slider_4b", "Analytical Wavelength (nm)", 
                   min = 400, max = 750, step = 1, value = 400
                 ),
                 sliderInput(
                   "slider_4a", "Concentration Range (mM)", min = 0,
                   max = 10, step = 0.1, value = c(0, 10)
                 ),
                 helpText(
                  "Note: The range of concentrations you choose must 
                  include at least two points to return a slope and an 
                  intercept. The highlighting in the upper plot shows 
                  the points included in the calibration curve. The
                  spectra for the standards included in the
                  calibration curve are shown in the plot at the 
                  bottom of the page."
                  )
               ),
               column(
                 width = 4,
                 plotOutput("plot_4a", height = "325px"),
                 plotOutput("plot_4b", height = "325px")
               ),
               column(
                 width = 4,
                 br(),
                 br(),
                 verbatimTextOutput("table_4a"))
             )),
    tabPanel("Investigation 5",
             fluidRow(
               column(
                 width = 4,
                 h4("Instrumental Limitation to Beer's Law"),
                 h5("Polychromatic Radiation"),
                 helpText(
                  "Another important assumption in the derivation of 
                  Beer's law is that the source emits just a single, 
                  monochromatic wavelength of light; however, as we 
                  know from Investigation 2, our source emits light at 
                  all wavelengths between 400 nm and 750 nm."
                  ),
                 h5("Questions"),
                 helpText(
                  "To explore the effect of polychromatic radiation on 
                  Beer's law, we will use the sliders below to select 
                  the analytical wavelength—the wavelength for which we 
                  measure and report the absorbance—and a second, 
                  interfering wavelength of light."
                  ),
                 helpText(
                  "1. Using the equation for transmittance from 
                  Investigation 2 as a starting point, explain why 
                  polychromatic radiation might lead to a deviation 
                  from Beer's law."
                  ),
                  helpText(
                  "2. Set the analytical wavelength to the value you
                  chose in Investigation 3 and explore the effect on
                  the calibration curve of the interfering wavelength's 
                  offset; be sure to explore all possible offsets. 
                  Explain your results."
                  ),
                 helpText(
                  "3. Set the analytical wavelength to 625 nm and
                  explore the effect of the offset on the calibration
                  curve; be sure to explore all possible offsets. 
                  Explain your results."
                  ),
                 helpText(
                  "4. A spectrophotometer, of course, does not pass 
                  just two wavelengths of source radiation; instead 
                  it passes a finite band of radiation. For a 
                  spectrophotometer with a scanning monochromator, how 
                  might you adjust the operating conditions of so 
                  the source appears more monochromatic? Are there are 
                  any trade-offs to your approach?"
                 )
                 ),
               column(
                 width = 4,
                 align = "center",
                 plotOutput("plot_5a", height = "300px"),
                 plotOutput("plot_5b", height = "300px"),
                 sliderInput(
                   "slider_5a", "Analytical Wavelength (nm)", 
                   min = 450, max = 700, step = 1, value = 450
                 )
               ),
               column(
                 width = 4,
                 align = "center",
                 plotOutput("plot_5c", height = "300px"),
                 plotOutput("plot_5d", height = "300px"),
                 sliderInput(
                   "slider_5b", "Offset (± nm)", min = 0, 
                   max = 50, step = 5, value = 5
                 )
               )
               )
             ),
    tabPanel("Investigation 6",
             fluidRow(
               column(
                 width = 5,
                 h4("Instrumental Limitation to Beer's Law"),
                 h5("Stray Radiation"),
                 helpText(
                  "Another important assumption in the derivation of 
                  Beer's law is that all radiation that reaches the 
                  detector passes through the sample; light that 
                  reaches the detector without passing throught the
                  sample is called stray light. For this investigation 
                  we will assume that  stray light is not absorbed by 
                  the analyte and that the relative amount of stray 
                  light is the same for all wavelengths."),
                 h5("Questions"),
                 helpText(
                  "1. Explain why stray light might lead to a deviation 
                  from Beer's law. Do you expect the deviation to be 
                  positive or negative? Why?"
                 ),
                 helpText(
                  "2. Use the sliders below to explore how the choice 
                  of wavelength and the amount of stray light affects 
                  deviations from Beer's law. Begin by setting the 
                  wavelength to the value you selected in 
                  Investigation 3 and varying the amount of stray 
                  light. Repeat using wavelengths of 450 nm, 550 nm, 
                  625 nm, and 675 nm. Is the effect of stray light the 
                  same at all wavelengths? What conditions favor the 
                  greatest deviations from Beer's law? What conditions 
                  favor the smallest deviation from Beer's law?"),
                 helpText(
                  "3. Describe at least two possible sources of stray
                  light and how you might limit these sources of stray 
                  light."
                 ),
                 sliderInput("slider_6a", 
                             "Analytical Wavelength (nm)",
                             min = 400, max = 750, step = 1, 
                             value = 400),
                 sliderInput("slider_6b", "% Stray Light",
                             min = 0, max = 50, step = 1,
                             value = 0)
               ),
               column(
                 width = 5,
                 plotOutput("plot_6a", height = "325px"),
                 plotOutput("plot_6b", height = "325px")
               ),
               column(
                 width = 2,
                 align = "center",
                 br(),
                 helpText("Calibration Data w/o Stray Light"),
                 helpText("(concentrations in mM)"),
                 tableOutput("table_6a"),
                 br(),
                 helpText("Calibration Data w/ Stray Light"),
                 helpText("(concentrations in mM)"),
                 tableOutput("table_6b")
               )
             )
             ),
    tabPanel("Investigation 7",
             fluidRow(
               column(
                 width = 6,
                 h4("Chemical Limitations to Beer's Law"),
                 helpText(
                  "In exploring the fundamental and the instrumental 
                  limitations to Beer's law we assumed—without any 
                  comment—that we could ignore the analyte's 
                  reactivity; that is, we assumed that in 
                  the absence of a fundamental or an instrumental 
                  limitation, a plot of absorbance vs. concentration 
                  is a straight-line for all concentrations of 
                  analyte. In this final investigation we will explore 
                  the limits of this assumption."),
                 h5("Questions"),
                 helpText(
                  "1. Lets assume our analyte is a monoprotic weak acid 
                  with a \\(\\textrm{p}{K}_{a}\\) of 5. Let's assume, 
                  as well, that only the conjugate weak acid form, HA, 
                  absorbs light at an analytical wavelength of 649 nm, 
                  and that the calibration standards are unbuffered. 
                  Examine the calibration curve shown to the right and 
                  explain why it shows a negative deviation from 
                  Beer's law."
                  ),
                  helpText(
                  "2. Do you expect this deviation from Beer's law to 
                  become larger or smaller if the analyte's 
                  \\(\\textrm{p}{K}_{a}\\) is 3? Why? How about if the 
                  analyte's \\(\\textrm{p}{K}_{a}\\) is 7? Test your 
                  predictions by adjusting the slider for the analyte's 
                  \\(\\textrm{p}{K}_{a}\\) and the radio button for 
                  the adsorbing species."),
                 helpText(
                  "3. For an analyte with a \\(\\textrm{p}{K}_{a}\\) 
                  of 3, explain the difference in the deviation from 
                  Beer's law when HA is the absorbing species and when 
                  \\(\\textrm{A}^{-}\\) is the absorbing species. "
                 ),
                 helpText(
                 "4. One way to control acid-base chemistry is to use
                  a buffer. Using the same conditions as in Question 1, 
                  suggest an appropriate pH to buffer the calibration 
                  standards so that there is no deviation from Beer's 
                  law. Explain the reason(s) for your choice of pH. 
                  You can check your results using the available
                  controls."
                 ),
                 helpText(
                  "5. Suppose your analyte has a \\(\\textrm{p}{K}_{a}\\) 
                  of 7 and that only its conjugate weak base form, 
                  \\(\\textrm{A}^{-}\\), absorbs. Sugest an appropriate pH 
                  to buffer the calibration standards so that there is 
                  no deviation from Beer's law. Explain the reason(s) 
                  for your choice. You can check your results using 
                  the available controls."
                 ),
                 helpText(
                  "6. Given your answer to the first five questions, 
                  explain how you will prepare your calibration 
                  standards using an unbuffered stock that is 10 mM. 
                  How will you prepare your samples for analysis?"
                 )
               ),
               column(
                 width = 6,
                 align = "center",
                 # plotOutput("plot_7a", height = "325px"),
                 plotOutput("plot_7b", height = "325px"),
                 sliderInput("slider_7b", 
                             "Analyte's \\(\\textrm{p}{K}_{a}\\)",
                             min = 0, max = 14, step = 1,
                             value = 5),
                 radioButtons("radio_7a", "Absorbing Species", 
                              choices = c("HA", 
                                          "\\(\\textrm{A}^{-}\\)"),
                              selected = "HA", inline = "TRUE"),
                 radioButtons("radio_7b", "Buffer pH?",
                              choices = c("yes", "no"), 
                              selected = "no", inline = "TRUE"),
                 sliderInput("slider_7c", "Select pH", min = 0, 
                             max = 14, step = 0.2, value = 7)
               )
               )
             )
  )
))