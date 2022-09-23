server <- function(input, output, session) {
  observeEvent(input$submit, {
    tryCatch(
      expr = {
        r <- httr::POST(
          url = post_url, 
          body = list(
            fullnames = input$fullnames, 
            email = input$email, 
            phone = input$phone, 
            address = input$address
          ), 
          encode = 'json'
        )
        
        # Throw error or warning when necessary:
        stop_for_status(r)
        warn_for_status(r)
        
        # If okay, show user success:
        shinytoastr::toastr_success(
          message = httr::content(r)$Message, 
          title = 'Success!'
        )
      }, 
      
      error = function(cond) {
        shinytoastr::toastr_error(
          message = httr::content(r)$Message, 
          title = paste('HTTP Error', r$status_code)
        )
      }, 
      
      warning = function(cond) {
        shinytoastr::toastr_warning(
          message = httr::content(r)$Message
        )
      }
    )
    
    print(r$status_code)
    print(content(r))
    # print(content(r)$Message)
    # print(message_for_status(r))
  })
  
  observeEvent(input$get, {
    # tab2:
    getdata <- httr::GET(
      url = get_url, 
      httr::add_headers(Authorization = header_authorization)
    )
    
    print(status_code(getdata))
    
    print(content(getdata))
  })
}
