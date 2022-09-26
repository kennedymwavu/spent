server <- function(input, output, session) {
  rv_req_details <- reactiveValues(
    post_url = 'http://developers.gictsystems.com/api/dummy/submit/', 
    get_url = 'http://developers.gictsystems.com/api/dummy/items/', 
    header_authorization = 'Bearer ALDJAK23423JKSLAJAF23423J23SAD3'
  )
  
  post_server(id = 'post', post_url = rv_req_details$post_url)
  
  # get_server(
  #   id = 'get', 
  #   get_url = rv_req_details$get_url, 
  #   header_authorization = rv_req_details$header_authorization
  # )
  
  # autoinvalidator to reload table every 10 seconds:
  autoinvalidator <- reactiveTimer(intervalMs = 10 * 1000, session = session)
  
  rv_table <- reactiveValues(
    tbl = NULL, 
    dt_row = NULL,
    add_or_edit = NULL,
    edit_button = NULL,
    keep_track_id = NULL
  )
  
  observeEvent(autoinvalidator(), {
    # GET request:
    r <- httr::GET(
      url = rv_req_details$get_url, 
      httr::add_headers(Authorization = rv_req_details$header_authorization)
    )
    
    newtable <- lapply(httr::content(r), as.data.frame) |> 
      do.call(what = 'rbind')
    
    # create btns:
    btns <- create_buttons(btn_ids = seq_len(nrow(newtable)))
    
    # add the btns as a column to newtable:
    newtable$Buttons <- btns
    
    rv_table$tbl <- newtable
  })
  
  output$table <- DT::renderDT({
    DT::datatable(
      data = rv_table$tbl, 
      rownames = FALSE, 
      escape = FALSE, 
      selection = 'single', 
      class = c('display', 'nowrap'), 
      options = list(processing = FALSE, lengthChange = FALSE)
    )
  })
  
  proxy <- DT::dataTableProxy('table')
  
  shiny::observe({
    DT::replaceData(
      proxy = proxy,
      data = rv_table$tbl,
      resetPaging = FALSE,
      rownames = FALSE
    )
  })
  
  # delete row:
  observeEvent(input$current_id, {
    print('Here')
    print(input$current_id)
    req(
      isTruthy(input$current_id) & 
        stringr::str_detect(input$current_id, pattern = "delete")
    )
    
    rv_table$dt_row <- which(
      stringr::str_detect(
        rv_table$tbl$Buttons, 
        pattern = paste0("\\b", input$current_id, "\\b")
      )
    )
    
    rv_table$tbl <- rv_table$tbl[-rv_table$dt_row, ]
  })
}
