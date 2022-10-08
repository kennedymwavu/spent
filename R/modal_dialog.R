#' Edit row modal
#'
#' @param ID Current row's ID value
#' @param Message Current row's Message value
#' @param Age Current row's Age value
#' @param edit Whether to edit row or not
#' @param ns [shiny::NS()] obj. Namespace of the module from which this modal 
#' is called.
#'
#' @return shiny::modalDialog
#' @noRd
modal_dialog <- function(ns, ID, Message, Age, edit) {
  x <- if (edit) 'Submit Edits' else 'Add New Row'
  
  shiny::modalDialog(
    title = 'Edit Table', 
    size = 'm',
    easyClose = TRUE,
    footer = tags$div(
      class = 'pull-right container', 
      
      actionButton(
        inputId = ns(id = 'final_edit'),
        label = x,
        icon = icon('edit'),
        class = 'btn-info'
      ), 
      
      actionButton(
        inputId = ns(id = 'dismiss_modal'),
        label = 'Close',
        class = 'btn-danger'
      )
    ), 
    
    # modal body:
    tags$div(
      class = "text-center", 
      
      tags$div(
        style = 'display: inline-block;', 
        
        textInput(
          inputId = ns(id = 'id'),
          label = 'ID',
          value = ID,
          placeholder = 'ID',
          width = '200px'
        )
      ), 
      
      tags$div(
        style = 'display: inline-block;', 
        
        textInput(
          inputId = ns(id = 'msg'),
          label = 'Message',
          value = Message,
          width = '200px'
        )
      ), 
      
      tags$div(
        style = 'display: inline-block;', 
        
        numericInput(
          inputId = ns(id = 'age'),
          label = 'Age',
          value = Age,
          width = '200px'
        )
      )
    )
  ) |> 
    shiny::showModal()
}
