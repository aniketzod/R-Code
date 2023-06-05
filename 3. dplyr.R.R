# deplyr package: is a structure of data manipulation.
# Useful in advanced data analysis task
# The dplyr package does not provide any “new” functionality to R
# In the sense that everything dplyr does could already be done with base R,
# but it greatly simplifies existing functionality in R.

install.packages("dplyr")
library(dplyr)

## nycflights13 package is only for the dataset that we are going to study
install.packages("nycflights13")
library(nycflights13)

# Dataset name is: flights

# find dimensions of flights, see flights as a table in different tab,
# see first  and last rows, check no of rows and columns, check structure, 
# display names of columns.




dim(flights)
View(flights)
head(flights,20) # first 20 records
tail(flights) # by default last 6 records
nrow(flights)
ncol(flights)
str(flights)
names(flights) # OR colnames(flights)
help(flights)

## ----- Filter out records based on some criteria - display records of 1st Jan


new<-filter(flights, month == 1, day == 1)
new1<-filter(flights, year==2013,day==1)

filter(flights, month == 12, day== 13)




## Pipe/Chaining operator %>% (output of 1 as input to other function)

flights %>% filter(month==10, day==8)

# eg. log(sin(exp(cos(x))))
# x %>% cos() %>% exp() %>% sin() %>% log()

# gun(fun(x,y),z)
# x %>% fun(y) %>% gun(z)

## - arrange first by year then month then day in ascending order
arrange(flights, year, month, day)

## -----------
arrange(flights, desc(arr_delay))

## ----------------
# Select columns by name
select(flights, year, month, day)

# Select all columns between year and day (inclusive)
View(flights)
select(flights, year:day)
# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))


## Create/add new columns-----------------
newdf<-mutate(flights,
  gain = arr_delay - dep_delay,
  speed = distance / air_time * 60
)

View(newdf)

## --- only output... not storing
mutate(flights,
  gain = arr_delay - dep_delay,
  gain_per_hour = gain / (air_time / 60)
)

## ---------------
sample_n(flights, 10) # select any 10 random samples 
sample_frac(flights, 0.01) # 1 % records to be selected at random

##---------------
flights$dest
unique(flights$dest)
length(unique(flights$dest))

## ---------------
destinations <- group_by(flights, dest)

summarise(destinations,
  planes = n_distinct(tailnum),
  flights = n()
)

flights[flights$dest=='ANC',c('tailnum','dest')]


# another example
dfdept<- data.frame(name=c("a","b","snehal","meenal","saloni","rohini","dnyanesh","Amar","Irfan","Saket"),
                    dept=c("trainer","Admin","trainer","trainer","sales","mkt","sales","HR","Admin","Admin"),
                    salary=c(95000,82000,90000,90000,60000,70000,60000,100000,80000,85000))

dfdept
depgrp <- group_by(dfdept, dept)

summarise(depgrp,
          sal = n_distinct(salary),
          depgrp = n()
)

salgrp<- group_by(dfdept,salary)
summarise(salgrp,
          dep=n_distinct(dept),
          salgrp=n())

## ------------------
daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))

## --------------
# `year` represents the index 1
select(flights, year)
select(flights, 4)

## ----------------
filter(
  summarise(
    select(
      group_by(flights, year, month, day),
      arr_delay, dep_delay
    ),
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ),
  arr > 30 | dep > 30
)

################
flights %>%
  group_by(year,month,day) %>% 
    select(arr_delay,dep_delay) %>%
      summarise(arr=mean(arr_delay,na.rm=T),
                dep=mean(dep_delay,na.rm=T)) %>%
       filter(arr>30 | dep>30)





#########################################################

























# group by on single column

superstore = read.csv("C:\\Users\\excel\\Downloads\\Sample_Superstore.csv",header=TRUE, sep=",")

df_grp_region = superstore %>% group_by(Region)  %>%
  summarise(total_sales = sum(Sales),
            total_profits = sum(Profit))

View(df_grp_region)

# group by on multiple columns

df_grp_reg_cat = superstore %>% group_by(Region, Category) %>%
  summarise(total_Sales = sum(Sales),
            total_Profit = sum(Profit))

View(df_grp_reg_cat)



# GitHub account creation

# Download anaconda

