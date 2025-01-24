# Healthcare-management-analytics
This project provides an overview of healthcare management systems metrics


## Project Overview
This project analyzes healthcare management data to uncover insights that can drive efficient decision-making in the healthcare sector. Using SQL for data querying and Power BI for visualization, I explored patient demographics, billing trends, seasonal appointment patterns, and doctors' performance metrics. 

This dashboard and report were inspired by Mathew Ukeme, whose exemplary work motivated me to strive for excellence in storytelling with data.

## Objectives
- To identify frequent medical procedures and analyze their cost distribution.
- To examine seasonal trends in patient appointments.
- To evaluate doctors' performance metrics based on specializations.
- To highlight high-value patients with significant cumulative billing amounts.

## Tools Used
- **SQL**: Microsoft SQL Server for querying, cleaning, and analyzing the dataset.
- **Power BI**: For creating interactive dashboards and DAX calculations.
- **Power Query Editor**: For data transformation and cleaning.

## Dataset Details
The project uses a healthcare management dataset comprising multiple tables:
- **Patients**: Information about patient IDs, names, and demographics.
- **Appointments**: Details of patient appointments, including dates and doctor IDs.
- **Doctors**: Specialization and performance metrics for each doctor.
- **Medical Procedures**: Details about medical procedures performed, including costs.
- **Billing**: Billing amounts for patient procedures.

## Data Cleaning Steps (Power Query)
1. **Imported Data**: Connected all tables (Patients, Doctors, Appointments, Billing, and Medical Procedures) in Power BI.
2. **Renamed Columns**: Renamed columns for better clarity (e.g., `PatientID` to `Patient_ID`).
3. **Removed Duplicates**: Identified and removed duplicate rows across all tables.
4. **Resolved Missing Values**: Filled missing values in numeric fields with 0 and replaced missing text values with "Unknown."
5. **Created Relationships**: Established relationships between the tables using primary and foreign keys.
6. **Date Table**: Created a Date table to analyze trends across time dimensions (e.g., months, seasons).

## Key DAX Measures
1. **Seasonal Trends**:
```DAX
Season =
SWITCH(
    TRUE(),
    MONTH('Date'[Date]) IN {12, 1, 2}, "Winter",
    MONTH('Date'[Date]) IN {3, 4, 5}, "Spring",
    MONTH('Date'[Date]) IN {6, 7, 8}, "Summer",
    MONTH('Date'[Date]) IN {9, 10, 11}, "Fall",
    "Unknown"
)
```

2. **Total Appointment Count**:
```DAX
Total Appointments = COUNT('Appointments'[AppointmentID])
```

3. **Top Procedure by Cost**:
```DAX
Max Procedure Cost = MAX('Medical Procedures'[Cost])
```

4. **Cumulative Billing Amount for High-Value Patients**:
```DAX
Cumulative Billing = SUMX('Billing', 'Billing'[Amount])
```

## Key Insights
1. **Most Frequent Procedures**: The analysis showed X-rays, CT scans, and MRI as the most common procedures.
2. **Seasonal Trends**: Fall recorded the highest number of appointments, while Winter had the least.
3. **Doctors’ Performance**: Obstetric Anesthesiologists and Ophthalmologists had the highest procedure counts.
4. **High-Value Patients**: Identified top 10 patients contributing significantly to cumulative revenue.

## Visualizations
1. **Dashboard Screenshot**:
   ![dashbd1](https://github.com/user-attachments/assets/b09c21a5-8740-43b1-894a-d9e1e616b802)
   
![Screenshot_24-1-2025_14028_](https://github.com/user-attachments/assets/4088a4e8-7ca9-44e6-a9f2-d36d5e1a46f5)

3. **Seasonal Trends**: A bar chart showing appointment counts across seasons.
4. **Doctor Performance Metrics**: A table highlighting doctors’ specialization and their procedure counts.
5. **Procedure Costs**: A heatmap showing the cost distribution of procedures.
6. **High-Value Patients**: A table showcasing the top patients by cumulative billing amounts.

## SQL Syntax and Queries
Here are the key SQL queries used in this project:

1. **Frequent Medical Procedures**:
```sql
SELECT TOP 10
    ProcedureName AS Procedures, 
    COUNT(*) AS Frequency
FROM [Medical Procedure]
GROUP BY ProcedureName
ORDER BY Frequency DESC;
```

2. **Seasonal Appointment Trends**:
```sql
SELECT 
    CASE 
        WHEN MONTH(Date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(Date) BETWEEN 3 AND 5 THEN 'Spring'
        WHEN MONTH(Date) BETWEEN 6 AND 8 THEN 'Summer'
        WHEN MONTH(Date) BETWEEN 9 AND 11 THEN 'Fall'
        ELSE 'Unknown'
    END AS Season,
    COUNT(AppointmentID) AS AppointmentCount
FROM Appointment
GROUP BY 
    CASE 
        WHEN MONTH(Date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(Date) BETWEEN 3 AND 5 THEN 'Spring'
        WHEN MONTH(Date) BETWEEN 6 AND 8 THEN 'Summer'
        WHEN MONTH(Date) BETWEEN 9 AND 11 THEN 'Fall'
        ELSE 'Unknown'
    END
ORDER BY AppointmentCount DESC;
```

3. **High-Value Patients**:
```sql
SELECT 
    PatientID, 
    firstname + ' ' + lastname AS FullName, 
    SUM(Amount) AS CumulativeCost
FROM Billing
GROUP BY PatientID, firstname, lastname
ORDER BY CumulativeCost DESC;
```

Full SQL scripts can be found in the repository as `sql_scripts.sql`.

## Repository Contents
- **SQL Scripts**: All SQL queries used for data analysis are saved in `sql_scripts.sql`.
- **Power BI Dashboard**: The Power BI `.pbix` file is available for exploration.
- **Data Cleaning Documentation**: Detailed steps taken in Power Query.
- **DAX Calculations**: Key DAX measures are documented.

## How to Use
1. Clone this repository to your local machine.
2. Open the Power BI file to explore the dashboard.
3. Review SQL scripts for detailed querying logic.

## Feedback
I welcome all feedback and suggestions to improve this project. Feel free to reach out or leave a comment!

---

### Connect with Me
- **LinkedIn**: [Your LinkedIn Profile Link]
- **Medium**: [Your Medium Profile Link]
- **GitHub**: [Your GitHub Profile Link]


