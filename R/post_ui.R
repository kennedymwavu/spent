#' POST UI module
#'
#' @param id module id
#'
#' @return A shiny::tagList obj
#' @noRd
post_ui <- function(id) {
  ns <- NS(namespace = id)
  
  shiny::tagList(
    fluidRow(
      align = 'center', 
      class = 'mycontainer', 
      
      tags$h3('Please fill in the details below:'), 
      
      tags$div(
        class = 'details', 
        
        textInput(
          inputId = ns('fullnames'), 
          label = 'Full Names',
          placeholder = 'John Wick', 
          width = '500px'
        ), 
        
        textInput(
          inputId = ns('email'), 
          label = 'Email:', 
          placeholder = 'johnwick@gmail.com', 
          width = '500px'
        ), 
        
        textInput(
          inputId = ns('phone'), 
          label = 'Phone Number:', 
          placeholder = '+254712345672', 
          width = '500px'
        ), 
        
        textInput(
          inputId = ns('address'), 
          label = 'Address', 
          placeholder = 'Afya Center, Nairobi | 337407', 
          width = '500px'
        )
      ), 
      
      shinyFeedback::loadingButton(
        inputId = ns('submit'), 
        label = 'Submit', 
        loadingLabel = 'Submitting...', 
        class = 'btn btn-info'
      )
    )
  )
}
