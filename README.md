# Data Processing and Analysis Exercise - ICE Detention Facilities

This repository contains the solution for the Data Processing and Analysis Exercise focusing on Immigration and Customs Enforcement (ICE) detention facilities data.

## Exercise Overview

The goal of this exercise was to clean, analyze, and visualize data from ICE detention facilities in the United States.

### Requirements

1. **Clean** a messy dataset of detention facilities
2. **Analyze** the data by calculating total populations
3. **Visualize** the top 10 largest detention facilities

## Data Source

The analysis uses data from `messy_ice_detention.csv`, which contains information about immigration detention facilities including:

- Facility names
- Locations (city and state)
- Inspection dates
- Population figures by security level (A, B, C, D)

*Note: As instructed, the first 6 rows of the original file were removed prior to import as they contained only descriptive header information.*

## Dependencies

The script requires the following R packages:
- `psych` - For descriptive statistics
- `ggplot2` - For data visualization

Install these packages using:
```R
install.packages(c("psych", "ggplot2"))
```

## Implementation Process

### 1. Data Cleaning

Several cleaning operations were performed on the dataset:

- Removed special characters and symbols from facility names
- Converted dates to proper format, handling both Excel numeric dates and text formats
- Identified and resolved missing values:
  - Corrected missing state information for Atlanta and Encinal cities
  - Added missing city information for GEAUGA COUNTY JAIL
  - Standardized facility names for locations in Dover, NH and Elk River, MH

### 2. Data Analysis

After cleaning, the analysis consisted of:
- Calculating total average population across all security levels (A, B, C, D)
- Identifying the top 10 largest facilities by total population

### 3. Data Visualization

Created a horizontal bar chart using `ggplot2` showing the top 10 facilities by population, sorted in descending order.

## Files in this Repository

- `messy_ice_detention.csv` - Original data file (not included in repo)
- `data_processing_and_analysis.R` - R script with all cleaning, analysis and visualization code
- `top_detention_facilities.png` - Output visualization showing top 10 facilities
- `README.md` - This documentation file

## How to Execute

1. Clone this repository
2. Ensure you have R installed (RStudio recommended)
3. Place the `messy_ice_detention.csv` file in the working directory
4. Run the `data_processing_and_analysis.R` file
5. The script will generate the visualization and save it as `top_detention_facilities.png`

## Resources Used

Throughout this exercise, I used the following resources:
- R documentation for date conversion techniques
- Stack Overflow for handling mixed date formats
- R Graphics Cookbook for visualization guidance
- Perplexity AI for figuring out the excel date to normal date format and other minor works. LINK:[Perplexity prompt](https://www.perplexity.ai/search/how-to-convert-excel-date-to-d-hDQna6sAQca7FWZEqKvwXA)

## Visualization Interpretation

The resulting visualization (`top_detention_facilities.png`) shows the top 10 ICE detention facilities ranked by total population. The horizontal bar chart format makes it easy to compare population sizes across facilities, with the largest facility displayed at the top and the smallest of the top 10 at the bottom.

This visualization provides a clear view of which detention facilities are accommodating the largest numbers of immigrants, which could be valuable for resource allocation, oversight, and policy discussions.

## Notes on Manual Corrections

While most cleaning was done programmatically, manual corrections were made for:
- Missing state for Atlanta and Encinal (set to "TX")
- Missing city for GEAUGA COUNTY JAIL (set to "CHARDON")
- Facility name standardization for Dover, NH facility and Elk River, MH facility

These corrections were implemented in the code rather than directly modifying the CSV file.
