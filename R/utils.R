#' Pivot table visualisation using https://webpivottable.com/
#'
#' @param data : data.frame
#' @param width	: Width (optional, defaults to automatic sizing)
#' @param height	: Height (optional, defaults to automatic sizing)
#'
#'
#' @examples
#'
#'\dontrun{
#'\donttest{
#' # work only in browser, not in RStudio viewer
#' w <- webPivotTable(iris)
#' w # view in real browser
#' 
#' htmlwidgets::saveWidget(w, file = "pivot.html")
#' 
#' # in shiny
#'  require(shiny)
#'  
#'  ui <- fluidPage(
#'    webPivotTableOutput("wpt1"),
#'    hr(),
#'    webPivotTableOutput("wpt2")
#'  )
#'
#'  server <- function(input, output, session) {
#'    output$wpt1 <- renderWebPivotTable({
#'       webPivotTable(iris)
#'    })
#'
#'    output$wpt2 <- renderWebPivotTable({
#'       webPivotTable(mtcars)
#'    })
#'  }
#'
#'  shinyApp(ui, server)
#' }
#' }
#' 
#' @import htmlwidgets
#' @import jsonlite
#'
#' @export
webPivotTable <- function(data, width = NULL, height = NULL) {


  attrArray <- jsonlite::toJSON(colnames(data))

  dataArray <- jsonlite::toJSON(data, dataframe = "values")

  # pass the data and settings using 'x'
  x <- list(
    attrArray = attrArray,
    dataArray = dataArray
  )

  # create the widget
  htmlwidgets::createWidget("rWebPivotTable", x, width = width, height = height)
}


#' Shiny bindings for webPivotTable
#'
#' Output and render functions for using webPivotTable within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId : output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{"100\%"},
#'   \code{"400px"}, \code{"auto"}) or a number, which will be coerced to a
#'   string and have \code{"px"} appended.
#' @param expr An expression that generates a visNetwork
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name webPivotTable-shiny
#'
#'
#' @examples
#'
#'\dontrun{
#'
#' # have a look to :
#' shiny::runApp(system.file("shiny", package = "visNetwork"))
#'
#'}
#' @export
#'
webPivotTableOutput <- function(outputId, width = "100%", height = "400px") {
  shinyWidgetOutput(outputId, "rWebPivotTable", width, height, package = "rWebPivotTable")
}

#' @name webPivotTable-shiny
#' @export
renderWebPivotTable <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, webPivotTableOutput, env, quoted = TRUE)
}
