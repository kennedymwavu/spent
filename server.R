server <- function(input, output, session) {
  rv_req_details <- reactiveValues(
    post_url = 'http://developers.gictsystems.com/api/dummy/submit/', 
    get_url = 'http://developers.gictsystems.com/api/dummy/items/', 
    header_authorization = 'Bearer ALDJAK23423JKSLAJAF23423J23SAD3'
  )
  
  post_server(id = 'post', post_url = rv_req_details$post_url)
  
  get_server(
    id = 'get',
    get_url = rv_req_details$get_url,
    header_authorization = rv_req_details$header_authorization
  )
}
