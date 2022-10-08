#' Footer
#'
#' @return [shiny::tagList()]
#' @noRd
footer <- function() {
  shiny::tagList(
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
}
