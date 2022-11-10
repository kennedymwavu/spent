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
  x <- if (edit) 'Submit' else 'Add New Row'
  
  shiny::modalDialog(
    title = 'Edit record', 
    size = 'm',
    easyClose = TRUE,
    footer = tags$div(
      class = 'd-flex justify-content-end m-1', 
      
      actionButton(
        inputId = ns(id = 'final_edit'),
        label = x,
        icon = icon(
          name = 'pen-to-square', 
          class = 'fa-solid fa-pen-to-square'
        ),
        class = 'btn-info m-2'
      ), 
      
      actionButton(
        inputId = ns(id = 'dismiss_modal'),
        label = 'Close', 
        icon = icon(
          name = 'x', 
          class = 'fa-solid fa-x'
        ), 
        class = 'btn-danger m-2'
      )
    ), 
    
    # modal body:
    tags$div(
      class = 'd-flex justify-content-center', 
      
      bslib::layout_column_wrap(
        width = 1, 
        fill = TRUE, 
        
        tags$div(
          class = 'm-2', 
          
          textInput(
            inputId = ns(id = 'datetime'),
            label = 'Date and Time',
            value = datetime,
            placeholder = 'yyyy-mm-dd H:M:S'
          )
        ), 
        
        tags$div(
          class = 'm-2', 
          
          textInput(
            inputId = ns(id = 'store'),
            label = 'Store',
            value = store
          )
        ), 
        
        tags$div(
          class = 'm-2', 
          
          textInput(
            inputId = ns(id = 'item'),
            label = 'Item',
            value = item
          )
        ), 
        
        tags$div(
          class = 'm-2', 
          
          shinyWidgets::autonumericInput(
            inputId = ns(id = 'qty'),
            label = 'Quantity',
            value = qty
          )
        ), 
        
        tags$div(
          class = 'm-2', 
          
          shinyWidgets::autonumericInput(
            inputId = ns(id = 'price'),
            label = 'Price',
            value = price, 
            currencySymbol = 'KES '
          )
        )
      )
    )
  ) |> 
    shiny::showModal()
}
