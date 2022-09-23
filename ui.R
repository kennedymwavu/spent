ui <- shiny::tagList(
  shinytoastr::useToastr(), 
  
  tags$header(
    tags$h1('My Header'), 
    tags$h2('My Subtitle')
  ), 
  
  navbarPage(
    title = 'GICT Task', 
    
    tabPanel(
      title = 'POST', 
      
      tags$h1('My title'), 
      textInput(
        inputId = 'fullnames', 
        label = 'Full Names',
        value = 'John Wick'
        # placeholder = 'eg. John Wick'
      ), 
      
      textInput(
        inputId = 'email', 
        label = 'Email:', 
        value = 'myemail@email.com'
        # placeholder = 'eg. you@email.com'
      ), 
      
      textInput(
        inputId = 'phone', 
        label = 'Phone Number:', 
        value = '+254712345672'
        # placeholder = 'eg. +254712345672'
      ), 
      
      textInput(
        inputId = 'address', 
        label = 'Address', 
        value = 'po box 256'
        # placeholder = 'eg. po box 256'
      ), 
      
      actionButton(
        inputId = 'submit', 
        label = 'Submit'
      )
    ), 
    
    tabPanel(
      title = 'GET', 
      
      actionButton(
        inputId = 'get', 
        label = 'GET'
      )
    )
  )
)
