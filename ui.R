ui <- shiny::tagList(
  shinytoastr::useToastr(), 
  includeScript(path = file.path('www', 'js', 'script.js')), 
  
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
      
      # get_ui(id = 'get')
      
      tags$div(
        class = 'container', 
        style = 'margin-top: 50px;', 
        
        DT::DTOutput(outputId = 'table')
      )
    )
  )
)
