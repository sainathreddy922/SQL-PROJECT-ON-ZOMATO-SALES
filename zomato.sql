create database zomato;
use zomato;

CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 
INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'09-22-2017'),
(3,'04-21-2017');

CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'09-02-2014'),
(2,'01-15-2015'),
(3,'04-11-2014');

CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'04-19-2017',2),
(3,'12-18-2019',1),
(2,'07-20-2020',3),
(1,'10-23-2019',2),
(1,'03-19-2018',3),
(3,'12-20-2016',2),
(1,'11-09-2016',1),
(1,'05-20-2016',3),
(2,'09-24-2017',1),
(1,'03-11-2017',2),
(1,'03-11-2016',1),
(3,'11-10-2016',1),
(3,'12-07-2017',2),
(3,'12-15-2016',2),
(2,'11-08-2017',2),
(2,'09-10-2018',3);

CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);
select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

--- 1. total amount each coustomer spent on zomato
select s.userid,sum(p.price) as total_amount from product as p inner join sales as s on p.product_id=s.product_id
group by s.userid ;

--- 2.how many days each customer visited zomato
select userid,count(distinct created_date) as days from sales
group by userid;

--- 3.what was the first product purchased by each customer
select * from
(select *,rank() over (partition by userid order by created_date)as rnk from sales) as ab
where rnk=1;

--- 4. what is the most purchased item on the menu and how many times it was purchased by all customers
select userid,count(product_id) as ct from sales where product_id= (select top 1 product_id  from sales
group by product_id 
order by count(product_id) desc)
group by userid;

--- 5. which item was the most popular for each customer
select * from
(select *,rank()over(partition by userid order by cnt desc) as rnk from 
(select userid,product_id,count(product_id) as cnt from sales
group by userid,product_id) as ad) as aw
where rnk=1;

--- 6. which iteam was purchased by the customer after they become a member
select * from
(select * , rank() over (partition by userid order by created_date) as rnk from
(select s.userid,s.product_id,s.created_date,g.gold_signup_date from goldusers_signup as g 
inner join sales as s
on s.userid=g.userid and created_date>=gold_signup_date) as x) as y
where rnk = 1;

--- 7. which iteam was purchased by the customer before they become a member
select * from
(select * , rank() over (partition by userid order by created_date desc) as rnk from
(select s.userid,s.product_id,s.created_date,g.gold_signup_date from goldusers_signup as g 
inner join sales as s
on s.userid=g.userid and created_date<=gold_signup_date) as x) as y
where rnk = 1;

--- 8. what is the total orders and how much amount spent for each member before they become member

select userid,sum(price) as total_price,count(created_date) as total_orders from
(select s.userid,s.product_id,s.created_date,g.gold_signup_date from goldusers_signup as g 
inner join sales as s
on s.userid=g.userid and created_date<=gold_signup_date) as c inner join product as p
on p.product_id=c.product_id
group by userid;


---9.If buying each product generates points for eg 5rs-2 zomato point and each product has different
--purchasing points for eg for p1 5rs 1 zomato point, for p2 10rs 5zomato point and p3 5rs-1
--zomato point 2rs Izomato point
---calculate points collected by each customers and for which product most points havebeen given till now
 
 select userid,sum(total_points) as total_points_earned from
(select b.*,total_price/points as total_points from
(select a.*,case when product_id =1 then 5 when product_id=2 then 2 when product_id=3 then 5 else 0
end as points from
(select s.userid,s.product_id,sum(price)as total_price from sales as s inner join product as p
on p.product_id=s.product_id group by s.userid,s.product_id)as a) as b) as c
group by userid;

select g.* from
(select *,rank() over (order by total_points_earned desc) as rnk from
(select product_id,sum(total_points) as total_points_earned from
(select b.*,total_price/points as total_points from
(select a.*,case when product_id =1 then 5 when product_id=2 then 2 when product_id=3 then 5 else 0
end as points from
(select s.userid,s.product_id,sum(price)as total_price from sales as s inner join product as p
on p.product_id=s.product_id group by s.userid,s.product_id)as a) as b) as c
group by product_id) as f) as g
where rnk=1;


--- 10.In the first one year after a customer joins the gold program (including their join date) 
--irrespective of what the customer has purchased they earn 5 zomato points for every 10 rs spent
--who earned more 1 or 3 and what was their points earnings in thier first yr?
select d.userid,p.price*0.5 as total_points_acheived from
(select s.userid,s.product_id,s.created_date,g.gold_signup_date from goldusers_signup as g 
inner join sales as s
on s.userid=g.userid and created_date>=gold_signup_date and created_date<= DATEADD(year,1,gold_signup_date))
as d inner join product as p on p.product_id=d.product_id;

--- 11. rank all the  transcations of the customers
select *,rank() over (partition by userid order by created_date) as rnk from sales;

--- 12. rank all the transactions for each member whenever they are a gold member for ever
--non gold member transaction mark as na

select *,case when rnk = 0 then 'na' else rnk end as rnkk from
(select *,cast(case when gold_signup_date is null then 0 else
rank()over (partition by userid order by created_date desc) end  as varchar) as rnk from
(select s.userid,s.product_id,s.created_date,g.gold_signup_date from goldusers_signup as g 
right join sales as s
on s.userid=g.userid and created_date>=gold_signup_date) as a) as b;
