server <- function(input, output, session) {
  rv_req_details <- reactiveValues(
    post_url = 'http://developers.gictsystems.com/api/dummy/submit/', 
    get_url = 'http://developers.gictsystems.com/api/dummy/items/', 
    header_authorization = 'Bearer ALDJAK23423JKSLAJAF23423J23SAD3'
  )
  
  post_server(id = 'post', post_url = rv_req_details$post_url)
  
  # autoinvalidator to reload table every 10 seconds:
  autoinvalidator <- reactiveTimer(intervalMs = 10 * 1000, session = session)
  
  rv_table <- reactiveVal(value = NULL)
  
  observeEvent(autoinvalidator(), {
    # GET request:
    r <- httr::GET(
      url = rv_req_details$get_url, 
      httr::add_headers(Authorization = rv_req_details$header_authorization)
    )
    
    newtable <- data.frame(
      do.call(
        what = 'rbind', 
        args = httr::content(r)
      )
    )
    
    rv_table(newtable)
  })
  
  output$table <- DT::renderDT({
    DT::datatable(
      data = rv_table(), 
      rownames = FALSE, 
      extensions = c('Buttons'), 
      selection = 'single', 
      options = list(
        processing = FALSE, 
        scrollX = TRUE,
        dom = 'Bftip', 
        buttons = list(
          list(
            extend = 'excel',
            text = 'Download',
            title = paste0('gict-get-data-', Sys.Date())
          )
        )
      )
    )
  })
}
