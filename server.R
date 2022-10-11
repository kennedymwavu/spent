server <- function(input, output, session) {
  analysis_server(id = 'analysis')
  
  records_server(id = 'records')
}
