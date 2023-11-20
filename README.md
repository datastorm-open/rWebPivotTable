# rWebPivotTable DSS HTTPS

###  Provides an R interface to the 'wpt.js' JavaScript charting     library. It allows an interactive visualization of table.


# Example

```` 
devtools::install_github("datastorm-open/rWebPivotTable") for development version

require(rWebPivotTable)
?webPivotTable

# minimal example
# work only in browser, not in RStudio viewer
w <- webPivotTable(iris)
w

htmlwidgets::saveWidget(w, file = "pivot.html")

# shiny example
require(shiny)

ui <- fluidPage(
    webPivotTableOutput("wpt1"),
    hr(),
    webPivotTableOutput("wpt2")
)

server <- function(input, output, session) {
    output$wpt1 <- renderWebPivotTable({
       webPivotTable(iris)
    })

    output$wpt2 <- renderWebPivotTable({
       webPivotTable(mtcars)
    })
}

shinyApp(ui, server)
````
