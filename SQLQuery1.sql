if not exists (select * from sys.databases where name =  'HospitalDB')
begin
	create database HospitalDB;
end
go

select name from sys.databases where name = 'HospitalDB';
go

use HospitalDB;
go