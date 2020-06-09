# Exploratory Data Analysis- Week 4-Final Project
## This is 5 of 6 of my responses to the questions posed by the week 4 project for the
## Coursera/JHU Data Science Specialization Course 'Exploratory Data Analsysis'
## I am completing this course in June 2020 - The following represents my response to
## the questions posited in the week 4 assignment @ https://www.coursera.org/learn/exploratory-data-analysis/



# Step 0 - Prepare the Data -- Same as Plot 1

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

### How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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
## First we need to merge the data frames, then extract/subset the data to only 
## records that are tied to motor vehicle sources, then subset the data to the 
## City of Baltimore, then we can plot by year just like the previous questions

## This question essentially combines everything we've done thus far.

# Step 3 - Create the visualization to best answer the 5th question:

## Step 3 - 1 Prepare the Data by mergine the dataframes, subsetting for motor
## vehicle values, then cleaning the output table

#### Merge the data frames
pmCombined <- tbl_df(merge(NEI,SCC,by="SCC"))

#### Subset the data to search for "mobile - on-road" from the EI.Sector Column, 
#### which according to the dataset documentation is the actual source data values
#### for motor vehicle PM 2.5 polution- we do this by tagging all mobile-on-road
#### records with a boolean TRUE value in a new column 'mobile'
pmCombined <- mutate(pmCombined,mobile=grepl("mobile - on-road",pmCombined$EI.Sector,ignore.case = TRUE))

#### Now that we have tagged the motor vehicle data, we can filter to the FIPS for the City of Baltimore
BaltimoreMobileEmissions <- filter(pmCombined,fips=="24510")

#### Now that we have filtered for the FIPS for the City of Baltimore, we can filter to motor vehicle data previosly tagged
BaltimoreMobileEmissions <- filter(BaltimoreMobileEmissions,mobile==TRUE)

#### Now that we've applied all filters, we can create the summary table for Baltimore City Motor Vehicle Emission Data
BaltimoreMobileEmissionsTest <- summarise(group_by(BaltimoreMobileEmissions,year),sum(Emissions))

#### Rename Columns and Convert Year to String
colnames(BaltimoreMobileEmissionsTest) <- c("Year","Emissions")

## Step 3 - 2 Establish the PNG File
png('plot5.png')

## Step 3 - 3 Create the plot
barplot(
  BaltimoreMobileEmissionsTest$Emissions,
  width=BaltimoreMobileEmissionsTest$Year,
  xlab="Years",
  ylab="Emissions (PM 2.5)",
  main="Motor Vehicle Emissions for the City of Baltimore, MD",
  names.arg = BaltimoreMobileEmissionsTest$Year,
  axisnames=TRUE
)

## Step 3 - 4 Close the PNG File
dev.off()

#### END OF PLOT 5 ####