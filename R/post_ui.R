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
          label = tags$div(
            'Full Names', 
            tags$span('*', style = 'color: #f57a00;')
          ),
          placeholder = 'John Wick', 
          width = '500px'
        ), 
        
        textInput(
          inputId = ns('email'), 
          label = tags$div(
            'Email', 
            tags$span('*', style = 'color: #f57a00;')
          ), 
          placeholder = 'johnwick@gmail.com', 
          width = '500px'
        ), 
        
        textInput(
          inputId = ns('phone'), 
          label = tags$div(
            'Phone Number', 
            tags$span('*', style = 'color: #f57a00;')
          ), 
          placeholder = '+254712345672', 
          width = '500px'
        ), 
        
        textInput(
          inputId = ns('address'), 
          label = tags$div(
            'Address', 
            tags$span('*', style = 'color: #f57a00;')
          ), 
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
