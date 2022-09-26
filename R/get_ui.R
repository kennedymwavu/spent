#' GET ui module
#'
#' @param id module id
#'
#' @return shiny::tagList
#' @noRd
get_ui <- function(id) {
  ns <- NS(id)
  
  shiny::tagList(
    tags$div(
      class = 'container', 
      style = 'margin-top: 50px;', 
      
      DT::DTOutput(outputId = ns('table'))
    )
  )
}
