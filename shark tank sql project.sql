# Make your entrepreneurial dreams a reality by following lessons learnt from the successful panellists of Shark Tank India
# Earlier 2022, Shark Tank India’s first season concluded with 67 businesses winning over the judges and receiving funding 
# for their respective start-ups. The show began in December 2021 with over 62,000 applicants, and only 198 made it to the sets of Shark Tank India.
# Nevertheless, the intensity and intrigue of the show quickly made it a crowd favourite! 

# Concept of this show
#Shark Tank India is an Indian franchise of the original American hit reality show, “Shark Tank”. 
# The premise is simple, entrepreneurs pitch their ideas for businesses or products to a panel of potential investors, the “Sharks”. 
# The panellists themselves are self-made multi-millionaires who analyse the business models and products. 
# Depending on the proposed venture, the Sharks will decide whether or not to invest their own money in marketing and mentoring the contestants. 


#SCRUTINY

# Today we are going to do analaysis of this dream show which provides life changing opportunities 
# we do analysis into a question answer form which will make easy to understand the sql query.
# Data was collectd by wikipedia.

use project ;
show tables;
select * from shark_tank;

# How many episodes are their in this season?
select max(`Ep. No.`) from shark_tank;

# total number of unique episodes
select count(distinct `Ep. No.`) from shark_tank;

# total number of brand came into show? also show number of pitches ?
select count(distinct brand) from shark_tank;

# number of pitches converted into deal?
select cast(sum(a.converted_not_converted) as float) /cast(count(*) as float) from (
select `Amount Invested lakhs` ,
 case when `Amount Invested lakhs`>0 then 1 else 0 end as
 converted_not_converted from shark_tank) a;
  
  # total number of male enterpreneur participated into show?
  select sum(male) from shark_tank;

# total number of female enterpreneur participated into show?
select sum(female) from shark_tank;

# What is the gender ratio?
select sum(female)/sum(male) from shark_tank;

# find out total number of amount invested in deals
 select sum( `Amount Invested lakhs`) from shark_tank;

# what was Average number of equity taken by sharks?
 select avg(a.`Equity Taken %`) from
(select * from shark_tank where `Equity Taken %`>0) a;

#what is the highest invested amount by sharks. 
select max( `Amount Invested lakhs`) from shark_tank; 

# what is the highest equity which is taken.
select max(`Equity Taken %`) from shark_tank;


# number of startup having atleast one women in the business.
select sum(a.female_count) startups having at  women from (
select female,
case when female>0 then 1 else 0 end as
 female_count from shark_tank) a
 
 # Pitches converted into deal having atleast one women?
 select sum(b.female_count) from(

select case when a.female>0 then 1 else 0 end as female_count ,a.*from (
(select * from shark_tank where deal!='No Deal')) a)b

# find out the average team members ?
select round(avg(`Team members`)) from shark_tank;

# find out the amount invested into per deal?
select avg(a.`Amount Invested lakhs`) amount_invested_per_deal from
(select * from shark_tank where deal!='No Deal') a;

# what is the average age group of participants
select `Avg age`,count(`Avg age`) cnt from shark_tank 
group by `Avg age` order by cnt desc;

# find location where number of participants came?
select location,count(location) cnt from shark_tank group by location order by cnt desc;

# Majority of sector which came in show ?
select sector,count(sector) cnt from shark_tank group by sector order by cnt desc;

# How many deals are like partners deals ?
select partners,count(partners) cnt from shark_tank  where partners!='-' group by partners order by cnt desc;


# which is the startup in which the highest amount has been invested in each domain/sector  ?
select c.* from 
(select brand,sector,`Amount Invested lakhs`,rank() over(partition by sector order by `Amount Invested lakhs` desc) rnk 

from shark_tank) c

where c.rnk=1

select * from project..data

select 'Ashnner' as keyy,count(`Ashneer Amount Invested`) from shark_tank where `Ashneer Amount Invested` is not null


select 'Ashnner' as keyy,count(`Ashneer Amount Invested`) from shark_tank where `Ashneer Amount Invested` is not null AND `Ashneer Amount Invested`!=0

SELECT 'Ashneer' as keyy,SUM(C.`Ashneer Amount Invested`),AVG(C.`Ashneer Equity Taken %`) 
FROM (SELECT * FROM shark_tank  WHERE `Ashneer Equity Taken %`!=0 AND `Ashneer Equity Taken %` IS NOT NULL) C

=========
select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from

(select a.keyy,a.total_deals_present,b.total_deals from(

select 'Ashneer' as keyy,count(`Ashneer Amount Invested`) total_deals_present shark_tank where `Ashneer Amount Invested` is not null) a

inner join (
select 'Ashneer' as keyy,count(`Ashneer Amount Invested`) total_deals from shark_tank 
where `Ashneer Amount Invested` is not null AND`Ashneer Amount Invested`!=0) b 

on a.keyy=b.keyy) m

inner join 

(SELECT 'Ashneer' as keyy,SUM(C.`Ashneer Amount Invested`) total_amount_invested,
AVG(C.`Ashneer Equity Taken %`) avg_equity_taken
FROM (SELECT * FROM shark_tank WHERE `Ashneer Equity Taken %`!=0 AND`Ashneer Equity Taken %` IS NOT NULL) C) n

on m.keyy=n.keyy

# Above all this is the analysis of shark tank india reality show .All the analysis is just my point of view so, i do it in  gernal way not in specification 
#By this we took all sides in this analysis 