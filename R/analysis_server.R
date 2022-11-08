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
      
      top_n_items <- reactive({
        n <- as.numeric(input$top_n_items)
        
        req(n)
        
        return(n)
      })
      
      output$card_header_plt_top_n_items <- renderText({
        paste0(
          'Top ', top_n_items(), ' most bought items'
        )
      })
      
      output$plt_top_n_items <- echarts4r::renderEcharts4r({
        items[, list(freq = .N), by = 'item'][
          order(-freq), .SD[seq_len(top_n_items())]
        ][order(freq)] |> 
          echarts4r::e_charts_(
            x = 'item', 
            grid = list(
              left = '3%',
              right = '4%',
              bottom = '3%',
              containLabel = TRUE
            )
          ) |> 
          echarts4r::e_bar_(serie = 'freq', name = 'Item') |> 
          echarts4r::e_color(color = '#44acb4') |> 
          echarts4r::e_legend(show = FALSE) |> 
          echarts4r::e_title(
            text = paste0(
              'Top ', top_n_items(), ' most bought items'
            ), 
            show = FALSE
          ) |> 
          echarts4r::e_tooltip(trigger = 'item') |> 
          echarts4r::e_flip_coords() |> 
          echarts4r::e_toolbox_feature(feature = "saveAsImage")
      })
      
      output$top_most_expensive_items <- DT::renderDT({
        tbl_top_most_expensive_items <- 
          unique(items, by = 'item')[
            order(-price), 
            .SD[seq_len(top_n_items())], 
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
          fillContainer = FALSE, 
          class = c('display', 'nowrap', 'compact'), 
          caption = tags$caption(
            paste0(
              'Top ', top_n_items(), ' most expensive items'
            ), 
            
            style = 'caption-side: top;'
          ), 
          options = list(
            searching = FALSE, 
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
      
      output$plt_store_freq <- echarts4r::renderEcharts4r({
        plt_store_freq
      })
      
      output$plt_hr_freq <- echarts4r::renderEcharts4r({
        plt_hr_freq
      })
    }
  )
}
