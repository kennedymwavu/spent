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
        
        # get message/content returned by the request:
        msg <- httr::content(r, as = 'raw') |> rawToChar()
        
        # Throw error or warning when necessary:
        stop_for_status(r)
        warn_for_status(r)
        
        # If okay, show user success:
        shinytoastr::toastr_success(
          message = httr::content(r)$Message,
          title = 'Success!', 
          progressBar = TRUE, 
          position = 'top-center'
        )
        
        # reset loading btn:
        shinyFeedback::resetLoadingButton(inputId = 'submit', session = session)
      }, 
      
      error = function(cond) {
        shinytoastr::toastr_error(
          message = msg
        )
        
        # reset loading btn:
        shinyFeedback::resetLoadingButton(inputId = 'submit', session = session)
        
        # print the error on console for debugging:
        print(cond)
      }, 
      
      warning = function(cond) {
        shinytoastr::toastr_warning(
          message = msg
        )
        
        # print warning on console for debugging:
        print(cond)
      }
    )
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
