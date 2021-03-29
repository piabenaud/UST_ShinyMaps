
# Title:      UST Shiny Maps Functions
# Objective:  This script writes the generic functions needed within the App
# Created by: Pia Benaud
# Created on: 17-03-2021


# Load Packages -----------------------------------------------------------------

library(dplyr)
library(ggplot2)
library(lubridate)
library(ggbump)


# EA Spot Plots -----------------------------------------------------------------






TavyEA <- EA_spot[[7]] %>% 
  filter(determinand == "C - Org Filt",
         location == "RIVER LUMBURN AT SHILLAMILL") %>% 
  mutate(month = month(datetime))


C_min_max <- TavyEA %>% 
  group_by(month) %>% 
  summarise(min = min(result),
            max = max(result),
            median = median(result),
            n = n())

plt2 <- ggplot(data = TavyEA, aes(x = month, y = result)) +
  geom_point(alpha = 0.2, size = 1, show.legend = FALSE) +
  geom_segment(data = C_min_max, aes(x = month, y = min, xend = month, yend= max), color = "gray50", size = 0.5, show.legend = FALSE) +
  geom_point(data = C_min_max, aes(x = month, y = min), size = 2, colour = "#f4a261", show.legend = FALSE) +
  geom_point(data = C_min_max, aes(x = month, y = max), size = 2, colour = "#f4a261", show.legend = FALSE) +
  geom_text(data = C_min_max, aes(x = month, y = 0.2, label = paste("n = ",n)), size = 2, colour = "gray20") +
  geom_bump(data = C_min_max, aes(x = month, y = median), colour = "#2a9d8f", show.legend = FALSE) +
  scale_x_continuous(breaks = c(1:12)) +
  scale_y_continuous(breaks = c(0:10)) +
  labs(x = "Month", y = "DOC") +
  theme_classic() + 
  theme(axis.title = element_text(size = 10.5, colour = "gray20"))

plt2
