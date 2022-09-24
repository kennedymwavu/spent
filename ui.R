ui <- shiny::tagList(
  shinytoastr::useToastr(), 
  
  tags$header(
    tags$h1('My Header'), 
    tags$h2('My Subtitle')
  ), 
  
  navbarPage(
    title = 'GICT Task', 
    
    tabPanel(
      title = 'POST', 
      
      post_ui(id = 'post')
    ), 
    
    tabPanel(
      title = 'GET', 
      
      actionButton(
        inputId = 'get', 
        label = 'GET'
      )
    )
  )
)
