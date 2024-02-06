--- create a Join table 

select * from Absenteeism_at_work a
left join Compensation b
on a.ID = b.ID;

select * from Absenteeism_at_work a
left join Reasons r
on a.Reason_for_absence = r.Number;


---- all 3 table in 1 table
select * from Absenteeism_at_work a
left join Compensation b
on a.ID = b.ID
left join Reasons r
on a.Reason_for_absence = r.Number;



---find the healthiest employees to give 
select * from Absenteeism_at_work
where Social_drinker = 0 
and Social_smoker = 0
and Body_mass_index <25 
and [Absenteeism_time_in_hours] <(select avg(Absenteeism_time_in_hours) from Absenteeism_at_work);


select count(*) as nonsmokers from Absenteeism_at_work
where Social_smoker = 0;


---- Compensation increase for non-smokers 
---- budget $983,221 is 0.68 cents per hour
---  total # of hours = 8x5x52 = 2080 hrs in one year and multiply this with # of nonsmokers 
--- 2080x686 = 1426800 (Total # of hrs)
---- 983211/1426800 = 0.68 cents / hr
---- 2080x0.68 = 1414.4 per year compensation for nonsmoker employees


---- optimize this query

select 
a.ID,
r.Reason,
Month_of_absence,
Body_mass_index,
CASE WHEN Body_mass_index <18.5 THEN 'Underweight'
	 WHEN Body_mass_index between 18.5 and 24.9 THEN 'Healthy Weight'
	 WHEN Body_mass_index between 24.9 and 30 THEN 'Overweight'
	 WHEN Body_mass_index >18.5 THEN 'Obese'
	 ELSE 'Unknown' end as BMI_Category,
CASE WHEN Month_of_absence in (12,1,2) then 'Winter'
	 WHEN Month_of_absence in (3,4,5) then 'Spring'
	 WHEN Month_of_absence in (6,7,8) then 'Summer'
	 WHEN Month_of_absence in (9,10,11) then 'Fall'
	 Else 'Unknown' END AS Season_Names
from Absenteeism_at_work a
left join Compensation b
on a.ID = b.ID
left join Reasons r
on a.Reason_for_absence = r.Number;





select 
a.ID,
r.Reason,
Month_of_absence,
Body_mass_index,
CASE WHEN Body_mass_index <18.5 THEN 'Underweight'
	 WHEN Body_mass_index between 18.5 and 24.9 THEN 'Healthy Weight'
	 WHEN Body_mass_index between 24.9 and 30 THEN 'Overweight'
	 WHEN Body_mass_index >18.5 THEN 'Obese'
	 ELSE 'Unknown' end as BMI_Category,
CASE WHEN Month_of_absence in (12,1,2) then 'Winter'
	 WHEN Month_of_absence in (3,4,5) then 'Spring'
	 WHEN Month_of_absence in (6,7,8) then 'Summer'
	 WHEN Month_of_absence in (9,10,11) then 'Fall'
	 Else 'Unknown' END AS Season_Names,
Age,
CASE WHEN Age <31 then 'Young'
	 WHEN Age between 31 and 45 then 'Adult'
	 WHEN Age between 46 and 60 then 'Old'
	 Else 'Unknown' END As Age_Group,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Work_load_Average_day,
Pet,
Service_time,
Disciplinary_failure,
Absenteeism_time_in_hours,
Social_drinker,
Social_smoker,
Hit_target
from Absenteeism_at_work a
left join Compensation b
on a.ID = b.ID
left join Reasons r
on a.Reason_for_absence = r.Number;


---- My question is can I use group by with a new column created like Age_group / Season_Name etc 
select count(ID) as count, age, 
CASE WHEN Age <31 then 'Young'
	 WHEN Age between 31 and 45 then 'Adult'
	 WHEN Age between 46 and 60 then 'Old'
	 Else 'Unknown' END As Age_Group
from Absenteeism_at_work
group by Age;


