## Builds the second plot. A linegraph of Global Active Power in kilowatts as a function of time/date

library(dplyr)

power_consumption <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";")

power_consumption <-
  mutate(power_consumption, Date = as.Date(Date, "%d/%m/%Y")) %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
  mutate(datetime = paste(Date, Time)) %>%
  mutate(datetime = strptime(datetime, format = "%Y-%m-%d %T")) %>%
  select(datetime, Global_active_power:Sub_metering_3) %>%
  mutate_if(is.character, as.numeric)

png(file = "plot2.png")

plot(power_consumption$datetime, power_consumption$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()