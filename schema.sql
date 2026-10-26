CREATE DATABASE IF NOT EXISTS workguard_db;
USE workguard_db;


CREATE TABLE CATALOGO_ALCALDIA_FISCAL (
    id_alcaldia_fiscal INT NOT NULL AUTO_INCREMENT,
    opcion_alcaldia VARCHAR(120) NOT NULL,
    PRIMARY KEY (id_alcaldia_fiscal)
);

CREATE TABLE CATALOGO_ENTIDAD_FEDERATIVA_FISCAL (
    id_entidad_federativa_fiscal INT NOT NULL AUTO_INCREMENT,
    opcion_entidad_federativa VARCHAR(120) NOT NULL,
    PRIMARY KEY (id_entidad_federativa_fiscal)
);

CREATE TABLE CATALOGO_GIRO (
    id_giro INT NOT NULL AUTO_INCREMENT,
    opcion_giro VARCHAR(150) NOT NULL,
    PRIMARY KEY (id_giro)
);

INSERT INTO CATALOGO_GIRO (opcion_giro) VALUES
('Servicios de Tec / soporte empresarial'),
('Almacenamiento / refrigeración industrial de alimentos'),
('venta de blancos/ Diseño'),
('Distribución seguridad electrónica / telecomunicaciones'),
('Distribución Tec'),
('Equipamiento cocinas comerciales'),
('Manufactura de tapas y corcholatas'),
('Manufactura Textil'),
('Manufactura uniformes'),
('Manufactura/ distribución de abrasivos'),
('Tec'),
('Comercio de materiales para construcción'),
('Restaurante'),
('Servicios contables'),
('Comercio de ferretería y material eléctrico'),
('Comercio'),
('Servicios de transporte /publicidad'),
('Servicios de consultoría administrativa'),
('Servicios de Investigación de mercados'),
('Construcción de obra civil'),
('Servicios de catering y banquetes'),
('Servicios aduanales y arrendamiento de oficinas'),
('Comercialización textil'),
('Servicios deportivos'),
('Servicios de consultoría comercial/Servicios de consultoría administrativa'),
('Servicios profesionales y técnicos'),
('Servicios de publicidad'),
('Servicios comercio exterior');

CREATE TABLE CATALOGO_TAMANO (
    id_catalogo_tamano INT NOT NULL AUTO_INCREMENT,
    opcion_tamano_empresa VARCHAR(120) NOT NULL,
    PRIMARY KEY (id_catalogo_tamano)
);



CREATE TABLE CATALOGO_ALCALDIA_OPERACIONES (
    id_alcaldia_operaciones INT NOT NULL AUTO_INCREMENT,
    opcion_alcaldia VARCHAR(120) NOT NULL,
    PRIMARY KEY (id_alcaldia_operaciones)
);

CREATE TABLE CATALOGO_ENTIDAD_OPERACIONES (
    id_entidad_federativa_operaciones INT NOT NULL AUTO_INCREMENT,
    opcion_entidad_federativa VARCHAR(120) NOT NULL,
    PRIMARY KEY (id_entidad_federativa_operaciones)
);



CREATE TABLE CABECERA_TARJETA (
    id_tarjeta INT NOT NULL AUTO_INCREMENT,
    imagen BLOB,
    PRIMARY KEY (id_tarjeta)
);

CREATE TABLE REPRESENTANTE (
    id_representante INT NOT NULL AUTO_INCREMENT,
    nombre_completo VARCHAR(180) NOT NULL,
    curp VARCHAR(18) NOT NULL,
    id_tarjeta INT,
    PRIMARY KEY (id_representante),
    CONSTRAINT fk_representante_tarjeta 
        FOREIGN KEY (id_tarjeta) REFERENCES CABECERA_TARJETA(id_tarjeta) 
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE ACTIVIDAD (
    id_actividad INT NOT NULL AUTO_INCREMENT,
    facebook VARCHAR(255),
    instagram VARCHAR(255),
    twitter VARCHAR(255),
    pagina_web VARCHAR(255),
    PRIMARY KEY (id_actividad)
);


CREATE TABLE DOMICILIO_FISCAL (
    id_domicilio_fiscal INT NOT NULL AUTO_INCREMENT,
    codigo_postal VARCHAR(5) NOT NULL,
    calle VARCHAR(150) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    id_alcaldia_fiscal INT NOT NULL,
    id_entidad_federativa_fiscal INT NOT NULL,
    PRIMARY KEY (id_domicilio_fiscal),
    CONSTRAINT fk_dom_fiscal_alcaldia 
        FOREIGN KEY (id_alcaldia_fiscal) REFERENCES CATALOGO_ALCALDIA_FISCAL(id_alcaldia_fiscal) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_dom_fiscal_entidad 
        FOREIGN KEY (id_entidad_federativa_fiscal) REFERENCES CATALOGO_ENTIDAD_FEDERATIVA_FISCAL(id_entidad_federativa_fiscal) 
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE DOMICILIO_OPERACIONES (
    id_domicilio_operaciones INT NOT NULL AUTO_INCREMENT,
    codigo_postal VARCHAR(5) NOT NULL,
    calle VARCHAR(150) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    id_alcaldia_operaciones INT NOT NULL,
    id_entidad_federativa_operaciones INT NOT NULL,
    PRIMARY KEY (id_domicilio_operaciones),
    CONSTRAINT fk_dom_operaciones_alcaldia 
        FOREIGN KEY (id_alcaldia_operaciones) REFERENCES CATALOGO_ALCALDIA_OPERACIONES(id_alcaldia_operaciones) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_dom_operaciones_entidad 
        FOREIGN KEY (id_entidad_federativa_operaciones) REFERENCES CATALOGO_ENTIDAD_OPERACIONES(id_entidad_federativa_operaciones) 
        ON DELETE RESTRICT ON UPDATE CASCADE
);



CREATE TABLE EXISTENCIA_FISCAL (
    id_existencia_fiscal INT NOT NULL AUTO_INCREMENT,
    nombre_comercial VARCHAR(150) NOT NULL,
    representante_legal VARCHAR(150) NOT NULL,
    rfc VARCHAR(13) NOT NULL,
    id_giro INT NOT NULL,
    id_domicilio_fiscal INT NOT NULL,
    PRIMARY KEY (id_existencia_fiscal),
    CONSTRAINT fk_existencia_giro 
        FOREIGN KEY (id_giro) REFERENCES CATALOGO_GIRO(id_giro) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_existencia_dom_fiscal 
        FOREIGN KEY (id_domicilio_fiscal) REFERENCES DOMICILIO_FISCAL(id_domicilio_fiscal) 
        ON DELETE RESTRICT ON UPDATE CASCADE
);



CREATE TABLE MIPYME (
    id_mipyme INT NOT NULL AUTO_INCREMENT,
    nombre_comercial VARCHAR(150) NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    tipo_persona ENUM('FISICA', 'MORAL') NOT NULL,
    numero_trabajadores INT NOT NULL,
    id_existencia_fiscal INT NOT NULL,
    id_actividad INT,
    id_domicilio_operaciones INT,
    id_representante INT,
    id_tamano INT,
    PRIMARY KEY (id_mipyme),
    CONSTRAINT fk_mipyme_existencia_fiscal 
        FOREIGN KEY (id_existencia_fiscal) REFERENCES EXISTENCIA_FISCAL(id_existencia_fiscal) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_mipyme_actividad 
        FOREIGN KEY (id_actividad) REFERENCES ACTIVIDAD(id_actividad) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_mipyme_dom_operaciones 
        FOREIGN KEY (id_domicilio_operaciones) REFERENCES DOMICILIO_OPERACIONES(id_domicilio_operaciones) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_mipyme_representante 
        FOREIGN KEY (id_representante) REFERENCES REPRESENTANTE(id_representante) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_mipyme_tamano 
        FOREIGN KEY (id_tamano) REFERENCES CATALOGO_TAMANO(id_catalogo_tamano) 
        ON DELETE SET NULL ON UPDATE CASCADE
);