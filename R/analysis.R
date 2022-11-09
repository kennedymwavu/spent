spt <- data.table::fread(file = 'spt.csv')
echarts4r::e_common(
  font_family = "monospace",
  theme = NULL
)

# add amount column:
spt[, amount := qty * price]

# rnm `Eastleigh Mattresses Limited - Kitengela` to `EastMatt - Kitengela`:
spt[
  store == 'Eastleigh Mattresses Limited - Kitengela', 
  store := 'EastMatt - Kitengela'
][
  # safaricom house:
  grep(pattern = 'safaricom', x = store, ignore.case = TRUE), 
  store := 'Safaricom HSE'
][
  # Joy Super Bites Mandazi 180G:
  grep(pattern = 'Joy Super Bites Mandazi 180G', x = item, ignore.case = TRUE), 
  item := 'Joy Bites'
]

# arrange rows by datetime:
data.table::setorderv(x = spt, cols = 'datetime', order = -1)

# Total amount I've spent so far? (monthly shopping + other home items):
total_amount <- spt[, sum(amount)]

# monthly stats----
# format datetime col as month-year eg. Oct 2022:
spt[, month := format(x = datetime, '%b %Y')]

# how much per month?
amt_per_month <- spt[, .(amount = sum(amount)), by = 'month']
amt_per_month_dt <- DT::datatable(
  data = amt_per_month, 
  rownames = FALSE, 
  colnames = c('Month', 'Amount'), 
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
    columns = c('amount'), 
    currency = ''
  )

# on average:
avg_per_month <- amt_per_month[, mean(amount, na.rm = TRUE)]

plt_amt_per_month <- amt_per_month[
  , 
  list(
    # last day of col `month`:
    month = lubridate::ceiling_date(x = lubridate::my(month), unit = 'month') - 
      lubridate::days(1), 
    amount
  )
] |> 
  echarts4r::e_charts_(
    x = 'month', 
    grid = list(
      left = '3%',
      right = '4%',
      bottom = '3%',
      containLabel = TRUE
    )
  ) |> 
  echarts4r::e_line_(
    serie = 'amount', 
    smooth = TRUE, 
    name = 'Amount'
  ) |> 
  echarts4r::e_x_axis_(
    axisLabel = list(
      interval = 0, 
      rotate = 30
    )
  ) |> 
  echarts4r::e_color(color = '#44acb4') |> 
  echarts4r::e_title(
    text = 'Amount Per Month', 
    show = FALSE
  ) |> 
  echarts4r::e_legend(show = FALSE) |> 
  echarts4r::e_tooltip(
    trigger = 'item', 
    axisPointer = list(
      type = 'cross'
    ), 
    # format values by adding 'Kshs' prefix:
    # ref: https://stackoverflow.com/a/14428340/16246909
    valueFormatter = htmlwidgets::JS("
    function(value){
      return('Ksh ' + (Number(value)).toFixed(2).replace(/\\d(?=(\\d{3})+\\.)/g, '$&,'));
    }
  ")
  ) |> 
  echarts4r::e_toolbox_feature(feature = "saveAsImage")

# which month did I spend the most?
highest_spending_month <- amt_per_month[, .SD[which.max(amount)]]

# items bought in that month:
highest_spending_month_items <- 
  spt[highest_spending_month[, -c('amount')], on = 'month']

# which month did I spend the least?
least_spending_month <- amt_per_month[, .SD[which.min(amount)]]

# items bought in that month:
least_spending_month_items <- 
  spt[least_spending_month[, -c('amount')], on = 'month']

# item stats----
# top 10 most bought items:

# but we first need to combine similar items of different specs
items <- data.table::copy(spt)[
  # Blue King body wash:
  grep(pattern = 'Blue King', x = item, ignore.case = TRUE), 
  item := 'Blue King Body Wash'
][
  # Bread:
  grep(pattern = 'Barrel|Bread', x = item, ignore.case = TRUE), 
  item := 'Bread'
][
  # Cooking oil:
  grep(pattern = 'Fresh Fri', x = item, ignore.case = TRUE), 
  item := 'Cooking Oil'
][
  # Air Freshner:
  grep(pattern = 'Lovin It', x = item, ignore.case = TRUE), 
  item := 'Air Freshner'
][
  # Milk:
  grep(
    pattern = 'Fresha|Tuzo|Brookside|Dairy Best', x = item, ignore.case = TRUE
  ), 
  item := 'Milk'
][
  # shopping bags:
  grep(
    pattern = 'non wooven|shopping bag', x = item, ignore.case = TRUE
  ), 
  item := 'Shopping Bag'
][
  # tissue paper:
  grep(pattern = 't/paper', x = item, ignore.case = TRUE), 
  item := 'Tissue Paper'
][
  # serviettes:
  grep(pattern = 'serviettes', x = item, ignore.case = TRUE), 
  item := 'Serviettes'
][
  # morning fresh:
  grep(pattern = 'Morning F/D/W|Morning Fresh', x = item, ignore.case = TRUE), 
  item := 'Morning Fresh'
][
  # Downy:
  grep(pattern = 'Downy F', x = item, ignore.case = TRUE), 
  item := 'Downy'
][
  # maize meal:
  grep(pattern = 'maize', x = item, ignore.case = TRUE), 
  item := 'Maize Meal'
][
  # rice:
  grep(pattern = 'rice', x = item, ignore.case = TRUE), 
  item := 'Rice'
][
  # bar soap:
  grep(pattern = 'soap|geisha', x = item, ignore.case = TRUE), 
  item := 'Bar Soap'
][
  # toothpaste:
  grep(
    pattern = 'Colgate Tp CDC Charcoal Gentle|Colgate Dental Cream MCP|Colgate Tripple Action', 
    x = item, 
    ignore.case = TRUE
  ), 
  item := 'Toothpaste'
][
  # body lotion:
  grep(pattern = 'versman', x = item, ignore.case = TRUE), 
  item := 'Versman Body Lotion'
][
  # detergent:
  grep(pattern = 'ariel', x = item, ignore.case = TRUE), 
  item := 'Ariel Detergent'
][
  # tea bags:
  grep(pattern = 'kericho', x = item, ignore.case = TRUE), 
  item := 'Tea Bags'
][
  # yoghurt:
  grep(pattern = 'yoghurt', x = item, ignore.case = TRUE), 
  item := 'Yoghurt'
][
  # hand wash:
  grep(pattern = 'field', x = item, ignore.case = TRUE), 
  item := 'Hand Wash'
][
  # royco:
  grep(pattern = 'royco', x = item, ignore.case = TRUE), 
  item := 'Royco'
][
  # nescafe:
  grep(pattern = 'nescafe', x = item, ignore.case = TRUE), 
  item := 'Nescafe'
][
  # harpic:
  grep(pattern = 'harpic', x = item, ignore.case = TRUE), 
  item := 'Harpic'
]

# top n most bought items plot: analysis_server 'plt_top_n_items'

# most bought item:
most_bought_item <- items[
  , 
  list(freq = .N), by = 'item'][, .SD[which.max(freq)]
]

# Most expensive item?
most_expensive_item <- spt[, .SD[which.max(amount)]]

# Top n most expensive items I've bought: 
# analysis_server 'top_most_expensive_items'

# Least expensive item?
spt[, .SD[which.min(amount)]]

# store frequency: pie chart of percentages
# first count by datetime & store, then count by store alone:
store_freq <- spt[, list(freq = .N), by = c('datetime', 'store')][
  , list(freq = .N), by = 'store'
][, freq := round(freq, digits = 2)][
  store == 'Text Book Centre Limited (TBC CBD)', 
  store := 'TBC CBD'
]

store_freq[, percent := round(freq / sum(freq), digits = 2)]

most_freq_store <- store_freq[, .SD[which.max(freq)]]

plt_store_freq <- store_freq |> 
  echarts4r::e_charts_(
    x = 'store', 
    grid = list(
      left = '3%',
      right = '4%',
      bottom = '3%',
      containLabel = TRUE
    )
  ) |> 
  echarts4r::e_pie_(
    serie = 'freq', 
    name = '', 
    emphasis = list(
      itemStyle = list(
        shadowBlur = 10, 
        shadowOffsetX = 0, 
        shadowColor = 'rgba(0, 0, 0, 0.5)'
      ), 
      
      label = list(
        show = TRUE, 
        # fontSize = '40', 
        fontWeight = 'bold'
      )
    ), 
    labelLine = list(show = FALSE), 
    label = list(formatter = '{b}: {d}%', show = FALSE, position = 'center'), 
    avoidLabelOverlap = FALSE, 
    encode = list(itemName = 'store', value = 'freq', tooltip = 'freq'), 
    radius = c('40%', '70%'),
    center = c('50%', '50%')
  ) |> 
  echarts4r::e_tooltip(
    trigger = 'item', 
    valueFormatter = htmlwidgets::JS(
      "function(value) {
        if (value == 1) {
          return(value + ' time')
        }
        
        return(value + ' times')
      }"
    ), 
    showContent = FALSE
  ) |> 
  echarts4r::e_legend(show = FALSE) |> 
  echarts4r::e_title(
    text = 'Store Frequency', 
    left = 'center', 
    show = FALSE
  ) |> 
  echarts4r::e_toolbox_feature(feature = "saveAsImage")

# Which hour of the day do I mostly go for shopping?
morning <- 0:11
afternoon <- 12:16
evening <- c(17:23)

day_hrs <- c(
  rep('Morning', times = length(morning)), 
  rep('Afternoon', times = length(afternoon)), 
  rep('Evening', times = length(evening))
)

names(day_hrs) <- as.character(0:23)

hr_freq <- spt[, .N, by = 'datetime'][
  , list(hr = lubridate::hour(datetime))
]

most_freq_hr <- hr_freq[, list(freq = .N), by = 'hr'][, .SD[which.max(freq)]][
  , 
  c(hr)
]

day_label <- day_hrs[as.character(most_freq_hr)]

plt_hr_freq <- hr_freq |> 
  echarts4r::e_charts_(
    grid = list(
      left = '3%',
      right = '4%',
      bottom = '3%',
      containLabel = TRUE
    )
  ) |> 
  echarts4r::e_histogram_(serie = 'hr', name = 'Frequency') |> 
  echarts4r::e_color(color = '#44acb4') |> 
  echarts4r::e_legend(show = FALSE) |> 
  echarts4r::e_axis_labels(x = 'Hour') |> 
  echarts4r::e_title(
    text = 'Time of day I go for shopping', 
    show = FALSE
  ) |> 
  echarts4r::e_tooltip(trigger = 'item') |> 
  echarts4r::e_toolbox_feature(feature = "saveAsImage")


