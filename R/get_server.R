#' GET server module
#'
#' @param id module id
#' @param get_url GET url
#' @param header_authorization Header authorization
#'
#' @noRd
get_server <- function(id, get_url, header_authorization) {
  moduleServer(
    id = id, 
    module = function(input, output, session) {
      # autoinvalidator to reload table every 10 seconds:
      autoinvalidator <- reactiveTimer(intervalMs = 10 * 1000, session = session)
      
      rv_table <- reactiveVal(value = NULL)
      
      observeEvent(autoinvalidator(), {
        # GET request:
        r <- httr::GET(
          url = get_url, 
          httr::add_headers(Authorization = header_authorization)
        )
        
        newtable <- lapply(httr::content(r), as.data.frame) |> 
          do.call(what = 'rbind')
        
        # create btns:
        btns <- create_buttons(btn_ids = seq_len(nrow(newtable)))
        
        # add the btns as a column to newtable:
        newtable$Buttons <- btns
        
        rv_table(newtable)
      })
      
      output$table <- DT::renderDT({
        DT::datatable(
          data = rv_table(), 
          rownames = FALSE, 
          escape = FALSE, 
          selection = 'single', 
          class = c('display', 'nowrap'), 
          options = list(processing = FALSE, lengthChange = FALSE)
        )
      })
    }
  )
}
