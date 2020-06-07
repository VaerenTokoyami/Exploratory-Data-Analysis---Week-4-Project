# Exploratory Data Analysis- Week 4-Final Project
## This is 1 of 6 of my responses to the questions posed by the week 4 project for the
## Coursera/JHU Data Science Specialization Course 'Exploratory Data Analsysis'
## I am completing this course in June 2020 - The following represents my response to
## the questions posited in the week 4 assignment @ https://www.coursera.org/learn/exploratory-data-analysis/



# Step 0 - Prepare the Data

## Step 0-1 - Load the R Packages Required for this Assignment

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
if(!file.exists(SourceDest0&SourceDest1)) {
  unzip(SourceFileName)
}

## Step 0-5 - Read the Source Data
SCC <- readRDS(SourceDest0)
NEI <- readRDS(SourceDest1)

head(SCC)
head(NEI)
# Step 1 - Determine what parts of the available data is required to answer the question

## Step 1-0 - What is the Question???

### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
### Using the base plotting system, make a plot showing the total PM2.5 emission from 
### all sources for each of the years 1999, 2002, 2005, and 2008.

## Step 1-1 - Explore the Structure/Format of the Data

## Step 1-2 - 



# Step 2 - Determine what type of visualization could best answer the question:




# Step 3 - Create the visualization to best answer the 1st question:
