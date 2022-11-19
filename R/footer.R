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
            
            tags$h4('kennedy mwavu'), 
            tags$ul(
              tags$li(
                tags$a(href = 'https://kennedymwavu.github.io/#intro', 'about me')
              ), 
              tags$li(
                tags$a(href = 'https://kennedymwavu.github.io/#work', 'work experience')
              ), 
              tags$li(
                tags$a(href = 'https://kennedymwavu.github.io/#projects', 'projects')
              )
            )
          ), 
          
          tags$div(
            class = 'footer-col', 
            
            tags$h4('online sites'), 
            tags$ul(
              tags$li(
                tags$a(href = 'https://kennedymwavu.hashnode.dev/', 'blog')
              ), 
              tags$li(
                tags$a(href = 'https://kennedymwavu.github.io/#', 'website')
              )
            )
          ), 
          
          tags$div(
            class = 'footer-col', 
            
            tags$h4('follow me'), 
            
            tags$div(
              class = 'social-links', 
              
              # tags$a(
              #   href = 'https://www.facebook.com/profile.php?id=100084291762716', 
              #   tags$i(class = 'fab fa-facebook-f'), 
              #   title = 'facebook'
              # ), 
              tags$a(
                href = 'https://twitter.com/kennedymwavu', 
                tags$i(class = 'fab fa-twitter'), 
                title = 'twitter'
              ), 
              tags$a(
                href = 'https://www.instagram.com/mwavukennedy/', 
                tags$i(class = 'fab fa-instagram'), 
                title = 'instagram'
              ), 
              tags$a(
                href = 'https://www.linkedin.com/in/mwavukennedy/', 
                tags$i(class = 'fab fa-linkedin-in'), 
                title = 'linkedin'
              )
            )
          )
        )
      )
    )
  )
}
