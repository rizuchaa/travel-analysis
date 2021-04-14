# install.packages("digest")
# devtools::install_github("RinteRface/bs4Dash")
# remotes::install_github("rstudio/htmltools")
# remotes::install_github("rstudio/shiny")
# remotes::install_github("rstudio/thematic", force = T)

library(bs4Dash)
library(shiny)
# library(plotly)
library(tidyverse)
library(dplyr)
library(thematic)
library(RColorBrewer)
library(ggiraph)
library(ggplot2)
library(reshape2)
library(DT)
library(highcharter)
library(htmlwidgets)
# Dataset ----------------------------------------------------------------------
travel <- read.csv("data/travel_insurance.csv")

names(travel)[names(travel)=="Destination"]<-"Country"
names(travel)[names(travel)=="Commision..in.value."]<-"Commision"

travel <- travel%>%
  filter(!grepl("-",Duration) & !grepl("118",Age))

travel$Gender[travel$Gender==""]<-"NB"

travel <- travel%>%
  mutate_if(is.character,as.factor)
data<-read.csv("data/countries_codes_and_coordinates.csv")


# plot 1 -----------------------------------------------------------------------
# plot1 <-travel%>%
#   plot_ly(
#     x = ~Duration, y = ~Commision..in.value.,
#     color = ~Product.Name, size = ~Age,
#     text = ~paste0(Product.Name, '<br>Duration: ', Duration, '<br>Commision: ', Commision..in.value.)
#   )%>%
#   layout(showlegend = FALSE)

plot1<-travel%>%
  select(Duration, Commision, Product.Name )

plot1<-highchart()%>%
  hc_add_series(plot1, "scatter", hcaes(x = Duration, 
                                        y = Commision, 
                                        group=Product.Name), 
                showInLegend=FALSE, tooltip=list(pointFormat="Duration: {point.Duration} Days <br> Commision: SGD{point.Commision} "))
  

plot1

# plot 2 -----------------------------------------------------------------------

plot2 <- travel%>% 
  select(Claim)%>%
  group_by(Claim)%>% 
  count(Claim, sort = T)%>% 
  hchart("pie", hcaes(x = Claim, y = n))

plot2


# plot 3 -----------------------------------------------------------------------
sectors<-travel%>%
  select(Product.Name, Agency)%>%
  group_by(Product.Name)%>%
  count(Product.Name)%>%
  arrange(desc(n))
  
plot3 <- sectors %>%
  hchart("treemap", hcaes(x = Product.Name, 
                          value = n)) 

plot3

# Maps -------------------------------------------------------------------------
# plot4 <- plot_ly(travel, 
#                  type='choropleth', 
#                  locations=df$CODE, 
#                  z=df$GDP..BILLIONS., 
#                  text=df$COUNTRY, 
#                  colorscale="Blues")
# 
# plot4