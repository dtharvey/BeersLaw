# Introduction
This learning module provided an introduction to Beer's law that is suitable for either an introductory course or an advanced course in analtyical chemistry. The module consists of seven investigations:

* Investigation 0: Recalling Beer's Law
* Investigation 1: Absorbance Spectra
* Investigation 2: Calibration Curves
* Investigation 3: Fundamental Limitation to Beer's Law
* Investigation 4: Instrumental Limitation to Beer's Law: Polychromatic Radiation
* Investigation 5: Instrumental Limitation to Beer's Law: Stray Light
* Investigation 6: Chemical Limitation to Beer's Law

The learning module is programmed in R (www.r-project.org) using the Shiny package, which allows for interactive features. Each investigation includes a brief introduction, an explanation of the controls available to the user---sliders, radio buttons, and buttons---and the type of plots, tables, and statistical summaries produced by the underlying code. Each investigation also includes some suggestions of things to explore and/or questions to answer.

You can launch the learning module from R using the Shiny package by typing

shiny::runGitHub("BeersLaw","dtharvey")

in the console.