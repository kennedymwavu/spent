#' POST UI module
#'
#' @param id module id
#'
#' @return A shiny::tagList obj
#' @noRd
analysis_ui <- function(id) {
  ns <- NS(namespace = id)
  
  shiny::tagList(
    tags$div(
      class = 'mycontainer',
      
      bslib::layout_column_wrap(
        width = '300px', 
        
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
        
        bslib::layout_column_wrap(
          width = 1, 
          
          bslib::value_box(
            title = 'Highest Expenditure Month',
            value = highest_spending_month[, format_currency(c(amount))],
            showcase = icon(name = 'up-long', class = 'fa-solid fa-up-long'), 
            showcase_layout = bslib::showcase_left_center(), 
            tags$p(highest_spending_month[, c(month)]), 
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
          )
        )
      ), 
      
      tags$div(
        class = 'container', 
        
        plt_amt_per_month
      ), 
      
      bslib::layout_column_wrap(
        width = 1 / 2, 
        
        bslib::value_box(
          title = 'Most Frequently Bought Item',
          value = most_bought_item[, c(item)], 
          showcase = icon(
            name = 'basket-shopping', 
            class = 'fa-solid fa-basket-shopping'
          ), 
          showcase_layout = bslib::showcase_left_center(), 
          tags$p(
            paste0(most_bought_item[, c(freq)], ' Times')
          ), 
          full_screen = FALSE, 
          theme_color = 'primary'
        ), 
        
        bslib::value_box(
          title = 'Most Expensive Item Bought',
          value = most_expensive_item[, c(item)], 
          showcase = icon(
            name = 'money-bill-trend-up', 
            class = 'fa-solid fa-money-bill-trend-up'
          ), 
          showcase_layout = bslib::showcase_left_center(), 
          tags$p(
            format_currency(most_expensive_item[, c(amount)])
          ), 
          full_screen = FALSE, 
          theme_color = 'primary'
        )
      ), 
      
      bslib::layout_column_wrap(
        width = 1 / 2, 
        
        tags$div(
          selectInput(
            inputId = ns(id = 'top_n_items'), 
            label = 'N', 
            # the least to compare is 3 items:
            choices = seq_along(items[, unique(item)])[-c(1:2)] |> as.character(), 
            selected = '5'
          ), 
          
          echarts4r::echarts4rOutput(outputId = ns(id = 'plt_top_n_items'))
        ), 
        
        DT::DTOutput(outputId = ns(id = 'top_most_expensive_items'))
      ), 
      
      bslib::layout_column_wrap(
        width = 1 / 2, 
        fill = FALSE, 
        
        bslib::value_box(
          title = 'Most Frequented Store', 
          value = most_freq_store[, c(store)], 
          showcase = icon(
            name = 'store', 
            class = 'fa-solid fa-store'
          ), 
          showcase_layout = bslib::showcase_left_center(), 
          tags$p(
            paste0(
              most_freq_store[, c(percent * 100)], 
              '% of the times'
            )
          ), 
          full_screen = FALSE, 
          theme_color = 'primary'
        ), 
        
        plt_store_freq
      ), 
      
      bslib::layout_column_wrap(
        width = 1 / 2, 
        fill = FALSE, 
        
        plt_hr_freq, 
        
        bslib::value_box(
          title = 'Time of day I mostly go for shopping', 
          value = day_label, 
          showcase = icon(
            name = 'clock', 
            class = 'fa-solid fa-clock'
          ), 
          showcase_layout = bslib::showcase_left_center(), 
          tags$p(
            'Usually after work'
          ), 
          full_screen = FALSE, 
          theme_color = 'primary'
        )
      )
    )
  )
}
