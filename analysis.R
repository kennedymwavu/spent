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

plt_amt_per_month <- amt_per_month[
  , 
  list(
    # last day of col `month`:
    month = lubridate::ceiling_date(x = lubridate::my(month), unit = 'month') - 
      lubridate::days(1), 
    amount
  )
] |> 
  echarts4r::e_charts_(x = 'month') |> 
  echarts4r::e_line_(serie = 'amount', smooth = TRUE, name = 'Amount') |> 
  echarts4r::e_color(color = '#44acb4') |> 
  echarts4r::e_title(text = 'Amount Per Month') |> 
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

# top n most bought items:
n <- 10

plt_top_n_items <- items[, list(freq = .N), by = 'item'][
  order(-freq), .SD[seq_len(n)]
][order(freq)] |> 
  echarts4r::e_charts_(x = 'item') |> 
  echarts4r::e_bar_(serie = 'freq', name = 'Item') |> 
  echarts4r::e_color(color = '#44acb4') |> 
  echarts4r::e_legend(show = FALSE) |> 
  echarts4r::e_title(text = 'Most Bought Items By Frequency') |> 
  echarts4r::e_tooltip(trigger = 'item') |> 
  echarts4r::e_flip_coords() |> 
  echarts4r::e_toolbox_feature(feature = "saveAsImage")

# Most expensive item?
spt[, .SD[which.max(amount)]]

# Top n most expensive items I've bought
n <- 5

tbl_top_most_expensive_items <- 
spt[order(-price), .SD[seq_len(n)], .SDcols = -c('datetime')]

# Least expensive item?
spt[, .SD[which.min(amount)]]

# store frequency:
# first count by datetime & store, then count by store alone:
plt_store_freq <- spt[, list(freq = .N), by = c('datetime', 'store')][
  , list(freq = .N), by = 'store'
  ][order(freq)] |> 
  echarts4r::e_charts_(x = 'store') |> 
  echarts4r::e_bar_(serie = 'freq', name = 'Store') |> 
  echarts4r::e_color(color = '#44acb4') |> 
  echarts4r::e_legend(show = FALSE) |> 
  echarts4r::e_title(text = 'Frequency at each store') |> 
  echarts4r::e_tooltip(trigger = 'item') |> 
  echarts4r::e_flip_coords() |> 
  echarts4r::e_toolbox_feature(feature = "saveAsImage")

# Which hour of the day do I mostly go for shopping?
plt_hr_freq <- spt[, .N, by = 'datetime'][
  , list(hr = lubridate::hour(datetime))
] |> 
  echarts4r::e_charts_() |> 
  echarts4r::e_histogram_(serie = 'hr', name = 'Frequency') |> 
  echarts4r::e_color(color = '#44acb4') |> 
  echarts4r::e_legend(show = FALSE) |> 
  echarts4r::e_axis_labels(x = 'Hour') |> 
  echarts4r::e_title(text = 'Time of day I go for shopping') |> 
  echarts4r::e_tooltip(trigger = 'item') |> 
  echarts4r::e_toolbox_feature(feature = "saveAsImage")


