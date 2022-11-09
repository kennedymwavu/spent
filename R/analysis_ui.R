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
      
      tags$div(
        class = 'pt-2 pb-2 mb-5 fade-in', 
        
        bslib::card(
          bslib::card_title('Monthly stats'), 
          
          bslib::card_body_fill(
            tags$div(
              class = 'm-2', 
              
              bslib::layout_column_wrap(
                width = '400px', 
                
                bslib::layout_column_wrap(
                  width = 1, 
                  
                  bslib::value_box(
                    title = 'Highest expenditure month',
                    value = highest_spending_month[, format_currency(c(amount))],
                    showcase = icon(name = 'up-long', class = 'fa-solid fa-up-long'), 
                    showcase_layout = bslib::showcase_left_center(), 
                    tags$p(highest_spending_month[, c(month)]), 
                    full_screen = FALSE, 
                    theme_color = 'info'
                  ), 
                  
                  bslib::value_box(
                    title = 'Least expenditure month',
                    value = least_spending_month[, format_currency(c(amount))],
                    showcase = icon(
                      name = 'down-long', 
                      class = 'down-solid fa-up-long'
                    ), 
                    showcase_layout = bslib::showcase_left_center(), 
                    tags$p(least_spending_month[, c(month)]), 
                    full_screen = FALSE, 
                    theme_color = 'info'
                  )
                ), 
                
                bslib::value_box(
                  title = 'Average per month',
                  value = format_currency(avg_per_month),
                  showcase = icon(
                    name = 'hand-holding-dollar', 
                    class = 'fa-icon fa-hand-holding-dollar'
                  ),
                  showcase_layout = bslib::showcase_left_center(), 
                  full_screen = FALSE, 
                  theme_color = 'success'
                )
              )
            ), 
            
            tags$div(
              class = 'm-2', 
              
              tags$div(
                class = 'container', 
                
                bslib::card(
                  bslib::card_title('Amount per month'), 
                  
                  bslib::card_body_fill(
                    echarts4r::echarts4rOutput(
                      outputId = ns(id = 'plt_amt_per_month')
                    ) |> 
                      shinycssloaders::withSpinner(
                        type = 2, 
                        color.background = 'white'
                      )
                  )
                )
              )
            )
          )
        )
      ), 
      
      tags$div(
        class = 'pt-2 pb-2 mb-5 fade-in', 
        
        bslib::card(
          bslib::card_title('Item Stats'), 
          
          bslib::card_body_fill(
            tags$div(
              class = 'm-2', 
              
              selectInput(
                inputId = ns(id = 'top_n_items'), 
                label = NULL, 
                # the least to compare is 3 items:
                choices = seq_along(items[, unique(item)])[-c(1:2)] |> 
                  as.character(), 
                selected = '5'
              )
            ), 
            
            bslib::layout_column_wrap(
              width = 1 / 2, 
              
              tags$div(
                class = 'm-2', 
                
                bslib::layout_column_wrap(
                  width = '400px', 
                  
                  bslib::value_box(
                    title = 'Most frequently bought item',
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
                    theme_color = 'success'
                  )
                ), 
                
                bslib::layout_column_wrap(
                  width = 1, 
                  
                  bslib::card(
                    bslib::card_title(
                      textOutput(outputId = ns(id = 'card_header_plt_top_n_items'))
                    ), 
                    
                    bslib::card_body_fill(
                      echarts4r::echarts4rOutput(
                        outputId = ns(id = 'plt_top_n_items')
                      )
                    )
                  )
                )
              ), 
              
              tags$div(
                class = 'm-2', 
                
                bslib::layout_column_wrap(
                  width = '400px', 
                  
                  bslib::value_box(
                    title = 'Most expensive item bought',
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
                  width = 1, 
                  
                  bslib::card(
                    bslib::card_title(
                      textOutput(
                        outputId = ns(id = 'title_top_most_expensive_items')
                      )
                    ), 
                    
                    bslib::card_body_fill(
                      tags$div(
                        align = 'center', 
                        
                        DT::DTOutput(
                          outputId = ns(id = 'top_most_expensive_items'), 
                          width = '600px'
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
      ), 
      
      tags$div(
        class = 'pt-2 pb-2 mb-5 fade-in', 
        
        bslib::card(
          bslib::card_title('Store and time stats'), 
          
          bslib::card_body_fill(
            bslib::layout_column_wrap(
              width = 1 / 2, 
              
              tags$div(
                class = 'm-2', 
                
                bslib::layout_column_wrap(
                  width = '400px', 
                  
                  bslib::value_box(
                    title = 'Most frequently visited store', 
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
                  )
                ), 
                
                
                bslib::layout_column_wrap(
                  width = 1, 
                  
                  bslib::card(
                    bslib::card_title('Store frequency'), 
                    
                    bslib::card_body_fill(
                      echarts4r::echarts4rOutput(outputId = ns(id = 'plt_store_freq'))
                    )
                  )
                )
              ), 
              
              tags$div(
                class = 'm-2', 
                
                bslib::layout_column_wrap(
                  width = '400px', 
                  
                  bslib::value_box(
                    title = 'Period of day I mostly go for shopping', 
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
                    theme_color = 'success'
                  )
                ), 
                
                bslib::layout_column_wrap(
                  width = 1, 
                  
                  bslib::card(
                    bslib::card_title('Time of day I go for shopping'), 
                    
                    bslib::card_body_fill(
                      echarts4r::echarts4rOutput(outputId = ns(id = 'plt_hr_freq'))
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
}
