#' ---
#' title: "Lecture 4 R Intro"
#' author: "Mitchell Sullivan"
#' date: "January 16th, 2026"
#' ---
x <- 1:50
plot(x)
plot(x, sin(x), type = "l", col = "blue", lwd = 3, xlab = "is it lunch time yet?")

#A little extra
library(tidyverse)
df <- data.frame(x = x, y = sin(x))
plot <- df |> ggplot(aes(x, y)) +
  geom_line(color = "blue") +
  xlab("Is it lunch yet?") +
  theme_minimal()
plot