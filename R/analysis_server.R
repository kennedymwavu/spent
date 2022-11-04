#' POST server module
#'
#' @param id module id
#' @param post_url POST url
#'
#' @return NULL
#' @noRd
analysis_server <- function(id, post_url) {
  moduleServer(
    id = id, 
    module = function(input, output, session) {
      output$plt_amt_per_month <- echarts4r::renderEcharts4r({
        plt_amt_per_month
      })
      
      output$plt_top_n_items <- echarts4r::renderEcharts4r({
        plt_top_n_items
      })
      
      output$plt_store_freq <- echarts4r::renderEcharts4r({
        plt_store_freq
      })
      
      output$plt_hr_freq <- echarts4r::renderEcharts4r({
        plt_hr_freq
      })
    }
  )
}
