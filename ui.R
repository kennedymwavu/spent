ui <- bslib::page(
  theme = bslib::bs_theme(version = 5, bootswatch = 'journal'),
  title = 'Spent', 
  
  shinyjs::useShinyjs(), 
  shinytoastr::useToastr(), 
  
  firebase::useFirebase(), 
  
  includeScript(path = file.path('www', 'js', 'script.js')), 
  shinyjs::extendShinyjs(
    script = file.path('js', 'script.js'), 
    functions = c()
  ), 
  
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
  
  tags$div(
    class = 'div_container', 
    
    tags$div(
      class = 'p-5 mb-1 bg-info bg-gradient', 
      
      tags$header(
        class = 'text-center', 
        
        tags$h1(
          class = 'display-5', 
          'Home Expenditure'
        )
      )
    ), 
    
    tags$div(
      class = 'container', 
      
      tabsetPanel(
        id = 'tab_container', 
        
        tabPanel(
          title = tags$span(
            class = 'fs-5', 
            
            'Analysis'
          ), 
          value = 'analysis', 
          class = 'p-3 border-0', 
          
          analysis_ui(id = 'analysis')
        ), 
        
        tabPanel(
          title = tags$span(
            class = 'fs-5', 
            
            'Records'
          ), 
          value = 'records', 
          class = 'p-3 border-0', 
          
          records_ui(id = 'records')
        )
      )
    ), 
    
    # scroll to top btn:
    tags$button(
      type = 'button', 
      class = 'btn btn-outline-primary btn-lg rounded-circle', 
      id = 'back_to_top', 
      
      tags$i(
        class = 'fas fa-arrow-up'
      )
    ), 
    
    # footer:
    footer(), 
    
    # copyright:
    tags$div(
      class = 'text-center text-muted bg-dark pt-3 pb-1', 
      style = 'background-color: black;', 
      
      tags$p(
        shiny::HTML(
          paste0(
            'Copyright &copy;<span id = "year"></span>', 
            '. All rights reserved.'
          )
        )
      )
    )
  )
)
