Create database Ptc_Diagrama
--Creación de la base de datos 

CREATE TABLE Rol (
    idRol INT PRIMARY KEY identity(1,1), --Creando el rol de el empleado(Admin o empleado)
    nombreRol NVARCHAR(50)
);

Insert into Rol values('Administrador'),('Empleado');--creando 2 registros dentro de la tabla rol 

CREATE TABLE Usuario ( --Creación de la tabla usuario
    idUsuario INT PRIMARY KEY IDENTITY(1,1),
    nombreUsuario NVARCHAR(50) UNIQUE,--Nombre visible por el usuario (como de una cuenta)
    password NVARCHAR(100),--Contraseñ0
    correo NVARCHAR(100),
    idRol INT,--Esta parte hace una relación a la tabla Rol por medio de una llave foranea
    FOREIGN KEY (idRol) REFERENCES Rol(idRol)

);

SELECT name --Esto consulta la llave doranea de un usuario EXPLICAR EDUARDO
FROM sys.foreign_keys 
WHERE parent_object_id = OBJECT_ID('Empleado');

alter table Empleado Drop constraint FK__Empleado__idUsua__5165187F;--Explicar el drop de la llave foranea (lo anotaste)
alter table empleado drop column idUsuario;

alter table Usuario add idEmpleado INT; --agregando a usuario la llave foranea de empleado
Alter table Usuario ADD CONSTRAINT FK_Usuario_Empleado Foreign key (idEmpleado) references Empleado(idEmpleado);

select*from Usuario
INSERT INTO Usuario values('NatalyCruz','chinchi','20250644@ricaldone.edu.sv',1,1);
INSERT INTO Usuario values('Tany','1958','Tanya@gmail.com',1,2);
--Insertando valores aleatorios en la tabla de usuario para hacer las pruebas 


select*from Usuario--Mostrando la tabla usuario

CREATE TABLE Taller ( --creando la tabla taller
    idTaller INT PRIMARY KEY IDENTITY(1,1),
    nombreTaller NVARCHAR(100),
    direccion NVARCHAR(150),
    telefono NVARCHAR(20)
);

INSERT INTO Taller values('Taller 1 San Salvador','Cima 4, Avenida la guacalchía,calle poniente','7865-7198')
INSERT INTO Taller values('Taller 2 San Salvador','Vulebar los Próceres','1234-3112')

 --Mostrar talleres

CREATE TABLE Empleado ( --creando la tabla empleado con una llave foranea en el taller en el que está y otra para el usuario que maneja este empleado
    idEmpleado INT PRIMARY KEY IDENTITY(1,1),
    idTaller INT,
    apellido varchar(50),
    nombre varchar(50),
    puesto NVARCHAR(50),
    salario DECIMAL(10, 2),
    fechaContratacion DATE,
    FOREIGN KEY (idTaller) REFERENCES Taller(idTaller)
);
ALTER TABLE Empleado Drop column idUsuario;

INSERT INTO Empleado values(1,'Secretaria',1000,'2025/12/21','Nataly Saraí','Cruz Ortiz')--posible creación de una tabla de tipos trabajadores 
select*from Empleado
delete from empleado-- borro empleados
DBCC CHECKIDENT ('Empleado', RESEED, 0);--re estrablesco contador de identity

--Creación de la tabla cliente
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY IDENTITY(1,1),
    dui NVARCHAR(10) UNIQUE,
    nombreCompleto NVARCHAR(100),
    telefono NVARCHAR(20),
    direccion NVARCHAR(150)
);

--Creación de la tabla tipo combustible
CREATE TABLE TipoCombustible (
    idCombustible INT PRIMARY KEY,
    tipo NVARCHAR(50)
);

--Creación de la tabla carro  Esta tabla hace uso de de el id combustible y de el cliente como llave foranea
CREATE TABLE Carro (
    idCarro INT PRIMARY KEY IDENTITY(1,1),
    matricula NVARCHAR(20) UNIQUE,
    marca NVARCHAR(50),
    modelo NVARCHAR(50),
    anio INT,
    color NVARCHAR(30),
    idCombustible INT,
    estado NVARCHAR(30),
    idCliente INT,
    FOREIGN KEY (idCombustible) REFERENCES TipoCombustible(idCombustible),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE IngresoTaller ( --esta tabla contiene la información de el ingreso al taller 
    idIngreso INT PRIMARY KEY IDENTITY(1,1),
    idCarro INT,
    idTaller INT,
    fechaIngreso DATE,
    problemaReportado NVARCHAR(200),
    estadoTrabajo NVARCHAR(50), -- esto podría ser ligado a otra tabla de estados de trabajo
    observaciones NVARCHAR(300),
    FOREIGN KEY (idCarro) REFERENCES Carro(idCarro),-- Incluye cual carro fue el que ingresó y también incluye ek taller en el que ingresó
    FOREIGN KEY (idTaller) REFERENCES Taller(idTaller)
);

CREATE TABLE Servicio (
    idServicio INT PRIMARY KEY IDENTITY(1,1), --esta tabla es para saber a cerca de el servicio que se le va a prestar a un carro
    nombreServicio NVARCHAR(100),
    descripcion NVARCHAR(300),
    precio DECIMAL(10, 2)
);

CREATE TABLE HistorialServicio (
    idHistorial INT PRIMARY KEY IDENTITY(1,1),
    idIngreso INT,--esta tabla guarda el historial de servivios usuando la llave foranea de el ingreso (problema fecha y eso) 
    idServicio INT,--y también a travéz de cual servicio se le realizó
    fechaServicio DATE,
    FOREIGN KEY (idIngreso) REFERENCES IngresoTaller(idIngreso),
    FOREIGN KEY (idServicio) REFERENCES Servicio(idServicio)
);

CREATE TABLE Producto (--tabla general de productos 
    idProducto INT PRIMARY KEY IDENTITY(1,1),
    nombreProducto NVARCHAR(100),
    precioUnitario DECIMAL(10,2),
    tipo NVARCHAR(50)-- podríamos crear una tabla de tipos de productos dividiendolo como en el figma
    -- que el id 1 sean repuestos el id 2 sean herramientas el id 3 equipos de diagnóstico
);

CREATE TABLE Venta (-- Una pequeña tabla de venta donde poder ver que empleado realizó la venta en la fecha específica
    idVenta INT PRIMARY KEY IDENTITY(1,1), --(Agregar apartado en figma)
    idEmpleado INT,
    fechaVenta DATE,
    montoTotal DECIMAL(10, 2),
    FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado)
);

CREATE TABLE DetalleVenta (--tabla para saber que producto se realizó la venta y que cantidad (posibilidad a cambios)
    idDetalle INT PRIMARY KEY IDENTITY(1,1),--(Agregar apartado en figma)
    idVenta INT,
    idProducto INT,
    cantidad INT,
    precioFinal DECIMAL(10,2),
    FOREIGN KEY (idVenta) REFERENCES Venta(idVenta),
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
);



--Borrar campo
--ALTER TABLE NombreDeLaTabla DROP COLUMN nombreDelCampo;

--DBCC CHECKIDENT ('NombreDeLaTabla', RESEED, nuevoValor);
