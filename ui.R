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
      
      # get_ui(id = 'get')
      
      tags$div(
        class = 'mycontainer', 
        
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
          
          DT::DTOutput(outputId = 'table', height = '500px')
        )
      )
    )
  ), 
  
  # footer:
  tags$footer(
    class = 'footer', 
    
    tags$div(
      class = 'footer-container', 
      
      tags$div(
        class = 'footer-row', 
        
        tags$div(
          class = 'footer-col', 
          
          tags$h4('company'), 
          tags$ul(
            tags$li(
              tags$a(href = '#', 'about us')
            ), 
            tags$li(
              tags$a(href = '#', 'our services')
            ), 
            tags$li(
              tags$a(href = '#', 'privacy policy')
            ), 
            tags$li(
              tags$a(href = '#', 'affiliate program')
            )
          )
        ), 
        
        tags$div(
          class = 'footer-col', 
          
          tags$h4('get help'), 
          tags$ul(
            tags$li(
              tags$a(href = '#', 'FAQ')
            ), 
            tags$li(
              tags$a(href = '#', 'shipping')
            ), 
            tags$li(
              tags$a(href = '#', 'returns')
            ), 
            tags$li(
              tags$a(href = '#', 'order status')
            ), 
            tags$li(
              tags$a(href = '#', 'payment options')
            )
          )
        ), 
        
        tags$div(
          class = 'footer-col', 
          
          tags$h4('online shop'), 
          tags$ul(
            tags$li(
              tags$a(href = '#', 'watch')
            ), 
            tags$li(
              tags$a(href = '#', 'bag')
            ), 
            tags$li(
              tags$a(href = '#', 'shoes')
            ), 
            tags$li(
              tags$a(href = '#', 'dress')
            )
          )
        ), 
        
        tags$div(
          class = 'footer-col', 
          
          tags$h4('follow us'), 
          
          tags$div(
            class = 'social-links', 
            
            tags$a(
              href = 'https://www.facebook.com/profile.php?id=100084291762716', 
              tags$i(class = 'fab fa-facebook-f')
            ), 
            tags$a(
              href = 'https://twitter.com/kennedymwavu', 
              tags$i(class = 'fab fa-twitter')
            ), 
            tags$a(
              href = 'https://www.instagram.com/mwavukennedy/', 
              tags$i(class = 'fab fa-instagram')
            ), 
            tags$a(
              href = 'https://www.linkedin.com/in/mwavukennedy/', 
              tags$i(class = 'fab fa-linkedin-in')
            )
          )
        )
      )
    )
  )
)
