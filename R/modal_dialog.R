#' Edit row modal
#' 
#' @param ns [shiny::NS()] obj. Namespace of the module from which this modal 
#' is called.
#' @param datetime Date and Time: [lubridate::dmy_hms()]
#' @param store The store I bought items from
#' @param item Name of item
#' @param qty Quantity of item
#' @param price Price of a single unit of item
#' @param edit Whether we're making an edit (TRUE) or a new row (FALSE)
#'
#' @return shiny::modalDialog
#' @noRd
modal_dialog <- function(ns, datetime, store, item, qty, price, edit) {
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
          inputId = ns(id = 'datetime'),
          label = 'Date and Time',
          value = datetime,
          placeholder = 'yyyy-mm-dd H:M:S',
          width = '200px'
        )
      ), 
      
      tags$div(
        style = 'display: inline-block;', 
        
        textInput(
          inputId = ns(id = 'store'),
          label = 'Store',
          value = store,
          width = '200px'
        )
      ), 
      
      tags$div(
        style = 'display: inline-block;', 
        
        textInput(
          inputId = ns(id = 'item'),
          label = 'Item',
          value = item,
          width = '200px'
        )
      ), 
      
      tags$div(
        style = 'display: inline-block;', 
        
        shinyWidgets::autonumericInput(
          inputId = ns(id = 'qty'),
          label = 'Quantity',
          value = qty, 
          width = '200px'
        )
      ), 
      
      tags$div(
        style = 'display: inline-block;', 
        
        shinyWidgets::autonumericInput(
          inputId = ns(id = 'price'),
          label = 'Price',
          value = price, 
          currencySymbol = 'KES ', 
          width = '200px'
        )
      )
    )
  ) |> 
    shiny::showModal()
}
