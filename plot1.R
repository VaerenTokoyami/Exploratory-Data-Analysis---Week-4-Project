# Exploratory Data Analysis- Week 4-Final Project
## This is 1 of 6 of my responses to the questions posed by the week 4 project for the
## Coursera/JHU Data Science Specialization Course 'Exploratory Data Analsysis'
## I am completing this course in June 2020 - The following represents my response to
## the questions posited in the week 4 assignment @ https://www.coursera.org/learn/exploratory-data-analysis/



# Step 0 - Prepare the Data

## Step 0-1 - Load the R Packages Required for this Assignment
library(dplyr)
library(ggplot2)
library(scales)
library(data.table)

## Step 0-2 - Create Source Data Variables
SourceURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
SourceFileName <- "exdata_data_NEI_data.zip"
SourceDest0 <- "Source_Classification_Code.rds"
SourceDest1 <- "summarySCC_PM25.rds"

## Step 0-3 - Verify/Download the Source Data
if(!file.exists(SourceFileName)) {
  download.file(SourceURL,SourceFileName,mode="wb")
}

## Step 0-4 - Verify/Unzip the Source Data
if(!file.exists(SourceDest0)) {
  unzip(SourceFileName)
}

## Step 0-5 - Read the Source Data
SCC <- readRDS(SourceDest0)
NEI <- readRDS(SourceDest1)

# Step 1 - Determine what parts of the available data is required to answer the question

## Step 1-0 - What is the Question???

### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
### Using the base plotting system, make a plot showing the total PM2.5 emission from 
### all sources for each of the years 1999, 2002, 2005, and 2008.

## Step 1-1 - Explore the Structure/Format of the Data

print("What is SCC?")
str(SCC)
### So SCC is a 15 Variable data frame with 11717 observations (or rows), 
### but that really isn't accurate when you assess each of the 15 variables- 
### many of the variables have less than 100 levels...
###
###
### Upon Closer review of the assignment prompt, this is simply an incredibly ugly dataset-
### SCC is the mapping for the types of polutants, where as NEI is the polutant levels...
### If the scientists organizing this dataset were datascientists, there'd have been closer to a dozen files
### cross-referencing indexed values similar to how one would contruct a clean sql database...

print("")
print("What is NEI?")
str(NEI)
### So while different to SCC, NEI is a 6 variable data frame with nearly 6.5 million observations...
### These observations appear to be the code for the observation locallity, the corresponding SCC pollutant 
### type, whether the SCC were the primary or alternate polutant, the actual emission level, and the 
### year of the measurement

# Step 2 - Determine what type of visualization could best answer the question:

## Based upon the structure of the data, and the first question as to whether over time, nationwide, 
## has the PM2.5 decreased, we should begin by totalling the yearly PM2.5 measurements - and then
## what are the comparisons of combined emission rates compared year to year. This could best be 
## achieved via a bar or line graph - I've always prefered Bar graphs for this type of comparison

# Step 3 - Create the visualization to best answer the 1st question:

## Step 3 - 1 Create The summarization table for the yearly Emmission totals
YearlyEmissions <- NEI %>% group_by(year) %>% summarise(AnnualTotal=sum(Emissions))

## Step 3 - 2 Establish the PNG File
png('plot1.png')

## Step 3 - 3 Create the summarized bar chart for the answer
barplot(
  YearlyEmissions$AnnualTotal/1000000, 
  YearlyEmissions$year,
  names.arg=YearlyEmissions$year, 
  xlab="Total Annual Measurements",
  ylab="Emissions (PM 2.5) in Millions of Tons",
  main="Emissions (PM 2.5) per Year"
)

## Step 3 - 4 Close the PNG File
dev.off()

#### END OF PLOT 1 ####