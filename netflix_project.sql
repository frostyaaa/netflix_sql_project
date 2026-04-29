-- netflix project
drop table if exists netflix;
create table netflix(
	show_id varchar(20),
	type varchar(20),
	title varchar(255),
	director varchar(255),
	casts varchar(1000),
	country varchar(255),
	date_added varchar(250),
	release_year int,
	rating varchar(50),
	duration varchar(50),
	listed_in varchar(150),
	description varchar(255)
);
select * from netflix;

select 
	count(*) as total_count
from netflix;

select
distinct type
from netflix;

--problems
--q1.count total movies vs tv shows
select
	type,
	count(*) as total_content
from netflix
group by type;

--q2. find the most common rating for movies and tv shows.

select
	type,
	rating
from
(
	select
		type,
		rating,
		count(*),
	rank() over(partition by type order by count(*) desc) as ranking
	from netflix
	group by 1,2
) as t1
where
	ranking = 1;

--q3.list all movies released in a specific year(2020)
select * 
from netflix
where type = 'Movie' and release_year = 2020;

--q4.find the top 5 countries with most content
select
	unnest(string_to_array(country, ',')) as new_country,
	count(show_id) as total_content
from netflix
group by 1
order by 2 desc
limit 5;

--q5.identify the longest movie

SELECT *
FROM netflix
WHERE 
	type = 'Movie'
	and
	duration = (select MAX(duration) from netflix)

--q6.content added in last five years
select * 
from netflix
where
	to_date(date_added, 'Month DD, yyyy')>= current_date - interval '5 years';

--q7. all movies/tv shows by director 'rajiv chilaka'
select * 
from netflix
where director like '%Rajiv Chilaka%'

--q8. list all tv show with more than 5 seasons
select * from netflix
where type = 'TV Show' and duration > '5 Seasons';

--q9.number of content in each genre
select
unnest(string_to_array(listed_in,',')) as genre,
count(show_id) as total_content
from netflix
group by 1

--q10. list all movies which are documentries
select * from netflix
where listed_in ILIKE '%documentaries';

--q11.all content without director

select * from netflix
where director is null;

--q12.movies where actor salman khan apppeared in 10 years
select * from netflix 
where
	casts ILIKE	'%Salman Khan%'
	and
	release_year > extract(YEAR from current_date) - 10

--q13.top 10 actors who appeared in highest no of film in india
select
unnest(string_to_array(casts,',')) as actors,
count(*) as total_content
from netflix
where country ILIKE '%india'
group by 1
order by 2 desc
limit 10;

/*q14.categorize the content based on the keywords 'Kill' and 'voilence' in the
	description field. label content containing these keywords as 'Bad' and all other content as 'good.
	'count how many items fall into eacj category.*/
with new_table
as
(
	select
	*,	
		case
		when
			description ILIKE '%kill%' or
			description ILIKE '%violence%' then 'Bad Content'
			else 'Good Content'
		end category
	from netflix
)
select 
	category,
	count(*) as total_content
from new_table
group by 1





















select * from netflix;















