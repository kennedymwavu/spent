#' POST UI module
#'
#' @param id module id
#'
#' @return A shiny::tagList obj
#' @noRd
analysis_ui <- function(id) {
  ns <- NS(namespace = id)
  
  shiny::tagList(
    fluidRow(
      align = 'center', 
      class = 'mycontainer', 
      
      tags$div(
        class = 'plots', 
        
        echarts4r::echarts4rOutput(outputId = ns(id = 'plt_amt_per_month')), 
        
        echarts4r::echarts4rOutput(outputId = ns(id = 'plt_top_n_items')), 
        
        echarts4r::echarts4rOutput(outputId = ns(id = 'plt_store_freq')), 
        
        echarts4r::echarts4rOutput(outputId = ns(id = 'plt_hr_freq'))
      )
    )
  )
}
