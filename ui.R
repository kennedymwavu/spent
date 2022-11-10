ui <- bslib::page(
  theme = bslib::bs_theme(version = 5, bootswatch = 'yeti'),
  title = 'Spent', 
  
  shinyjs::useShinyjs(), 
  shinytoastr::useToastr(), 
  
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
      class = 'p-5 mb-1 bg-light', 
      
      tags$header(
        class = 'text-center', 
        tags$h1('Home Expenditure')
      )
    ), 
    
    tabsetPanel(
      id = 'tab_container', 
      
      tabPanel(
        title = 'Analysis', 
        value = 'analysis', 
        icon = tags$i(class = 'fa-solid fa-chart-simple'), 
        class = 'p-3 border border-top-0 rounded-bottom', 
        
        analysis_ui(id = 'analysis')
      ), 
      
      tabPanel(
        title = 'Records', 
        value = 'records', 
        icon = icon('table'), 
        class = 'p-3 border border-top-0 rounded-bottom', 
        
        records_ui(id = 'records')
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
