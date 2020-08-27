## Builds the third plot. A line graph of each sub meter as a function of time/date

library(dplyr)

power_consumption <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";")

power_consumption <-
  mutate(power_consumption, Date = as.Date(Date, "%d/%m/%Y")) %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
  mutate(datetime = paste(Date, Time)) %>%
  mutate(datetime = strptime(datetime, format = "%Y-%m-%d %T")) %>%
  select(datetime, Global_active_power:Sub_metering_3) %>%
  mutate_if(is.character, as.numeric)

png("plot3.png")

with(power_consumption, plot(datetime, Sub_metering_1, type = "l", col = "black", xlab = "",
                             ylab = "Energy sub metering"))
with(power_consumption, points(datetime, Sub_metering_2, type = "l", col = "red"))
with(power_consumption, points(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", pch = 151, col = c("black", "red", "blue"), legend = c(names(power_consumption)[6:8]))

dev.off()