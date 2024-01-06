

-- ** Task 1: Average Hospital Charges Analysis
--			  By calculating the average hospital charges, we gain valuable information for financial planning, cost optimization, and transparency in healthcare services.
--			  I have tried to find average of charges according to hospital tier.

  SELECT Round(avg(Charges),2) as Average_Charge, 
		 host_tier as Hospital_Tier
  FROM  [Medical_Dataset].[dbo].[hospitalisation_details_cleaned]
  GROUP BY host_tier
  ORDER BY host_tier

-- ** Task 2: High Charges Analysis
--            This tasks focuses on identifying unique customer identifiers, corresponding years, and charges from a specific medical dataset, 
--			  specifically for records where charges exceed 700. By retrieving this data, we can gain insights into cases of exceptionally high hospital charges, 
--			  which can inform further investigation, cost control strategies, and patient financial support.

  SELECT Client_ID, 
         Year, 
		 Round(Charges,2) as Charges
  FROM [Medical_Dataset].[dbo].[hospitalisation_details_cleaned]
  WHERE Charges > 700
  order by Charges


-- ** Task 3: High BMI Patients Analysis
--            In this task, we aim to retrieve the name, year, and charges for customers with a BMI (Body Mass Index) greater than 35 from a medical dataset. 
--            Analyzing the data of high BMI patients allows us to understand the healthcare costs associated with this specific group. 
--            This information can be valuable for identifying health trends, managing patient care, and optimizing medical expenses.


	SELECT n.name as Client_Name, 
	       h.year as Year , 
		   round(h.charges,2)  as Charge
	FROM [Medical_Dataset].[dbo].[names] n
	LEFT JOIN [Medical_Dataset].[dbo].[medical_examinations_cleaned] m ON m.Client_ID = n.customer_id
	LEFT JOIN [Medical_Dataset].[dbo].[hospitalisation_details_cleaned] h ON m.Client_ID = h.Client_ID
	WHERE BMI>35
	ORDER BY BMI


-- ** Task 4: Customers with Major Surgeries
--            This task focuses on listing customer IDs and names of individuals from the names table who have undergone major surgeries, as recorded in the medical_examinations 
--            table. By identifying such patients, we can gain insights into the population with a history of major surgical procedures, which can inform healthcare planning, 
--            risk assessment, and medical follow-up.

	SELECT n.customer_id AS Client_ID, n.name as Client_Name
	FROM [Medical_Dataset].[dbo].[names] n
	LEFT JOIN [Medical_Dataset].[dbo].[medical_examinations_cleaned] m ON m.Client_ID = n.customer_id
	WHERE Number_of_Major_surgeries > 0
	ORDER BY Client_ID

-- **Task 5: Average Charges by Hospital Tier in 2000
--			In this task, we aim to calculate the average hospital charges per hospital tier for the year 2000 from the hospitalization_details table. 
--			This analysis allows us to understand the variation in charges based on the hospital tier, providing insights into cost disparities and healthcare quality across 
--			different tiers. It can assist in making informed decisions about healthcare facilities and costs.

  SELECT Round(avg(Charges),2) as Average_Charge, 
		 host_tier as Hospital_Tier
  FROM  [Medical_Dataset].[dbo].[hospitalisation_details_cleaned]
  WHERE Year = 2000
  GROUP BY host_tier
  ORDER BY host_tier
	

-- ** Task 6: Smoking Patients with Transplants Analysis
--			 This task aims to retrieve customer IDs, BMI, and charges for patients who are smokers and have undergone a transplant, as per the medical_examinations and 
--			 hospitalization_details tables. Analyzing this data allows us to study the healthcare costs and health conditions of patients with a history of smoking and transplants. 
--			 This information can be valuable for targeted healthcare interventions and cost estimation.

  SELECT 
		m.[Client_ID]
         ,Round([BMI],2) as BMI
		 ,Round([Charges],2) as Charges
  FROM [Medical_Dataset].[dbo].[medical_examinations_cleaned]   m
  LEFT JOIN [Medical_Dataset].[dbo].[hospitalisation_details_cleaned] h ON m.Client_ID = h.Client_ID
  WHERE Patient_Smokes =1 AND Transplant_History = 1
  ORDER BY Client_ID

--    ** Task 7: Patients with Major Surgeries or Cancer History
--				 In this project, we retrieve the names of customers who have had at least two major surgeries or have a history of cancer, as recorded in the medical_examinations 
--				 table. This analysis helps identify patients with complex medical histories, enabling healthcare providers to tailor care plans and assess potential healthcare costs 
--				 for these individuals.

  SELECT n.name as Client_Name,  
		 m.Number_of_Major_surgeries,
		 m.Cancer_History
  FROM [Medical_Dataset].[dbo].[names] n
  JOIN [Medical_Dataset].[dbo].[medical_examinations_cleaned] m ON m.Client_ID = n.customer_id
  WHERE Number_of_Major_surgeries >= 2 OR Cancer_History = 1
  ORDER BY Number_of_Major_surgeries DESC


--  **Task 8: Customer with Most Major Surgeries

  SELECT TOP 1 n.name as Client_Name, 
			   m.Number_of_Major_surgeries
  FROM [Medical_Dataset].[dbo].[names] n
  JOIN [Medical_Dataset].[dbo].[medical_examinations_cleaned] m ON m.Client_ID = n.customer_id
  ORDER BY Number_of_Major_surgeries DESC

-- ** Task 9: Customers with Major Surgeries and City Tiers
--			  In this task, we compile a list of customers who have undergone major surgeries and their respective cities' tier levels (city_tier) from the hospitalization_details 
--			  table. This analysis provides insights into the distribution of major surgeries across different city tiers, aiding in healthcare planning, resource allocation, and 
--			  assessing the impact of city tiers on surgical cases.


  SELECT 
		 n.customer_id AS Client_ID,
		 n.name AS Client_Name,  
		 m.Number_of_Major_surgeries,
		 h.Ct_tier AS City_Tier
  FROM [Medical_Dataset].[dbo].[names] n
  JOIN [Medical_Dataset].[dbo].[medical_examinations_cleaned] m ON m.Client_ID = n.customer_id
  JOIN [Medical_Dataset].[dbo].[hospitalisation_details_cleaned] h ON m.Client_ID = h.Client_ID 
  WHERE Number_of_Major_surgeries >= 1
  ORDER BY Number_of_Major_surgeries DESC


-- ** Task 10: Average BMI by City Tier in 1995
		
	SELECT Round(AVG(BMI),2) as Average_BMI, h.Ct_tier as City_Tier
	FROM [Medical_Dataset].[dbo].[medical_examinations_cleaned] m
	JOIN [Medical_Dataset].[dbo].[hospitalisation_details_cleaned] h ON m.Client_ID = h.Client_ID  
	WHERE Year = 1995
	GROUP BY Ct_tier
	ORDER BY Ct_tier

-- ** Task 11: High BMI Customers with Health Issues
--			   This project, we extract customer IDs, names, and charges of customers who have health issues and a BMI greater than 30. By combining data from the names, 
--			   medical_examinations, and hospitalization_details tables, we can identify individuals with specific health concerns and high BMI levels. This information is valuable 
--			   for targeted healthcare interventions and assessing associated healthcare costs.


	SELECT n.customer_ID as Client_ID
		  ,n.name as Client_Name
		  ,Round(h.Charges,2) as Charges
	FROM [Medical_Dataset].[dbo].[names] n
	JOIN [Medical_Dataset].[dbo].[hospitalisation_details_cleaned] h ON n.customer_ID = h.Client_ID  
	JOIN [Medical_Dataset].[dbo].[medical_examinations_cleaned] m ON m.Client_ID = n.customer_id
	WHERE BMI > 30 AND Health_Issues = 1
	ORDER BY BMI DESC

-- ** Task 12: Customers with Highest Charges and City Tier by Year
--             In this task, we identify the customer with the highest total charges for each year and display their corresponding city_tier.
--			   This analysis is crucial for understanding cost patterns over time and tailoring healthcare strategies accordingly.

	
	WITH temp AS(
	SELECT 
		   n.customer_ID as Client_ID
		  ,n.name as Client_Name
		  ,h.Year
		  ,h.Ct_tier as City_Tier
		  ,Round(h.Charges,2) as Charges
		  ,ROW_NUMBER() over(partition by Year order by charges desc) as Rank
	FROM [Medical_Dataset].[dbo].[names] n
	JOIN [Medical_Dataset].[dbo].[hospitalisation_details_cleaned] h ON n.customer_ID = h.Client_ID  
	
	)
	SELECT  
		   Client_ID
		  ,Client_Name
		  ,Year
		  ,City_Tier
		  ,Charges
	FROM temp
	WHERE Rank= 1
	

--  ** Task 16: Identifying Peak Year for Hospitalizations
--				This task is essential for identifying the year with the highest number of hospitalizations. By calculating the count of 
--				hospitalizations for each year from the hospitalization_details dataset, we can pinpoint the peak year for healthcare demand. 
--				This insight can help healthcare institutions allocate resources and plan for peak demand years more effectively.

	SELECT Top 1
		   Year, 
		   COUNT(*) as Number_of_Hospitalizations
	FROM [Medical_Dataset].[dbo].[hospitalisation_details_cleaned]
	GROUP BY year
	ORDER BY Number_of_Hospitalizations desc

