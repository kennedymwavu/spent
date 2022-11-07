#' POST UI module
#'
#' @param id module id
#'
#' @return A shiny::tagList obj
#' @noRd
analysis_ui <- function(id) {
  ns <- NS(namespace = id)
  
  shiny::tagList(
    fluidRow(
      align = 'center', 
      class = 'mycontainer',
      
      bslib::value_box(
        title = 'Average Per Month',
        value = format_currency(avg_per_month),
        showcase = icon(
          name = 'hand-holding-dollar', 
          class = 'fa-icon fa-hand-holding-dollar'
        ),
        showcase_layout = bslib::showcase_left_center(), 
        full_screen = FALSE, 
        theme_color = 'primary'
      ), 
      
      bslib::value_box(
        title = 'Least Expenditure Month',
        value = least_spending_month[, format_currency(c(amount))],
        showcase = icon(name = 'down-long', class = 'down-solid fa-up-long'), 
        showcase_layout = bslib::showcase_left_center(), 
        tags$p(least_spending_month[, c(month)]), 
        full_screen = FALSE, 
        theme_color = 'primary'
      ), 
      
      bslib::value_box(
        title = 'Highest Expenditure Month',
        value = highest_spending_month[, format_currency(c(amount))],
        showcase = icon(name = 'up-long', class = 'fa-solid fa-up-long'), 
        showcase_layout = bslib::showcase_left_center(), 
        tags$p(highest_spending_month[, c(month)]), 
        full_screen = FALSE, 
        theme_color = 'primary'
      ), 
      
      plt_amt_per_month, 
      
      plt_top_n_items, 
      
      plt_store_freq, 
      
      plt_hr_freq
    )
  )
}
