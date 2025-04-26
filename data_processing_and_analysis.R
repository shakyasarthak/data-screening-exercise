# Before the csv file was imported I removed the first 6 rows of the file which only provided the description and are not relevent to this task
# importing the csv file
df <- read.csv("messy_ice_detention.csv", fileEncoding="latin1", header = TRUE,sep=",")
df

# understanding the data set

summary(df) # summary of the data set
dim(df) # dimensions of the data set


install.packages("psych")
library(psych)
describe(df)

############################################

# data cleaning

# removing characters and symbols
df$Name <- gsub("[^A-Za-z ]", "", df$Name)
head(df)

# converting the date column into proper date time format
class(df$`Last.Inspection.End.Date`) # finding what class does the date column falls(datatype)
head(df$Last.Inspection.End.Date)

# Store original values
x <- df$Last.Inspection.End.Date

# Try to coerce to numeric; will be NA for character dates
num_dates <- suppressWarnings(as.numeric(x))

# Convert numeric (Excel) dates
date_from_num <- as.Date(num_dates, origin = "1899-12-30")

# Convert character dates (try ISO and US formats; adjust as needed)
date_from_char <- as.Date(x, format = "%Y-%m-%d")
date_from_char2 <- as.Date(x, format = "%m/%d/%Y")

# Use numeric conversion where available, else try character conversion, else try alternate format
df$Last.Inspection.End.Date <- ifelse(
  !is.na(date_from_num), as.character(date_from_num),
  ifelse(!is.na(date_from_char), as.character(date_from_char), as.character(date_from_char2))
)

# Convert back to Date type
df$Last.Inspection.End.Date <- as.Date(df$Last.Inspection.End.Date)



# finding the missing value
sum(is.na(df)) # finding the total missing value in the data
colSums(is.na(df)) # finding the total missing value in each column
df[!complete.cases(df), ] # find out which rows have missing values

# handling missing value

# manual correction of state for Atlanta city and Encinal city
df$State[df$State == " "] <- "TX"

# manual correction of city for GEAUGA COUNTY JAIL
df$City[df$Name == "GEAUGA COUNTY JAIL"] <- "CHARDON"

# manual correction of name for facility in Dover, NH
df$Name[df$City == "DOVER"] <- "STRAFFORD COUNTY CORRECTIONS"

# manual correction of name for facility in Elk River City, MH
df$Name[df$City == "ELK RIVER"] <- "SHERBURNE COUNTY JAIL SERVICES"

#######################################################

# Analysis

# sum each column and make a new column
df$Total_Avg_Population <- rowSums(df[, c("Level.A", "Level.B", "Level.C", "Level.D")], na.rm = TRUE)

# Subset top ten largest facilities by total population
top10 <- df[order(-df$Total_Avg_Population), ][1:10, ]

# View the result
print(top10[, c("Name", "City", "State", "Total_Avg_Population")])

#######################################################

# Visualization

# installing necessary library
install.packages("ggplot2")

library(ggplot2)

# Create bar plot visualization for top ten facilities with the most population
ggplot(top10, aes(x = Total_Avg_Population, y = reorder(Name, Total_Avg_Population))) +
  geom_col(fill = "steelblue") +
  labs(title = "Top 10 Largest Immigration Detention Facilities",
       subtitle = "By Total Population",
       x = "Total Population",
       y = "Facility Name") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 8),
        plot.title = element_text(face = "bold"))

# Save visualization
ggsave("top_detention_facilities.png", width = 10, height = 6, dpi = 300)





