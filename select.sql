--Вывести название вакансии, город, в котором опубликована вакансия (можно просто area_id), 
--имя работодателя для первых 10 вакансий у которых не указана зарплата, 
--сортировать по дате создания вакансии от новых к более старым.
SELECT 
	vacancy.name AS Vacancy, 
	location.name as City, 
	employer.name AS Employer
FROM vacancy 
LEFT JOIN location ON vacancy.location_id = location.id
LEFT JOIN employer ON vacancy.employer_id = employer.id
WHERE 
	compensation_from IS null 
	AND compensation_to IS NULL
ORDER BY 
	date_create DESC
LIMIT 10

--Вывести среднюю максимальную зарплату в вакансиях, среднюю минимальную и среднюю среднюю 
--(compensation_to - compensation_from) в одном запросе. Значения должны быть указаны до вычета налогов.
WITH cte_compensataion AS (
select 
	CASE WHEN compensation_gross IS true
    	THEN (compensation_from*0.87)
    	ELSE compensation_from
	END AS minimum, 	
	CASE WHEN compensation_gross IS true
    	THEN (compensation_to*0.87)
    	ELSE compensation_to
	END AS maximum
FROM vacancy)
SELECT 
	ROUND (AVG(maximum), 2) AS average_maximum,
	ROUND (AVG(minimum), 2) AS average_minimum,
	ROUND (AVG((maximum+minimum)/2), 2) AS average
FROM cte_compensataion


--Вывести топ-5 компаний, получивших максимальное количество откликов на одну вакансию, 
--в порядке убывания откликов. Если более 5 компаний получили одинаковое максимальное 
--количество откликов, отсортировать по алфавиту и вывести только 5.
WITH cte_count_response AS (
SELECT 
	employer_id,
	max(quantity) AS max_quantity
FROM (
	SELECT 
		employer_id, 
		vacancy_id, 
		COUNT(1) AS quantity 
	FROM response
	LEFT JOIN vacancy on response.vacancy_id = vacancy.id
	GROUP BY employer_id, vacancy_id 
) AS inner_table
GROUP BY employer_id
ORDER BY max_quantity DESC
	)
SELECT
	name
FROM cte_count_response AS cte
LEFT JOIN employer AS emp ON cte.employer_id = emp.id
ORDER BY max_quantity DESC, name
LIMIT 5

--Вывести медианное количество вакансий на компанию. Использовать percentile_cont.
WITH cte_quantity AS (
    SELECT 
		count(id) AS quantity,
		employer_id
    FROM vacancy 
    GROUP BY employer_id
) 
SELECT 
	percentile_cont(0.5) WITHIN GROUP (ORDER BY quantity) as median
FROM cte_quantity;

--Вывести минимальное и максимальное время от создания вакансии до первого отклика для каждого города.
SELECT 
	location.name AS City,
	MIN(response.date_create - vacancy.date_create) AS min_time,
	MAX(response.date_create - vacancy.date_create) AS max_time
FROM response
LEFT JOIN vacancy ON response.vacancy_id = vacancy.id
LEFT JOIN location ON vacancy.location_id = location.id
GROUP BY location.name