library(tidyverse)
library(data.table)

ggplot(data.frame(x = 1:10,
                  y = 1:10), aes(x, y)) +
  geom_hline(aes(yintercept = 5)) +
  geom_vline(aes(xintercept = 5))

