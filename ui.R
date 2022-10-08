ui <- bootstrapPage(
  theme = shinythemes::shinytheme('journal'),
  title = 'GICT-Task', 
  
  shinytoastr::useToastr(), 
  includeScript(path = file.path('www', 'js', 'script.js')), 
  includeCSS(path = file.path('www', 'css', 'styles.css')), 
  
  tags$head(
    tags$link(
      rel = 'stylesheet', 
      type = 'text/css', 
      href = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css'
    ), 
    
    tags$link(
      rel = 'icon', 
      type = 'image/x-icon', 
      href = file.path('imgs', 'favicon.ico')
    )
  ), 
  
  tags$header(
    class = 'text-center', 
    tags$h2('GET & POST HTTP Requests'), 
    tags$h5(
      style = 'font-weight: 300;', 
      
      'By ', 
      
      tags$a(
        href = 'https://mwavu.com/', 
        target = '_blank', 
        style = 'color: #336699;', 
        'Kennedy Mwavu'
      )
    )
  ), 
  
  navbarPage(
    title = 'GICT Task', 
    collapsible = TRUE, 
    
    tabPanel(
      title = 'POST', 
      
      post_ui(id = 'post')
    ), 
    
    tabPanel(
      title = 'GET', 
      
      get_ui(id = 'get')
    )
  ), 
  
  # footer:
  footer()
)
