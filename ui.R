ui <- bootstrapPage(
  # theme = shinythemes::shinytheme('journal'),
  theme = bslib::bs_theme(version = 5, bootswatch = 'default'), 
  title = 'Spent', 
  
  shinyjs::useShinyjs(), 
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
    tags$h2('Home Expenditure Tracker'), 
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
  
  tabsetPanel(
    id = 'tab_container', 
    
    tabPanel(
      title = 'Analysis', 
      value = 'analysis', 
      icon = icon('bar-chart-o'), 
      
      analysis_ui(id = 'analysis')
    ), 
    
    tabPanel(
      title = 'Records', 
      value = 'records', 
      icon = icon('table'), 
      
      records_ui(id = 'records')
    )
  ), 
  
  # footer:
  footer()
)
