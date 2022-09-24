#' POST UI module
#'
#' @param id module id
#'
#' @return A shiny::tagList obj
#' @noRd
post_ui <- function(id) {
  ns <- NS(namespace = id)
  
  shiny::tagList(
    tags$h3('Please fill in the details below:'), 
    textInput(
      inputId = ns('fullnames'), 
      label = 'Full Names',
      # value = 'John Wick'
      placeholder = 'eg. John Wick'
    ), 
    
    textInput(
      inputId = ns('email'), 
      label = 'Email:', 
      # value = 'myemail@email.com'
      placeholder = 'eg. johnwick@gmail.com'
    ), 
    
    textInput(
      inputId = ns('phone'), 
      label = 'Phone Number:', 
      # value = '+254712345672'
      placeholder = 'eg. +254712345672'
    ), 
    
    textInput(
      inputId = ns('address'), 
      label = 'Address', 
      # value = 'po box 256'
    ), 
    
    shinyFeedback::loadingButton(
      inputId = ns('submit'), 
      label = 'Submit', 
      loadingLabel = 'Submitting...'
    )
  )
}
