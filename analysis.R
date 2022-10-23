spt <- data.table::fread(file = 'spt.csv')

# add amount column:
spt[, amount := qty * price]

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
    Month = lubridate::ceiling_date(x = lubridate::my(month), unit = 'month') - 
      lubridate::days(1), 
    Amount = amount
  )
] |> 
  echarts4r::e_charts_(x = 'Month') |> 
  echarts4r::e_line_(serie = 'Amount', smooth = TRUE) |> 
  echarts4r::e_axis_labels(y = 'Amount (KES)') |> 
  echarts4r::e_title(text = 'Amount Per Month') |> 
  echarts4r::e_tooltip(
    trigger = 'item', 
    axisPointer = list(
      type = 'cross'
    )
  )

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

# top 10 most bought items:
n <- 10
items[, list(freq = .N), by = 'item'][order(-freq), .SD[seq_len(n)]]

# Most expensive item?
spt[, .SD[which.max(amount)]]

# Least expensive item?
spt[, .SD[which.min(amount)]]
