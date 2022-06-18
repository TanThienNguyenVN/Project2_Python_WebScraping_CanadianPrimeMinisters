
-------### Tan Thien Nguyen ###-------

---- Create DB canada_pm_tan ----

create database canada_pm_tan;

---- Create user tan/123456 and grant access to canada_pm_tan DB ----

grant all on canada_pm_tan.* to 'tan' identified by '123456';

---- Switch to use canada_pm_tan DB ----

use canada_pm_tan;

---- Create Raw Tables ----

create table prime_minister_raw (
id int not null auto_increment primary key,
pmno int,
name varchar(64),
url varchar(128),
birthdeath varchar (32),
pmborndate varchar(32),
pmdieddate varchar(32),
startoffice varchar(32),
endoffice varchar(32),
party varchar(128)
);

create table prime_minister_province(
id int not null auto_increment primary key,
pmno int,
name varchar(64),
code varchar(32),
province varchar(128)
);

---- Create Views ----

create table province_raw(
id int not null auto_increment primary key,
code varchar(32),
province varchar(128)
);

create view v_pm_province_master as
select distinct pmno, name, COALESCE(r1.code,r2.code,'Unknown') as code, COALESCE(r1.province,r2.province,'No Province') as province
from prime_minister_province p
left join province_raw r1 on p.code = r1.code
left join province_raw r2 on p.code = r2.province
;

create view v_prime_minister_master as
select distinct pmno, name,
coalesce(str_to_date(pmborndate,'%d %M %Y'),str_to_date(pmborndate,'%M %d %Y'), current_date) as pmborndate,
coalesce(str_to_date(pmdieddate,'%d %M %Y'),str_to_date(pmdieddate,'%M %d %Y'), current_date) as pmdieddate,
coalesce(str_to_date(startoffice,'%d %M %Y'),str_to_date(startoffice,'%M %d %Y'), current_date) as startoffice,
coalesce(str_to_date(endoffice,'%d %M %Y'),str_to_date(endoffice,'%M %d %Y'), current_date) as endoffice,
party
from prime_minister_raw h;

create view v_province_master as
select id, code, province from province_raw
;
-------### End ###-------