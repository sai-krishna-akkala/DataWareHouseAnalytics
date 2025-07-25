--exploring the database
select * from INFORMATION_SCHEMA.TABLES

-- exploring the database columns
select * from INFORMATION_SCHEMA.COLUMNS

-- To explore the columns of specific table
select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='dim_customers'

