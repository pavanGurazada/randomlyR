#' --- 
#' title: "Exploring data.table " 
#' author: Pavan Gurazada 
#' date: "February 2018" 
#' output: github_document 
#' ---

#' # Motivation
#'
#' Though `dplyr` and in general the `tidyverse` provide clean and consistent
#' ways to wrangle with data, one place where `data.table` blows every other
#' approach out is speed. Using highly optimized internals, this package extends
#' and empowers the good ol' `data.frame`. In this script, we explore this
#' excellent package. A key facet of this package is that since it inherits from
#' base R, there is no extra work required to work with the amazing plotting
#' packages like `ggplot2`.
#'
#' To reiterate, unlike the `tidyverse`, `tibble`, `data.table` inherits from
#' `data.frame` and is not a modern reimagination. Think of it more as
#' `data.frame` on steroids.
#'
#' On a side note, the core team has a wicked sense of humor and it is rare that
#' a bunch of data scientists can make you laugh hard with their words!
#' 

library(tidyverse)
library(data.table)
library(nycflights13)

#' Since this is a self-introduction to `data.table` this script will focus on
#' single-table operations.
#'
#' Fundamentally, `data.table` uses a SQL-ish query based approach to working
#' with data.
#'
#' There is only one key syntax to remember:
#'
#' `DT[where, select|update, group by][order by][...]...[...]` which translates
#' to
#'
#' DT['on which rows', 'what to do', 'on what groups']
#'
#' So, we select a bunch of rows, then subset required columns, group the table
#' by a set of columns. Then we chain this to other functions (like in
#' `tidyverse`). In this way, every `tidyverse` sentence composed of
#' single-table verbs can be translated to a `data.table` query.
#'
#' We begin by translating several `dplyr` pipelines to `data.table`. This
#' brings forth the Speed vs Readability debate. Personally, I feel that the
#' closer one is to familiarity with matrix-base computation, the easier it is
#' to transition. There are substantial speed gains to be reaped in the process, 
#' while staying close to base-R
#' 

flightsDT <- as.data.table(flights)
glimpse(flights)

#' *Example 1* Find all flights that departed on 1st January

flights %>% filter(month == 1, day == 1) %>% head()
flightsDT[month == 1 & day == 1, ]

#' *Example 2* Arrange the data in descending order of arrival delay

flights %>% arrange(desc(arr_delay)) %>% head()
flightsDT[order(-arr_delay), ] # Uses a turbo-charged base-R order function

#' *Example 3* Select a subset of the data excluding year, month and day

flights %>% select(-(year:day)) %>% head()
flightsDT[, -(year:day)]

#' *Example 4* Compute the increase in flight time because of the delays?

flights %>% mutate(gain = arr_delay - dep_delay,
                   gain_per_hour = gain/(air_time/60)) %>% 
            select(gain, gain_per_hour) %>% 
            head()

flightsDT[, `:=`(gain = arr_delay - dep_delay)]
glimpse(flightsDT)

#' At this point note that `data.table` is perceptibly fast but by no means
#' as elegant as `dplyr`. However, the strengths are significant when it comes to 
#' munging data in terms of speed. I find it much easier to parse `dplyr`






