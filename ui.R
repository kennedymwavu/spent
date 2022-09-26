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
        tags$div(
          style = 'margin-top: 50px;', 
          
          actionButton(
            inputId = 'add_row',
            label = 'Add Row',
            icon = icon('plus'),
            class = 'btn-success'
          )
        )
      ), 
      
      tags$div(
        class = 'container', 
        style = 'margin-top: 50px;', 
        
        DT::DTOutput(outputId = 'table')
      )
    )
  ), 
  
  # footer:
  tags$footer(
    class = 'page-footer font-small blue pt-4', 
    
    # footer links:
    tags$div(
      class = 'container-fluid text-center text-md-left', 
      
      # grid row:
      tags$div(
        class = 'row', 
        
        # grid column:
        tags$div(
          class = 'col-md-6 mt-md-0 mt-3', 
          
          # content:
          tags$h5(
            class = 'text-uppercase', 
            'Footer Content'
          ), 
          
          tags$p(
            'Here you can use rows and columns to organize your footer content.'
          )
        ), 
        
        tags$hr(class = 'clearfix w-100 d-md-none pb-3'), 
        
        # grid column:
        tags$div(
          class = 'col-md-3 mb-md-0 mb-3', 
          
          # links:
          tags$h5(class = 'text-uppercase', 'Links'), 
          
          tags$ul(
            class = 'list-unstyled', 
            
            tags$li(
              tags$a(href = '#!', 'Link 1')
            ), 
            tags$li(
              tags$a(href = '#!', 'Link 2')
            ), 
            tags$li(
              tags$a(href = '#!', 'Link 3')
            ), 
            tags$li(
              tags$a(
                href = '#!', 'Link 4'
              )
            )
          )
        ), 
        
        # grid column:
        tags$div(
          class = 'col-md-3 mb-md-0 mb-3', 
          
          # links:
          tags$h5(class = 'text-uppercase', 'Links'), 
          
          tags$ul(
            class = 'list-unstyled', 
            
            tags$li(
              tags$a(href = '#!', 'Link 1')
            ), 
            tags$li(
              tags$a(href = '#!', 'Link 2')
            ), 
            tags$li(
              tags$a(href = '#!', 'Link 3')
            ), 
            tags$li(
              tags$a(
                href = '#!', 'Link 4'
              )
            )
          )
        )
      )
    ), 
    
    # copyright:
    tags$div(
      class = 'footer-copyright text-center py-3', 
      HTML('&copy; 2022 Copyright:'), 
      tags$a(href = '/', 'gict-task.com')
    )
  )
)
