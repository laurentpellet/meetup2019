#https://genomicsclass.github.io/book/pages/dplyr_tutorial.html
#http://larmarange.github.io/analyse-R/manipuler-les-donnees-avec-dplyr.html

library(dplyr)
library(downloader)
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
filename <- "input/msleep_ggplot2.csv"
if (!file.exists(filename)) download(url,filename)
msleep <- read.csv("input/msleep_ggplot2.csv")
head(msleep)

sleepData <- select(msleep, name, sleep_total)
head(select(msleep, -name))
head(select(msleep, name:order))
head(select(msleep, starts_with("sl")))
filter(msleep, sleep_total >= 16)
filter(msleep, sleep_total >= 16, bodywt >= 1)
filter(msleep, order %in% c("Perissodactyla", "Primates"))


# SELECTION ---------------------------------------------------------------

head(select(msleep, name, sleep_total))
msleep %>% 
  select(name, sleep_total) %>% 
  head


# FILTER ------------------------------------------------------------------


msleep %>% arrange(order) %>% head
msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, sleep_total) %>% 
  head
msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, sleep_total) %>% 
  filter(sleep_total >= 16)
msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, desc(sleep_total)) %>% 
  filter(sleep_total >= 16)

# NEW COLUMNS -------------------------------------------------------------


msleep %>% 
  mutate(rem_proportion = sleep_rem / sleep_total) %>%
  head

msleep %>% 
  mutate(rem_proportion = sleep_rem / sleep_total, 
         bodywt_grams = bodywt * 1000) %>%
  head


# SUMMARIES ---------------------------------------------------------------

msleep %>% 
  summarise(avg_sleep = mean(sleep_total))
msleep %>% 
  summarise(avg_sleep = mean(sleep_total), 
            min_sleep = min(sleep_total),
            max_sleep = max(sleep_total),
            total = n())

msleep %>% 
  group_by(order) %>%
  summarise(avg_sleep = mean(sleep_total), 
            min_sleep = min(sleep_total), 
            max_sleep = max(sleep_total),
            total = n())

