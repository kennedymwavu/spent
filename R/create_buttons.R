#' Create buttons
#'
#' @param ns [shiny::NS()] obj. Namespace of the module from which this fn is 
#' called.
#' @param btn_ids Button IDs
#'
#' @return character vector
#' @noRd
create_buttons <- function(ns, btn_ids) {
  vapply(
    X = btn_ids, 
    FUN = function(id) {
      edit_btn <- tags$button(
        class = 'btn btn-default action-button btn-info action_button', 
        id = ns(id = paste0('edit_', id)), 
        type = 'button', 
        onclick = 'get_id(this.id)', 
        tags$i(class = 'fas fa-edit')
      )
      
      delete_btn <- tags$button(
        class = 'btn btn-default action-button btn-danger action_button', 
        id = ns(id = paste0('delete_', id)), 
        type = 'button', 
        onclick = 'get_id(this.id)', 
        tags$i(class = 'fa fa-trash-alt')
      )
      
      tags$div(
        class = 'btn-group', 
        style = 'display: flex; flex-wrap: nowrap;', 
        edit_btn, 
        delete_btn
      ) |> 
        as.character()
    }, 
    FUN.VALUE = 'a'
  )
}
