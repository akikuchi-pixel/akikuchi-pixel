-- Adele Kikuchi
-- Quick Calcs for Population by State

with pop as (
  select
  lpad(zipcode,5,"0") as zip_code
  ,sum(a.population) as population  
  from `bigquery-public-data.census_bureau_usa.population_by_zip_2010`  a
  where gender is null 
  group by 1
  order by 2 desc
)
  select
  state_code
  ,case when b.state_name = "Washington (state)" then "Washington"
        when b. state_name = "Georgia (U.S. state)" then "Georgia"
        when b.state_code = 'WY' then 'Wyoming'
        when b.state_code = 'GA' then "Georgia"
        when b.state_code = 'DC' then 'District of Columbia'
        else state_name
        end as state_name
  ,sum(population) as population
  from pop a 
  left join  `bigquery-public-data.geo_us_boundaries.zip_codes` b
  using(zip_code)
  group by 1,2
;

