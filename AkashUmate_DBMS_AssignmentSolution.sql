drop database travel_info;
create database travel_info;
use travel_info;
-- 1. Create two tables for PASSENGER and PRICE
create table if not exists `passenger`
	(`Passenger_id` int primary key auto_increment, 
     `Passenger_name` varchar(50), 
     `Category` varchar(20), 
     `Gender` varchar(10),
     `Boarding_City` varchar(30),
     `Destination_City` varchar(30),
     `Distance` int not null,
     `Bus_Type` varchar(20));
     
create table if not exists `price`
	(`Bus_Type` varchar(20),
     `Distance` int not null,
     `Price` int not null);
     
-- 2. Insert the following data in the tables
insert into `passenger` values('1','Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', '350', 'Sleeper');
insert into `passenger` values('2','Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', '700', 'Sitting');
insert into `passenger` values('3','Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', '600', 'Sleeper');
insert into `passenger` values('4','Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', '1500', 'Sleeper');
insert into `passenger` values('5','Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', '1000', 'Sleeper');
insert into `passenger` values('6','Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', '500', 'Sitting');
insert into `passenger` values('7','Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', '700', 'Sleeper');
insert into `passenger` values('8','Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', '500', 'Sitting');
insert into `passenger` values('9','Piyush', 'AC', 'M', 'Pune', 'Nagpur', '700', 'Sitting');

insert into `price` values('Sleeper', 300, 770);
insert into `price` values('Sleeper', 500, 1100);
insert into `price` values('Sleeper', 600, 1320);
insert into `price` values('Sleeper', 700, 1540);
insert into `price` values('Sleeper', 1000, 2200);
insert into `price` values('Sleeper', 1200, 2640);
insert into `price` values('Sleeper', 1500, 2700);
insert into `price` values('Sitting', 500, 620);
insert into `price` values('Sitting', 600, 744);
insert into `price` values('Sitting', 700, 868);
insert into `price` values('Sitting', 1000, 1240);
insert into `price` values('Sitting', 1200, 1488);
insert into `price` values('Sitting', 1500, 1860);


-- 3. How many females and how many male passengers travelled for a minimum distance of 600 KMs?
select passenger.Gender,count(passenger.Gender) as count from passenger where passenger.Distance >= 600 group by passenger.Gender;

-- 4. Find the minimum ticket price for Sleeper Bus.
select min(`price`.Price) as smallestPrice from `price` where price.Bus_Type='Sleeper';

-- 5. Select passenger names whose names start with character 'S'
select `passenger`.Passenger_name from `passenger` where `passenger`.Passenger_name like "S%";

-- 6. Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output
select `passenger`.Passenger_name, `passenger`.Boarding_City, `passenger`.Destination_City, `passenger`.Distance, `passenger`.Bus_Type, `price`.Price from `passenger`, `price` where (`price`.Bus_Type = `passenger`.Bus_Type and `price`.Distance = `passenger`.Distance);

-- 7. What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s
select `passenger`.Passenger_name, `price`.Price from `passenger`, `price` where (passenger.Bus_Type = 'Sitting' and price.Bus_Type = 'Sitting' and passenger.Distance =1000 and price.Distance =1000);

-- 8. What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
select `price`.Price from `price` where `price`.Distance = (select `passenger`.Distance from `passenger` where `passenger`.Passenger_name = 'Pallavi');

-- 9. List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
select distinct `passenger`.Distance from `passenger` order by `passenger`.Distance desc;

-- 10. Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables
with total as (select sum(`passenger`.Distance) as TotalDistance from `passenger`) select `passenger`.Passenger_name,(`passenger`.Distance/total.TotalDistance)*100 as 'Percentage of distance' from `passenger`,total;

-- 11. Display the distance, price in three categories in table Price
-- 		a) Expensive if the cost is more than 1000
-- 		b) Average Cost if the cost is less than 1000 and greater than 500
-- 		c) Cheap otherwise

select `price`.Distance, `price`.Price,
	case
		when `price`.Price > 1000 then 'Expensive'
        when `price`.Price < 1000 and `price`.Price > 500 then 'Average Cost'
        else 'Cheap'
	end as 'Cost Category'
from price;

