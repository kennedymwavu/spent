server <- function(input, output, session) {
  rv_req_details <- reactiveValues(
    post_url = 'http://developers.gictsystems.com/api/dummy/submit/', 
    get_url = 'http://developers.gictsystems.com/api/dummy/items/', 
    header_authorization = 'Bearer ALDJAK23423JKSLAJAF23423J23SAD3'
  )
  
  post_server(id = 'post', post_url = rv_req_details$post_url)
  
  observeEvent(input$get, {
    # tab2:
    getdata <- httr::GET(
      url = rv_req_details$get_url, 
      httr::add_headers(Authorization = rv_req_details$header_authorization)
    )
    
    print(status_code(getdata))
    
    print(content(getdata))
  })
}
