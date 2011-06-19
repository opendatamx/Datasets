DROP TABLE provedores;
DROP SEQUENCE provedores_sec;
CREATE SEQUENCE provedores_sec;
CREATE TABLE provedores (
	id		integer		NOT NULL
				DEFAULT nextval('provedores_sec') primary key,
	razon_social	varchar(255)	NOT NULL,
	rfc		varchar(20)	NULL,
	domicilio	varchar(512)	NULL,
	telefono	varchar(50)	NULL,
	fax		varchar(50)	NULL,
	email		varchar(100)	NULL,
	objeto_social	text		NULL
);
CREATE INDEX IN_PROVEDORES_RAZON_SOCIAL	ON provedores(razon_social);

DROP TABLE instituciones;
DROP SEQUENCE instituciones_seq;
CREATE SEQUENCE instituciones_seq;
CREATE TABLE instituciones (
	id              integer         NOT NULL
                                DEFAULT nextval('instituciones_seq') primary key,
	nombre		varchar(255)	NOT NULL
);

DROP TABLE licitaciones;
DROP SEQUENCE licitaciones_seq;
CREATE SEQUENCE licitaciones_seq;
CREATE TABLE licitaciones (
	id              integer         NOT NULL
                                DEFAULT nextval('licitaciones_seq') primary key,
	provedor	integer	NOT NULL references provedores(id),
	institucion	integer	NULL references instituciones(id),
	no_licencias	integer	NOT NULL default(1),
	descriptcion	varchar(1024) 	NULL,
	monto		decimal(20,2)	NULL,
	fecha_inicio	timestamp	NULL,
	fecha_fin	timestamp	NULL
);
CREATE INDEX IN_LICITACIONES_INSTITUCION ON licitaciones(institucion);
CREATE INDEX IN_LICITACIONES_FECHA_INICIO ON licitaciones(fecha_inicio);
CREATE INDEX IN_LICITACIONES_FECHA_FIN	ON licitaciones(fecha_fin);

CREATE VIEW v_licitaciones AS
SELECT licitaciones.*, instituciones.nombre, provedores.razon_social, provedores.rfc, provedores.domicilio, provedores.telefono, provedores.fax, provedores.email, provedores.objeto_social
FROM licitaciones, instituciones, provedores
WHERE licitaciones.institucion = instituciones.id 
AND licitaciones.provedor = provedores.id;

