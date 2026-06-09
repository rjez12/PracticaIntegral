if not exists(select * from sys.databases where name = 'EmpresaSQL')
begin
	create database EmpresaSQL
end

go
use EmpresaSQL
go
