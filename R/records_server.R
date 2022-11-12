#' records server module
#'
#' @param id module id
#'
#' @noRd
records_server <- function(id) {
  moduleServer(
    id = id, 
    module = function(input, output, session) {
      ns <- NS(id)
      
      f <- firebase::FirebaseUI$
        new()$ # instantiate
        set_providers( # define providers
          email = TRUE
        )$
        launch() # launch
      
      observeEvent(f$get_signed_in(), {
        x <- f$get_signed_in()
        
        if (identical(x$response$uid, Sys.getenv('my_uid'))) {
          shinytoastr::toastr_success(
            message = 'Signed In!', 
            closeButton = TRUE, 
            progressBar = TRUE
          )
          
          updateTabsetPanel(
            session = session, 
            inputId = 'tab_set_panel', 
            selected = 'records'
          )
          
          # jump out of this observeEvent:
          return(NULL)
        }
        
        # otherwise, if the user is not me:
        if (isTruthy(x$success)) {
          shinytoastr::toastr_success(
            message = 'Signed In!', 
            closeButton = TRUE, 
            progressBar = TRUE, 
            timeOut = 1e5
          )
          
          shinytoastr::toastr_warning(
            title = 'Save permission denied!', 
            message = paste0(
              'There can be only one Lord of the Rings, only one who can bend ', 
              'them to his will. And he does not share power!'
            ), 
            closeButton = TRUE, 
            timeOut = 0
          )
          
          updateTabsetPanel(
            session = session, 
            inputId = 'tab_set_panel', 
            selected = 'records'
          )
          
          # disable save btn:
          shinyjs::disable(id = 'save')
          
          # jump out of this observeEvent:
          return(NULL)
        }
        
        # if we haven't yet jumped out of this observeEvent, show error:
        shinytoastr::toastr_error(
          message = 'There was an error signing you in', 
          closeButton = TRUE, 
          timeOut = 0
        )
        
        updateTabsetPanel(
          session = session, 
          inputId = 'tab_set_panel', 
          selected = 'records'
        )
      },
      ignoreNULL = TRUE
      )
      
      rv_table <- reactiveValues(
        tbl = NULL, 
        dt_row = NULL,
        add_or_edit = NULL,
        edit_button = NULL,
        keep_track_id = NULL
      )
      
      # read in csv file (as a reactive for convenience, not necessary):
      r_spt <- reactive({
        data.table::fread(file = 'spt.csv')
      })
      
      observeEvent(r_spt(), {
        newtable <- r_spt()
        
        # create btns:
        btns <- create_buttons(ns = ns, btn_ids = seq_len(nrow(newtable)))
        
        # add the btns as a column to newtable:
        newtable$Buttons <- btns
        
        rv_table$tbl <- newtable
        
        # update keep track id:
        rv_table$keep_track_id <- nrow(newtable) + 1
      })
      
      output$table <- DT::renderDT({
        # column names: don't include the last column name `Buttons`:
        touse <- c(
          'Datetime', 'Store', 'Item', 'Quantity', 'Price (KES)', ''
        )
        
        DT::datatable(
          data = rv_table$tbl, 
          rownames = FALSE, 
          colnames = touse, 
          escape = FALSE, 
          selection = 'single', 
          class = c('display', 'nowrap'), 
          options = list(
            processing = FALSE, 
            scrollX = TRUE, 
            lengthChange = FALSE, 
            columnDefs = list(
              list(
                className = 'dt-center', targets = '_all'
              )
            )
          )
        ) |> 
          DT::formatCurrency(
            columns = c('price'), 
            currency = ''
          )
      })
      
      proxy <- DT::dataTableProxy('table')
      
      shiny::observe({
        DT::replaceData(
          proxy = proxy,
          data = rv_table$tbl,
          resetPaging = FALSE,
          rownames = FALSE
        )
      })
      
      # delete----
      observeEvent(input$current_id, {
        req(
          isTruthy(input$current_id) & 
            stringr::str_detect(input$current_id, pattern = 'delete')
        )
        
        rv_table$dt_row <- which(
          stringr::str_detect(
            rv_table$tbl$Buttons, 
            pattern = paste0('\\b', input$current_id, '\\b')
          )
        )
        
        rv_table$tbl <- rv_table$tbl[-rv_table$dt_row, ]
      })
      
      # edit----
      # when edit button is clicked, modal dialog shows current editable row 
      # filled out:
      observeEvent(input$current_id, {
        req(
          isTruthy(input$current_id) & 
            stringr::str_detect(input$current_id, pattern = 'edit')
        )
        
        rv_table$dt_row <- which(
          stringr::str_detect(
            rv_table$tbl$Buttons, pattern = paste0('\\b', input$current_id, '\\b')
          )
        )
        
        df <- rv_table$tbl[rv_table$dt_row, ]
        
        modal_dialog(
          ns = ns, 
          datetime = df$datetime, 
          store = df$store, 
          item = df$item, 
          qty = df$qty, 
          price = df$price, 
          edit = TRUE
        )
        
        rv_table$add_or_edit <- NULL
      })
      
      # when final edit button is clicked, table will be changed:
      observeEvent(input$final_edit, {
        req(
          isTruthy(input$current_id) & 
            stringr::str_detect(input$current_id, pattern = "edit") & 
            is.null(rv_table$add_or_edit)
        )
        
        rv_table$edited_row <- data.frame(
          datetime = lubridate::ymd_hms(input$datetime), 
          store = input$store, 
          item = input$item, 
          qty = input$qty, 
          price = input$price, 
          Buttons = rv_table$tbl$Buttons[rv_table$dt_row]
        )
        
        rv_table$tbl[rv_table$dt_row, ] <- rv_table$edited_row
      })
      
      # add----
      observeEvent(input$add_row, {
        modal_dialog(
          ns = ns, 
          datetime = lubridate::now() |> as.character(), 
          store = '', 
          item = '', 
          qty = 1, 
          price = 0, 
          edit = FALSE
        )
        
        rv_table$add_or_edit <- 1
      })
      
      observeEvent(input$final_edit, {
        req(rv_table$add_or_edit == 1)
        
        add_row <- data.frame(
          datetime = lubridate::ymd_hms(input$datetime), 
          store = input$store, 
          item = input$item, 
          qty = input$qty, 
          price = input$price, 
          Buttons = create_buttons(ns = ns, btn_ids = rv_table$keep_track_id)
        )
        
        rv_table$tbl <- rbind(rv_table$tbl, add_row)
        
        rv_table$keep_track_id <- rv_table$keep_track_id + 1
      })
      
      # remove modal when requested:
      observeEvent(input$dismiss_modal, {
        removeModal()
      })
      
      observeEvent(input$final_edit, {
        removeModal()
      })
      
      # save changes:
      observeEvent(input$save, {
        x <- f$get_signed_in()
        
        # if user is not signed in, take them to sign in page:
        if (!isTruthy(x$success)) {
          updateTabsetPanel(
            session = session, 
            inputId = 'tab_set_panel', 
            selected = 'sign_in'
          )
          
          # reset loading btn:
          shinyFeedback::resetLoadingButton(
            inputId = 'save', 
            session = session
          )
          
          shinytoastr::toastr_info(
            message = 'You have to be signed in to save any changes.'
          )
          
          # jump out of this observeEvent:
          return(NULL)
        }
        
        # if it's me, go ahead and save changes:
        if (identical(x$response$uid, Sys.getenv('my_uid'))) {
          spt <- rv_table$tbl[, .SD, .SDcols = -c('Buttons')]
          data.table::fwrite(x = spt, file = 'spt.csv')
          
          shinyFeedback::resetLoadingButton(
            inputId = 'save', 
            session = session
          )
          
          shinytoastr::toastr_success(
            message = 'Changes Saved!', 
            position = 'bottom-center', 
            closeButton = TRUE, 
            progressBar = TRUE
          )
          
          Sys.sleep(1.5)
          
          # hide btn after saving:
          shinyjs::hide(
            id = 'div_save_btn'
          )
          
          return(NULL)
        }
        
        # if user is signed in but it's not me:
        if (
          isTruthy(x$success) && 
          !identical(x$response$uid, Sys.getenv('my_uid'))
        ) {
          shinytoastr::toastr_warning(
            title = 'Save permission denied!', 
            message = paste0(
              'There can be only one Lord of the Rings, only one who can bend ', 
              'them to his will. And he does not share power!'
            ), 
            closeButton = TRUE, 
            timeOut = 0
          )
          
          return(NULL)
        }
      })
      
      # show save btn when there's a change in table:
      observeEvent(rv_table$tbl, {
        shinyjs::show(
          id = 'div_save_btn'
        )
      }, 
        ignoreInit = TRUE
      )
    }
  )
}
