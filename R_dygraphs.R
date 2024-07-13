#--------------------#
# R dygrahps package #
#--------------------#

library(quantmod)
library(dygraphs)

# getSymbols(): to get data
getSymbols("AAPL")
getSymbols("AAPL")
getSymbols("SPY")

price = OHLC(AAPL)
head(price, n=3)

# dygraph function
dygraph(OHLC(AAPL))

# shading
graph = dygraph(Cl(SPY), main = "SPY") 
dyShading(graph, from="2007-08-09", 
          to="2011-05-11", color="#FFE6E6")

# event line
graph = dygraph(OHLC(AAPL), main = "AAPL") 
graph = dyEvent(graph,"2007-6-29",
               "iphone", labelLoc = "bottom") 
graph = dyEvent(graph,"2010-5-6", 
               "Flash Crash", labelLoc = "bottom") 
graph = dyEvent(graph,"2014-6-6", 
               "Split", labelLoc = "bottom") 
dyEvent(graph,"2011-10-5",
        "Jobs", labelLoc = "bottom")

# candle chart
AAPL = tail(AAPL, n=30)
graph<-dygraph(OHLC(AAPL))
dyCandlestick(graph)

# reference: https://bookdown.org/kochiuyu/Technical-Analysis-with-R/dygraphs-package.html

# multiple plots on one graph
get_stock_data = function(ticker, start_date, end_date) {
  data = getSymbols(ticker, src = "yahoo", from = start_date, to = end_date, auto.assign = FALSE)
  # Removes the ticker name from column names
  colnames(data) <- gsub(paste0(ticker, "\\."), "", colnames(data))
  data <- data[, c("Volume", "Adjusted")]
  return(data)
}
aapl = get_stock_data(ticker = "AAPL", start_date = "2023-01-01", end_date = "2024-01-01")

aapl$VolumeScaled = aapl[, "Volume"] / 1000000
dygraph(aapl[, c("Adjusted", "VolumeScaled")], main = "Apple Stock Price (AAPL) and Trade Volume") %>%
  dySeries("Adjusted", label = "Adjusted Price (USD)", color = "#0198f9", drawPoints = TRUE, pointSize = 3, pointShape = "square") %>%
  dySeries("VolumeScaled", label = "Trade Volume (M)", stepPlot = TRUE, fillGraph = TRUE, color = "#FF9900")

# adjust axis

aapl = get_stock_data(ticker = "AAPL", start_date = "2023-01-01", end_date = "2024-01-01")
dygraph(aapl) %>%
  dySeries("Adjusted", label = "Adjusted Price (USD)", color = "#0198f9", drawPoints = TRUE, pointSize = 3, pointShape = "square") %>%
  dySeries("Volume", label = "Trade Volume (M)", stepPlot = TRUE, fillGraph = TRUE, color = "#FF9900", axis = "y2")

# reference: https://www.r-bloggers.com/2024/07/r-dygraphs-how-to-visualize-time-series-data-in-r-and-r-shiny/

