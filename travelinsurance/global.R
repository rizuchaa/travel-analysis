# install.packages("digest")
# devtools::install_github("RinteRface/bs4Dash")
# remotes::install_github("rstudio/htmltools")
# remotes::install_github("rstudio/shiny")
# remotes::install_github("rstudio/thematic", force = T)

library(bs4Dash)
library(shiny)
library(plotly)
library(tidyverse)
library(dplyr)
library(thematic)
library(RColorBrewer)
library(ggiraph)
library(ggplot2)
library(reshape2)
library(DT)

# Dataset ----------------------------------------------------------------------
travel <- read.csv("data/travel_insurance.csv")
names(travel)[names(travel)=="Destination"]<-"Country"
travel$Gender[travel$Gender==""]<-"NB"
travel <- travel%>%
  mutate_if(is.character,as.factor)
data<-read.csv("travelinsurance/data/countries_codes_and_coordinates.csv")
sv<-left_join(travel,data, by='Country')
View(sv)

# plot 1 -----------------------------------------------------------------------
plot1 <-travel%>%
  plot_ly(
    x = ~Duration, y = ~Commision..in.value.,
    color = ~Product.Name, size = ~Age,
    text = ~paste0(Product.Name, '<br>Duration: ', Duration, '<br>Commision: ', Commision..in.value.)
  )%>%
  layout(showlegend = FALSE)

plot1

# plot 2 -----------------------------------------------------------------------

plot2 <- travel%>% 
  select(Claim)%>%
  group_by(Claim)%>% 
  count(Claim, sort = T)%>% 
  plot_ly(labels = ~Claim, values = ~n)%>% 
  add_pie(hole = 0.5)%>% 
  layout(title = "",  showlegend = F,
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

plot2


# plot 3 -----------------------------------------------------------------------
sectors<-travel%>%
  select(Product.Name, Agency)%>%
  group_by(Product.Name)%>%
  count(Product.Name)%>%
  arrange(desc(n))
  
plot3 <- plot_ly(
  type="treemap",
  labels=~sectors$Product.Name,
  parents=NA,
  values=~sectors$n)

plot3

# Maps -------------------------------------------------------------------------
plot4 <- plot_ly(travel, 
                 type='choropleth', 
                 locations=df$CODE, 
                 z=df$GDP..BILLIONS., 
                 text=df$COUNTRY, 
                 colorscale="Blues")

plot4