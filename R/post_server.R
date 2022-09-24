#' POST server module
#'
#' @param id module id
#' @param post_url POST url
#'
#' @return NULL
#' @noRd
post_server <- function(id, post_url) {
  moduleServer(
    id = id, 
    module = function(input, output, session) {
      observeEvent(input$submit, {
        # Start displaying errors in the UI:
        iv$enable()
        
        # first make sure all inputs are supplied:
        if (!isTruthy(iv$is_valid())) {
          # show warning:
          shinytoastr::toastr_warning(
            message = 'Please make sure all inputs are valid', 
            title = 'Validation Error'
          )
          
          # reset loading btn:
          shinyFeedback::resetLoadingButton(
            inputId = 'submit', 
            session = session
          )
          
          return(NULL)
        }
        
        # if all is well, continue:
        tryCatch(
          expr = {
            r <- httr::POST(
              url = post_url, 
              body = list(
                fullnames = input$fullnames, 
                email = input$email, 
                phone = input$phone, 
                address = input$address
              ), 
              encode = 'json'
            )
            
            # get message/content returned by the request:
            msg <- httr::content(r, as = 'raw') |> rawToChar()
            
            # Throw error or warning when necessary:
            stop_for_status(r)
            warn_for_status(r)
            
            # If okay, show user success:
            shinytoastr::toastr_success(
              message = httr::content(r)$Message,
              title = 'Success!', 
              progressBar = TRUE, 
              position = 'top-center'
            )
            
            # reset loading btn:
            shinyFeedback::resetLoadingButton(
              inputId = 'submit', 
              session = session
            )
          }, 
          
          error = function(cond) {
            shinytoastr::toastr_error(
              message = msg
            )
            
            # reset loading btn:
            shinyFeedback::resetLoadingButton(
              inputId = 'submit', 
              session = session
            )
            
            # print the error on console for debugging:
            print(cond)
          }, 
          
          warning = function(cond) {
            shinytoastr::toastr_warning(
              message = msg
            )
            
            # print warning on console for debugging:
            print(cond)
          }
        )
      })
      
      # input validation----
      # 1. Create an InputValidator object:
      iv <- shinyvalidate::InputValidator$new()
      
      # 2. Add validation rules
      iv$add_rule('fullnames', shinyvalidate::sv_required())
      iv$add_rule('email', shinyvalidate::sv_required())
      iv$add_rule('email', shinyvalidate::sv_email())
      iv$add_rule('phone', shinyvalidate::sv_required())
      iv$add_rule('address', shinyvalidate::sv_required())
    }
  )
}
