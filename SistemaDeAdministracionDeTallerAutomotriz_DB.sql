-- CREACIÓN DE BASE DE DATOS
CREATE DATABASE SistemaDeAdministracionTallerAutomotrizDB;
GO
USE SistemaDeAdministracionTallerAutomotrizDB;
GO
-- Tabla Rol
CREATE TABLE Rol (
    idRol INT PRIMARY KEY IDENTITY(1,1),
    nombreRol NVARCHAR(50) NOT NULL
);

Insert into Rol values('Administrador'),('Empleado');--creando 2 registros dentro de la tabla rol 

-- Tabla Taller
CREATE TABLE Taller (
    idTaller INT PRIMARY KEY IDENTITY(1,1),
    nombreTaller NVARCHAR(100)NOT NULL,
    direccion NVARCHAR(200),
    telefono NVARCHAR(20)NOT NULL
);

INSERT INTO Taller values('Taller 1 San Salvador','Cima 4, Avenida la guacalchía,calle poniente','7865-7198')
INSERT INTO Taller values('Taller 2 San Salvador','Vulebar los Próceres','1234-3112')

-- Tabla Empleado
CREATE TABLE Empleado (
    idEmpleado INT PRIMARY KEY IDENTITY(1,1),
    idTaller INT,
    nombre NVARCHAR(50),
    apellido NVARCHAR(50),
    puesto NVARCHAR(50),
    salario DECIMAL(10,2),
    fechaContratacion DATE,
    FOREIGN KEY (idTaller) REFERENCES Taller(idTaller)
);

INSERT INTO Empleado values(1,'Nataly Sarai','Cruz Ortiz','Secretaria','1200','2025/7/5')

-- Tabla Usuario
CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY IDENTITY(1,1),
    nombreUsuario NVARCHAR(50) UNIQUE NOT NULL,
    clave NVARCHAR(100),
    correo NVARCHAR(100),
    idRol INT,
    idEmpleado INT,
    FOREIGN KEY (idRol) REFERENCES Rol(idRol),
    FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado)
);

select *from Cliente
INSERT INTO Usuario values('NatalyCruz','chinchi','20250644@ricaldone.edu.sv',1,1);
INSERT INTO Usuario values('1','1','20250644@ricaldone.edu.sv',1,1);


-- Tabla Cliente
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100)NOT NULL,
    dui NVARCHAR(20)Unique,
    telefono NVARCHAR(20),
    correo NVARCHAR(100),
    fechaIngreso date
);

Alter table Cliente Add apellido Varchar (100)

insert into cliente values ('Liones Andres','71147464-5','76816739','hola@gmail.com','2025/2/14','Messi')

Select nombre,apellido,dui,telefono,correo,fechaIngreso from Cliente

-- Tabla TipoCombustible
CREATE TABLE TipoCombustible (
    idTipoCombustible INT PRIMARY KEY IDENTITY(1,1),
    nombreTipo NVARCHAR(50)
);

-- Tabla Marca
CREATE TABLE Marca (
    idMarca INT PRIMARY KEY IDENTITY(1,1),
    nombreMarca NVARCHAR(50)
);
-- Tabla Modelo
CREATE TABLE Modelo (
    idModelo INT PRIMARY KEY IDENTITY(1,1),
    nombreModelo NVARCHAR(50),
    idMarca INT,
    FOREIGN KEY (idMarca) REFERENCES Marca(idMarca)
);
-- Tabla Carro
CREATE TABLE Carro (
    idCarro INT PRIMARY KEY IDENTITY(1,1),
    matricula NVARCHAR(20),
    color NVARCHAR(30),
    anio INT,
    idTipoCombustible INT,
    idCliente INT,
    idModelo INT,
    FOREIGN KEY (idTipoCombustible) REFERENCES TipoCombustible(idTipoCombustible),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo)
);

-- Tabla Producto
CREATE TABLE Producto (
    idProducto INT PRIMARY KEY IDENTITY(1,1),
    nombreProducto NVARCHAR(100),
    precioUnitario DECIMAL(10,2),
    stock INT
);

-- Tabla Servicio
CREATE TABLE Servicio (
    idServicio INT PRIMARY KEY IDENTITY(1,1),
    nombreServicio NVARCHAR(100),
    descripcion NVARCHAR(200),
    precio DECIMAL(10,2)
);




--Sección de compra y venta

-- unidad de medida
CREATE TABLE UnidadMedida (
    idUnidadMedida INT PRIMARY KEY IDENTITY(1,1),
    nombreUnidad NVARCHAR(50),
    abreviatura NVARCHAR(10)
);

-- Tabla Proveedor
CREATE TABLE Proveedor (
    idProveedor INT PRIMARY KEY IDENTITY(1,1),
    nombreEmpresa NVARCHAR(100)NOT NULL,
    telefono NVARCHAR(20),
    correo NVARCHAR(100)
);

-- Tabla Compra
CREATE TABLE Compra (
    idCompra INT PRIMARY KEY IDENTITY(1,1),
    fechaCompra DATE,
    idProveedor INT,
    idTaller INT,
    FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor),
    FOREIGN KEY (idTaller) REFERENCES Taller(idTaller)
);

-- DetalleCompra
CREATE TABLE DetalleCompra (
    idDetalleCompra INT PRIMARY KEY IDENTITY(1,1),
    idCompra INT,
    idProducto INT,
    cantidad INT,
    precioUnitario DECIMAL(10,2),
    idUnidadMedida INT,
    fechaDetalle DATE,
    FOREIGN KEY (idCompra) REFERENCES Compra(idCompra),
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto),
    FOREIGN KEY (idUnidadMedida) REFERENCES UnidadMedida(idUnidadMedida)
);

-- Tabla Venta
CREATE TABLE Venta (
    idVenta INT PRIMARY KEY IDENTITY(1,1),
    fechaVenta DATE,
    idTaller INT,
    FOREIGN KEY (idTaller) REFERENCES Taller(idTaller)
);

-- DetalleVenta
CREATE TABLE DetalleVenta (
    idDetalle INT PRIMARY KEY IDENTITY(1,1),
    idVenta INT,
    idProducto INT,
    cantidad INT,
    precioUnitario DECIMAL(10,2),
    idUnidadMedida INT,
    fechaDetalle DATE,
    FOREIGN KEY (idVenta) REFERENCES Venta(idVenta),
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto),
    FOREIGN KEY (idUnidadMedida) REFERENCES UnidadMedida(idUnidadMedida)
);
-- Tabla HistorialServicio
CREATE TABLE HistorialServicio (
    idHistorial INT PRIMARY KEY IDENTITY(1,1),
    idCarro INT,
    idServicio INT,
    idTaller INT,
    fechaRealizacion DATE,
    observaciones NVARCHAR(200),
    FOREIGN KEY (idCarro) REFERENCES Carro(idCarro),
    FOREIGN KEY (idServicio) REFERENCES Servicio(idServicio),
    FOREIGN KEY (idTaller) REFERENCES Taller(idTaller)
);
