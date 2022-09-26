#' Create buttons
#'
#' @param btn_ids Button IDs
#'
#' @return character vector
#' @noRd
create_buttons <- function(btn_ids) {
  vapply(
    X = btn_ids, 
    FUN = function(id) {
      edit_btn <- tags$button(
        class = 'btn btn-default action-button btn-info action_button', 
        id = paste0('edit_', id), 
        type = 'button', 
        onclick = 'get_id(this.id)', 
        tags$i(class = 'fas fa-edit')
      )
      
      delete_btn <- tags$button(
        class = 'btn btn-default action-button btn-danger action_button', 
        id = paste0('delete_', id), 
        type = 'button', 
        onclick = 'get_id(this.id)', 
        tags$i(class = 'fa fa-trash-alt')
      )
      
      tags$div(
        class = 'btn-group', 
        edit_btn, 
        delete_btn
      ) |> 
        as.character()
    }, 
    FUN.VALUE = 'a'
  )
}