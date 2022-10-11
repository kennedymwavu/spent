#' records ui module
#'
#' @param id module id
#'
#' @return shiny::tagList
#' @noRd
records_ui <- function(id) {
  ns <- NS(id)
  
  shiny::tagList(
    tags$div(
      class = 'mycontainer', 
      
      tags$div(
        class = 'container', 
        
        tags$div(
          style = 'margin-top: 50px;', 
          
          actionButton(
            inputId = ns(id = 'add_row'),
            label = 'Add Row',
            icon = icon('plus'),
            class = 'btn-success'
          )
        )
      ), 
      
      tags$div(
        class = 'container', 
        style = 'margin-top: 50px;', 
        
        DT::DTOutput(outputId = ns(id = 'table'), height = '500px') |> 
          shinycssloaders::withSpinner(
            type = 2, 
            color.background = 'white', 
            hide.ui = FALSE
          )
      )
    )
  )
}
