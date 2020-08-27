## Builds the fourth plot. A collection of four tiles, the left two being plots 2 and 3,
## the upper right is a plot of voltage over time and the lower right is the global reactive
## power over time

library(dplyr)

power_consumption <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";")

power_consumption <-
  mutate(power_consumption, Date = as.Date(Date, "%d/%m/%Y")) %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
  mutate(datetime = paste(Date, Time)) %>%
  mutate(datetime = strptime(datetime, format = "%Y-%m-%d %T")) %>%
  select(datetime, Global_active_power:Sub_metering_3) %>%
  mutate_if(is.character, as.numeric)

## Plot graphs 
png("plot4.png")

par(mfcol = c(2,2))

## Upper left quad
with(power_consumption, plot(datetime, Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = ""))

## Lower left quad
with(power_consumption, plot(datetime, Sub_metering_1, type = "l", col = "black", xlab = "",
                             ylab = "Energy sub metering"))
with(power_consumption, points(datetime, Sub_metering_2, type = "l", col = "red"))
with(power_consumption, points(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", pch = 151, col = c("black", "red", "blue"), 
       legend = c(names(power_consumption)[6:8]), bty = "n")

## Upper right quad
with(power_consumption, plot(datetime, Voltage, type = "l"))

## Lower right quad
with(power_consumption, plot(datetime, Global_reactive_power, type = "l"))

dev.off()