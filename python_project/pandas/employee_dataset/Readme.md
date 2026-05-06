
#  Employee Data Analysis using Pandas

##  Project Overview
This project analyzes employee data to extract meaningful insights related to salary distribution, employee performance, hiring trends, and workforce distribution. The goal is to transform raw data into actionable business insights using data analysis techniques.

---

##  Tools Used
- Python  
- Pandas  
- Matplotlib  

---

##  Dataset
The dataset contains employee details such as:
- Employee ID  
- Name  
- Age  
- Gender  
- Department  
- Job Title  
- Salary  
- Joining Date  
- Experience  
- Performance Rating  
- City  
- Education Level  

---

##  Data Cleaning
- Handled missing values in numerical and categorical columns  
- Filled categorical data with appropriate values  
- Converted `Joining_Date` to datetime format  
- Ensured correct data types for analysis  

---

##  Data Transformation
- Created new columns:
  - `bonus` (based on salary)  
  - `salary_seg` (salary-based categorization)  
  - `age_group`  
  - `exp_level_seg` (experience-based segmentation)  
  - `perform_seg` (performance-based categorization)  
- Standardized column names for consistency  

---

##  Data Visualization
The following visualizations were created using Matplotlib:
- Average Salary by Department (Bar Chart)  
- Employee Distribution by City (Bar Chart)  
- Salary vs Experience Level (Bar Chart)  
- Salary vs Experience (Line Chart)  

These visualizations help in understanding patterns, comparisons, and trends within the dataset.

---

##  Key Analysis
- Average salary by department  
- Employee distribution by city  
- Salary vs experience level  
- Performance vs salary  
- Hiring trends over time  

---

##  Key Insights
- The Finance department has the highest average salary, while HR has comparatively lower salary levels  
- Pune and Ahmedabad are major workforce hubs with the highest employee count  
- A strong positive relationship exists between performance and salary  
- The year 2021 recorded the highest hiring activity, indicating a peak recruitment phase  

---

##  Files Included
- `employee_dataset.ipynb`  
- `employee_raw_dirty_pandas.csv`  
- `cleaned_employee_dataset.csv`  

---

##  Conclusion
This project demonstrates end-to-end data analysis using Pandas, including data cleaning, transformation, visualization, and insight generation. It highlights how raw data can be converted into meaningful insights to support decision-making.

---
