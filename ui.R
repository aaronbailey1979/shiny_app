library(shiny)

shinyUI(fluidPage(
  titlePanel("Generating linear models, sampling, and regression"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("seed_val", "Select a seed value to initialize random number
                  generation.",
                  1,99999,value = 50000),
      sliderInput("model_int", "Select b.",
                  -10,10,value=0),
      sliderInput("model_slope", "Select m.",
                  -10,10,value=0),
      sliderInput("model_std_dev", "Select the standard deviation of e.",
                  0,10,value=5),
      sliderInput("sliderX", "Select the minimum and maximum x-values.",
                  -50,50, value=c(-10,10)),
      sliderInput("num", "Select the number of points in the data set.",
                  10,200,value=100),
      checkboxInput("int_choice", "Include the intercept in the regression.",
                  value = TRUE),
      checkboxInput("slope_choice", "Include the slope in the regression.",
                  value = TRUE),
    ),
    mainPanel(
      h3("This application allows a user to prescribe a linear model, sample
        it, regress the sample, and compare the fitted and theoretical models."),
      h4("Slider 1: Choose a seed to initialize random number generation."),
      h4("Sliders 2-4: Determine the theoretical linear model y=b+mx+e. Here, e
         is a Gaussian random variable with zero mean."), 
      h4("Sliders 5-6: Determine the sample values of the independent variable.
        These x-values are uniformly sampled between the maximum and minimum,
         and the y-values are then given by the previously specified model.
         This yields S = {(x_k,y_k)}."),
      h4("Checkboxes: Select the parameters to include in the regression line.
        If at least one parameter is selected, the plot will be the scatterplot
        of S, its theoretical model, and regression line. If no parameter is
        selected, the plot will be the scatterplot of S and its theoretical
        model."),
      plotOutput("plot1")
    )
  )
))