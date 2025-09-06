CREATE DATABASE InfoBIbliografica

use InfoBIbliografica

-- crear tabla de VOLUMEN
CREATE TABLE Volumen(
		Id int IDENTITY NOT NULL,
		CONSTRAINT PK_Volumen_Id PRIMARY KEY (Id),
		Numero varchar (20) NOT NULL,
)
--Crear los indices de la tabla VOLUMEN
CREATE UNIQUE INDEX Ix_Volumen_Numero
	ON Volumen(Numero)

-- crear tabla de TIPO
CREATE TABLE Tipo(
		Id int IDENTITY NOT NULL,
		CONSTRAINT PK_Tipo_Id PRIMARY KEY (Id),
		Nombre varchar (50) NOT NULL,
)
--Crear los indices de la tabla TIPO
CREATE UNIQUE INDEX Ix_Tipo_Nombre
	ON Tipo(Nombre)

-- crear tabla de Descriptor
CREATE TABLE Descriptor(
		Id int IDENTITY NOT NULL,
		CONSTRAINT PK_Descriptor_Id PRIMARY KEY (Id),
		Nombre nvarchar (100) NOT NULL,
)
--Crear los indices de la tabla Descriptor
CREATE UNIQUE INDEX Ix_Descriptor_Nombre
	ON Descriptor(Nombre)





-- crear la  tabla PAIS (se incluyte el nvarchar para añadir tildes y demas)
CREATE TABLE Pais(
	Id int IDENTITY NOT NULL,
	CONSTRAINT PK_Pais_Id PRIMARY KEY (Id),
	Nombre nvarchar (50) NOT NULL,
	CodigoAlfa varchar (5) NOT NULL, 
	Indicativo int NULL

	)
	
-- crear los indices de la tabla PAIS
CREATE UNIQUE INDEX Ix_Pais_Nombre
	ON Pais(Nombre)

CREATE UNIQUE INDEX Ix_Pais_CodigoAlfa
	ON Pais(CodigoAlfa)

CREATE UNIQUE INDEX Ix_Pais_Indicativo
	ON Pais(Indicativo)


-- crear la tabla CIUDAD
CREATE TABLE Ciudad(
    Id INT IDENTITY NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    IdPais INT NOT NULL,
    CONSTRAINT PK_Ciudad_Id PRIMARY KEY (Id),
    CONSTRAINT FK_Ciudad_Pais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)

-- Crear los índices de la tabla CIUDAD
CREATE UNIQUE INDEX Ix_Ciudad_NombrePais
    ON Ciudad(Nombre, IdPais)

-- crear la tabla EDITORIAL
CREATE TABLE Editorial(
    Id INT IDENTITY NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    IdPais INT NOT NULL,
    CONSTRAINT PK_Editorial_Id PRIMARY KEY (Id),
    CONSTRAINT FK_Editorial_Pais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)

-- Crear los índices de la tabla EDITORIAL
CREATE UNIQUE INDEX Ix_Editorial_Nombre
    ON Editorial(Nombre);

-- crear la tabla AUTOR
CREATE TABLE Autor(
    Id INT IDENTITY NOT NULL,
    Nombre NVARCHAR(50) NOT NULL,
    IdPais INT NOT NULL, -- Nacionalidad
    CONSTRAINT PK_Autor_Id PRIMARY KEY (Id),
    CONSTRAINT FK_Autor_Pais FOREIGN KEY (IdPais) REFERENCES Pais(Id))


-- Crear índice De AUTOR
CREATE UNIQUE INDEX Ix_Autor_NombrePais
ON Autor(Nombre, IdPais);
GO








-- crear la tabla PUBLICACION
CREATE TABLE Publicacion(
    Id INT IDENTITY NOT NULL,
    Titulo NVARCHAR(150) NOT NULL,
    Anio INT NOT NULL,
    Descripcion NVARCHAR(500) NULL,
    IdEditorial INT NOT NULL,
    CONSTRAINT PK_Publicacion_Id PRIMARY KEY (Id),
    CONSTRAINT FK_Publicacion_Editorial FOREIGN KEY (IdEditorial) REFERENCES Editorial(Id)
)

-- Crear índice para mejorar búsquedas por título
CREATE INDEX Ix_Publicacion_Titulo
    ON Publicacion(Titulo)


-- relacion m:n  8tablas intermedias)--------------------------------------------------



-- Relación entre Publicacion y Volumen
CREATE TABLE PublicacionVolumen(
    IdPublicacion INT NOT NULL,
    IdVolumen INT NOT NULL,
    CONSTRAINT PK_PublicacionVolumen PRIMARY KEY (IdPublicacion, IdVolumen),
    CONSTRAINT FK_PublicacionVolumen_Publicacion FOREIGN KEY (IdPublicacion) REFERENCES Publicacion(Id),
    CONSTRAINT FK_PublicacionVolumen_Volumen FOREIGN KEY (IdVolumen) REFERENCES Volumen(Id)
)

-- Relación entre Publicacion y Tipo
CREATE TABLE PublicacionTipo(
    IdPublicacion INT NOT NULL,
    IdTipo INT NOT NULL,
    CONSTRAINT PK_PublicacionTipo PRIMARY KEY (IdPublicacion, IdTipo),
    CONSTRAINT FK_PublicacionTipo_Publicacion FOREIGN KEY (IdPublicacion) REFERENCES Publicacion(Id),
    CONSTRAINT FK_PublicacionTipo_Tipo FOREIGN KEY (IdTipo) REFERENCES Tipo(Id)
)

-- Relación entre Publicacion y Autor
CREATE TABLE PublicacionAutor(
    IdPublicacion INT NOT NULL,
    IdAutor INT NOT NULL,
    CONSTRAINT PK_PublicacionAutor PRIMARY KEY (IdPublicacion, IdAutor),
    CONSTRAINT FK_PublicacionAutor_Publicacion FOREIGN KEY (IdPublicacion)
        REFERENCES Publicacion(Id),
    CONSTRAINT FK_PublicacionAutor_Autor FOREIGN KEY (IdAutor)
        REFERENCES Autor(Id)
)

-- Relación entre Publicacion y Descriptor
CREATE TABLE PublicacionDescriptor(
    IdPublicacion INT NOT NULL,
    IdDescriptor INT NOT NULL,
    CONSTRAINT PK_PublicacionDescriptor PRIMARY KEY (IdPublicacion, IdDescriptor),
    CONSTRAINT FK_PublicacionDescriptor_Publicacion FOREIGN KEY (IdPublicacion) REFERENCES Publicacion(Id),
    CONSTRAINT FK_PublicacionDescriptor_Descriptor FOREIGN KEY (IdDescriptor) REFERENCES Descriptor(Id)
)

