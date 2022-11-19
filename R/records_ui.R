#' records ui module
#'
#' @param id module id
#'
#' @return shiny::tagList
#' @noRd
records_ui <- function(id) {
  ns <- NS(id)
  
  shiny::tagList(
    tabsetPanel(
      id = ns(id = 'tab_set_panel'), 
      type = 'hidden', 
      
      tabPanelBody(
        value = 'records', 
        
        tags$div(
          class = 'mycontainer', 
          
          bslib::card(
            class = 'border-white', 
            
            bslib::card_body_fill(
              tags$div(
                class = 'container', 
                id = ns(id = 'div_records'), 
                
                tags$div(
                  class = 'record-btns', 
                  style = 'margin-top: 50px;', 
                  
                  actionButton(
                    inputId = ns(id = 'add_row'),
                    label = 'Add Row',
                    icon = icon('plus'),
                    class = 'btn-success'
                  ), 
                  
                  shinyjs::hidden(
                    tags$div(
                      id = ns('div_save_btn'), 
                      
                      shinyFeedback::loadingButton(
                        inputId = ns('save'),
                        label = 'Save Changes',
                        loadingLabel = 'Saving...',
                        loadingSpinner = 'sync',
                        class = 'btn btn-info'
                      )
                    )
                  )
                ), 
                
                tags$div(
                  style = 'margin-top: 50px;', 
                  
                  DT::DTOutput(outputId = ns(id = 'table')) |> 
                    shinycssloaders::withSpinner(
                      type = 2, 
                      color.background = 'white', 
                      hide.ui = FALSE
                    )
                )
              )
            )
          )
        )
      ), 
      
      tabPanelBody(
        value = 'sign_in', 
        
        tags$div(
          class = 'mycontainer mt-5', 
          
          firebase::firebaseUIContainer()
        )
      )
    )
  )
}
