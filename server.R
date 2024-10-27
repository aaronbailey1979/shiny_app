library(shiny)

shinyServer(function(input, output, session) {
  output$plot1 <- renderPlot({
    
    seed_val <-input$seed_val
    set.seed(seed_val)
    
    # getting x values
    
    num <- input$num
    minx <- input$sliderX[1]
    maxx <- input$sliderX[2]
    xvals <- runif(num,minx,maxx)
    
    # getting corresponding y-values
    
    model_int <- input$model_int
    model_slope <- input$model_slope
    model_std_dev <- input$model_std_dev
    theoretical <- function(x){model_int+model_slope*x}
    yvals <- theoretical(xvals) +rnorm(num,0,model_std_dev)
  
    # What parameters to include in the linear fit
    
    int_choice <- ifelse(input$int_choice, 1, 0)
    slope_choice <- ifelse(input$slope_choice, 1, 0)
    
    # Getting the plot if no parameters are selected
    
    if(int_choice == 0 & slope_choice == 0)
    {
      plot(xvals, yvals,
           xlab ="X-axis", ylab = "Y-axis",
           pch = 19, col = "black",
           main = c(paste("Sample S generated from"),
                    paste("theoretical model y=(",model_int,
                          ")+(",model_slope,")x",sep=""),
                    paste("with random gaussian noise mu=0, sigma="
                          ,model_std_dev,".",sep="")))
      lines(xvals,theoretical(xvals), col = "blue",lwd = 3)
      legend("topleft", legend = "theoretical model",
             lwd = 3, lty = 1, col = "blue")
    }
    
    # The interesting case where at least one parameter is selected
    
    else
    {
      if(int_choice == 1 & slope_choice == 1)
      {
        fit <- lm(yvals ~ xvals)
        reg_int <- fit$coefficients[1]
        reg_slope <- fit$coefficients[2]
      }
      else if(int_choice == 1 & slope_choice == 0)
      {
        fit <- lm(yvals ~ 1)
        reg_int <- fit$coefficients[1]
        reg_slope <- 0
      }
      else if(int_choice == 0 & slope_choice == 1)
      {
        fit <- lm(yvals ~ 0+xvals)
        reg_int <- 0
        reg_slope <- fit$coefficients[1]
      }
        plot(xvals, yvals,
             xlab ="X-axis", ylab = "Y-axis",
             pch = 19, col = "black",
             main = c(paste("Sample S generated from"),
                      paste("theoretical model y=(",model_int,
                            ")+(",model_slope,")x",sep=""),
                      paste("with random gaussian noise mu=0, sigma="
                            ,model_std_dev,",",sep=""),
                      paste("and regressed model y=(",
                            reg_int,")+(",reg_slope,")x.",sep="")))
        lines(xvals,theoretical(xvals), col = "blue",lwd = 3)
        abline(fit,col="orange",lwd = 3)
        legend("topleft", legend = c("theoretical model", "regression line"),
               lwd = 3, lty = c(1, 1), col = c("blue", "orange"))
    }
  })
})