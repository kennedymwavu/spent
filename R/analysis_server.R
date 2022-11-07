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
      
      output$top_most_expensive_items <- DT::renderDT({
        n <- as.numeric(input$top_n_items)
        
        req(n)
        
        tbl_top_most_expensive_items <- 
          unique(items, by = 'item')[
            order(-price), 
            .SD[seq_len(n)], 
            .SDcols = -c('datetime')
          ][, list(item, amount, month)]
        
        
        DT::datatable(
          data = tbl_top_most_expensive_items, 
          rownames = FALSE, 
          colnames = c(
            'Item', 'Amount', 'Month'
          ), 
          escape = FALSE, 
          selection = 'single', 
          class = c('display', 'nowrap'), 
          caption = tags$caption(
            paste0(
              'Top ', n, ' Most Expensive Items'
            ), 
            
            style = 'caption-side: top;'
          ), 
          options = list(
            processing = FALSE, 
            paging = FALSE, 
            ordering = FALSE, 
            info = FALSE, 
            scrollX = TRUE, 
            lengthChange = FALSE, 
            columnDefs = list(
              list(
                className = 'dt-center', targets = '_all'
              )
            )
          )
        ) |> 
          DT::formatCurrency(
            columns = c('amount'), 
            currency = ''
          )
      })
    }
  )
}
