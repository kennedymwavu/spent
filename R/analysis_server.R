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
      output$plt_top_n_items <- echarts4r::renderEcharts4r({
        n <- as.numeric(input$top_n_items)
        
        req(n)
        
        items[, list(freq = .N), by = 'item'][
          order(-freq), .SD[seq_len(n)]
        ][order(freq)] |> 
          echarts4r::e_charts_(x = 'item') |> 
          echarts4r::e_bar_(serie = 'freq', name = 'Item') |> 
          echarts4r::e_color(color = '#44acb4') |> 
          echarts4r::e_legend(show = FALSE) |> 
          echarts4r::e_title(
            text = paste0(
              'Top ', n, ' Most Bought Items'
            )
          ) |> 
          echarts4r::e_tooltip(trigger = 'item') |> 
          echarts4r::e_flip_coords() |> 
          echarts4r::e_toolbox_feature(feature = "saveAsImage")
      })
    }
  )
}
