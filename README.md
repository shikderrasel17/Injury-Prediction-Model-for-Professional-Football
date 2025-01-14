# Injury Prediction Model for Professional Football

This repository contains the code and documentation for an Injury Prediction Model designed to predict the likelihood of injuries for professional football players. The model uses machine learning techniques to provide insights that can help team managers and coaches make informed decisions about player selection and game strategy.


## Model Details

- **Model Name:** Injury Prediction Model for Professional Football
- **Author:** [Rasel Shikder](https://www.linkedin.com/in/rasel-shikder-305003185)
- **Version:** 1.0
- **Type:** Binary Classification
- **Implementation:** XGBoost

## Intended Use

This model predicts the likelihood of a soccer player sustaining an injury in the next game. It analyzes player attributes, injury history, and physical data to estimate injury risk, aiding team managers and coaches in player selection decisions.

## Data Sources

- **Player Attributes:** [FIFA 16-21 data](https://www.kaggle.com/datasets/stefanoleone992/fifa-21-complete-player-dataset?select=players_20.csv)
- **Injury History:** Data from Transfermarkt, accessed via the [worldfootballR R package](https://rdrr.io/cran/worldfootballR/)
- **Game Time Data:** [Barclays Premier League Soccer Dataset](https://www.kaggle.com/datasets/narekzamanyan/barclays-premier-league?select=player_stats.csv)

## Model Training

The dataset was created by merging data from three sources. The training set consisted of 70% of the data (479 samples), with the remaining 30% used for testing. SMOTE was applied to balance the training data due to the low proportion of injury instances.

## Players/seasons in scope:

- Original scope was all players who have played in the British Premier League at any point between 2016/17 season and 2020/21 season
- Due to complications and difficulties in joining 3 datasets from entirely different sources, this came out to a total of 685 rows of data, consisting of 317 players

### Data Dictionary

| Name                         | Role          | Type     | Description                                                  |
|------------------------------|---------------|----------|--------------------------------------------------------------|
| `p_id2`                      | ID            | String   | Unique player identifier                                     |
| `start_year`                 | Input         | Integer  | Start year of the current season                             |
| `height_cm`                  | Input         | Float    | Player's height in centimeters                               |
| `weight_kg`                  | Input         | Float    | Player's weight in kilograms                                 |
| `work_rate_numeric`          | Input         | Ordinal  | Player's work rate                                           |
| `pace`                       | Input         | Integer  | Player's 'pace' rating                                       |
| `physic`                     | Input         | Integer  | Player's 'physical' rating                                   |
| `position_numeric`           | Input         | Nominal  | Player's position (Goalkeeper, Defender, Forward, Midfielder)|
| `age`                        | Input         | Integer  | Player's age                                                 |
| `cumulative_minutes_played`  | Input         | Integer  | Total minutes played in previous seasons                     |
| `minutes_per_game_prev_seasons` | Input      | Integer  | Average minutes played per game in previous seasons          |
| `avg_days_injured_prev_seasons` | Input      | Integer  | Average days injured in previous seasons                     |
| `significant_injury_prev_season` | Input     | Integer  | Whether player had a significant injury in the previous season|
| `cumulative_days_injured`    | Input         | Integer  | Total days injured before the current season                 |
| `target_major_injury`        | Target        | Boolean  | Major injury in the current season                           |


## Training Data

- 3 separate data sources were combined to create a datset which included player attributes (i.e. - pace, height, weight), player injury history and player game time
- Data was grouped on a player-year level
- Data was split 70:30 train:test. Training data consisted of 479 rows with 12 features
- Since a positive value in the target variable only accounted for ~25% of the data, the data was oversampled the training data using SMOTE (Synthetic Minority Oversampling Technique)
- The final training dataset (after SMOTE) consisted of 734 rows
- Target variable: 'major_injury' - binary variable based on whether player was injured for more than 120 calendar days in a given season
- Data Dictionary:

| Name | Modeling Role | Measurement Level| Description|
| ---- | ------------- | ---------------- | ---------- |
|**p_id2**| ID | string | unique player indentifier |
| **start_year** | input | int | start year of current season |
| **height_cm** | input | float | player's height in centimetres averaged across FIFA 16-21 |
| **weight_kg** | input | float | player's weight in kilograms averaged across FIFA 16-21 |
| **work_rate_numeric** | input | ordinal | player's work-rate mode across FIFA 16-21 ranging from 2-4 in 0.5 intervals |
| **pace** | input | int | player's 'pace' rating averaged across FIFA 16-21 |
| **physic** | input | int | player's 'physical' rating averaged across FIFA 16-21 |
| **position_numeric** | input | nominal | 'Goalkeeper': 0, 'Defender': 1, 'Forward': 2, 'Midfielder': 3 |
| **age** | input | int | player age in relevant season |
| **cumulative_minutes_played* | input | int | cumulative minutes played by player in all previous seasons |
| **minutes_per_game_prev_seasons**| input | int | average minutes played per game in all previous seasons |
| **avg_days_injured_prev_seasons**| input | int | average calendar days injured in all previous seasons |
| **significant_injury_prev_season**| input | int | whether player had significant injury in previous season; 1 = yes; 0 = no |
| **cumulative_days_injured**| input | int | cumulative calendar days player was injured prior to current season |
| **target_major_injury**| target | bool | whether player had major injury in current season; True = yes; False = no |

## Test Data

- 70/30 train:test data split on original data set of 685 samples
- Hence, test data consisted of 206 samples


## Model Parameters

Optimal hyperparameters identified through grid search:

- **Number of Trees:** 200
- **Maximum Depth per Tree:** 4
- **Learning Rate:** 0.1
- **Minimum Child Weight:** 1
- **Subsample (Columns):** 0.8
- **Subsample (Rows):** 0.9

## Feature Importance

A visual representation of feature importance is provided below.

![Feature Importance](path/to/feature_importance.png)

## Exploratory Data Analysis (EDA):

## Data Preprocessing and Integration

### Data Import and Initial Setup
- **Libraries**: Utilized `pandas`, `numpy`, `re`, and `datetime` for data manipulation and processing.
- **Data Sources**: Imported CSV files containing player data, player statistics, and match information.

### Data Filtering and Preparation
- **Injury Threshold**: Defined major injuries as those leading to absences of 120 days or more.
- **Seasonal Filter**: Limited analysis to data from the 2016/17 to 2020/21 seasons.

### Data Cleaning
- **Erroneous Data Removal**: Eliminated rows with invalid match dates.
- **Date Conversion**: Transformed match dates into datetime objects and extracted the start year for analysis.

### Handling Missing and Non-Numeric Data
- **Substitution Data**: Cleaned and converted substitution times to numeric values using a custom function.

### Data Merging
- **Player and Match Data**: Merged player statistics with player details using a consistent player ID (`p_id2`) and integrated match data for comprehensive analysis.

### Calculating Player Minutes Played
- **Minutes Calculation**: Implemented a function to estimate minutes played per match, considering starting status and substitution times.
- **Participation Indicator**: Created a binary indicator for game participation based on minutes played.

### Selection of Relevant Columns
- **Data Reduction**: Focused on essential columns: player ID, position, match ID, match date, start year, minutes played, and game participation.

## Injury and FIFA Data Integration

### Injury Data Preprocessing
- **Injury Data**: Standardized player names and filtered out non-injury-related entries to focus on physical injuries.
- **Duration Extraction**: Developed a function to extract and convert injury durations to numeric values.

### Injury Data Aggregation
- **Seasonal Aggregation**: Grouped data to calculate total days injured per season and across the dataset's timespan.

### FIFA Data Preprocessing
- **FIFA Data**: Imported FIFA player data and cleaned player names extracted from URLs.
- **Relevant Attributes**: Selected columns like height, weight, nationality, work rate, pace, physic, and overall ratings.

### FIFA Data Aggregation
- **Data Grouping**: Aggregated FIFA data to compute mean values for numeric attributes and mode for categorical ones.

### Combining Datasets
- **Dataset Merging**: Merged injury, player performance, and FIFA data, resulting in a comprehensive dataset with 604 unique players.

## Feature Engineering and Analysis

### Index Resetting
- **Index Management**: Reset the dataframe index for continuous numerical indexing.

### Age Calculation
- **Age Feature**: Calculated players' age at the beginning of each season.

### Cumulative Metrics Calculation
- **Performance Metrics**: Computed cumulative minutes and games played, average days injured, and games per season from historical data.

### Derived Metrics
- **Minutes Per Game**: Derived from cumulative minutes divided by cumulative games.
- **BMI**: Calculated using height and weight data.
- **Work Rate Numeric Conversion**: Transformed categorical work rate values into numeric scores.

### Position Numeric Conversion
- **Positional Mapping**: Converted player positions to numeric values for analysis.

### Significant Injury Feature
- **Binary Indicator**: Created a feature indicating significant injuries in the previous season.

### Handling Missing Values and Outliers
- **Data Integrity**: Replaced infinite values with NaN and ensured data completeness.

### Data Export
- **File Export**: Saved the processed dataframe for further analysis and modeling.

## Analysis of Features

### Physical and Season Features
- **Feature Separation**: Distinctly analyzed physical attributes and seasonal performance metrics.

### Exploratory Data Analysis (EDA)
- **Visual Analysis**: Generated histograms and scatter plots to explore feature distributions and relationships.
- **Correlation Examination**: Investigated correlations between features and injury occurrences.

### Position-wise Analysis
- **Positional Impact**: Analyzed median days injured by position, highlighting susceptibility variations.

### Categorical Target Variable
- **Threshold Analysis**: Assessed injury thresholds and defined a categorical target for major injuries.
- **Visual Relationships**: Used box plots to explore feature relationships with the target variable.

## Modeling Process and Evaluation

### Handling Missing Values
- **Null Dropping**: Removed rows with null values in critical columns.
- **Imputation**: Applied mean and mode imputation for less critical columns.

### Dataset Preparation
- **Binary and Numerical Targets**: Created separate datasets for binary and numerical target variables.

### Train-Test Split and Oversampling
- **Data Split**: Divided data into training and testing sets.
- **SMOTE Oversampling**: Addressed class imbalance in the training set.

### Feature Scaling
- **Standardization**: Scaled continuous features for uniformity.

### Feature Selection
- **Recursive Feature Elimination**: Used RFECV to select the most predictive features.

### Model Selection and Training
- **Logistic Regression**: Initially used Logistic Regression, followed by XGBoost for improved performance.

### Hyperparameter Tuning and Cross-Validation
- **Grid Search**: Optimized XGBoost hyperparameters using cross-validation.

### Model Evaluation
- **Performance Metrics**: Assessed model performance using accuracy, precision, recall, F1 score, and ROC AUC score.
- **Confusion Matrix**: Visualized classification results.
- **ROC and Lift Curves**: Evaluated model discrimination capability and ranking effectiveness.


## Metrics

- **Accuracy:** 73.30%
- **Precision:** 26.83%
- **Recall:** 30.56%
- **F1 Score:** 28.57%
- **AUC-ROC Score:** 66.65%

## Ethical Considerations

- The model should be used responsibly, ensuring it supports rather than replaces human decision-making.
- Avoid discrimination based on player demographics.
- The model should not be the sole factor in player selection decisions.

## Limitations and Bias

- The dataset is relatively small, which might affect model performance.
- The model is specific to the Premier League and male players; generalization to other leagues and female players requires caution.

## Licensing

This model is licensed under the Apache License.


## Installation

To run this project locally, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/shikderrasel17/Injury-Prediction-Model-for-Professional-Football.git

   
