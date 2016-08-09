-- Database: postgres

-- DROP DATABASE postgres;

CREATE DATABASE postgres
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Portuguese_Brazil.1252'
       LC_CTYPE = 'Portuguese_Brazil.1252'
       CONNECTION LIMIT = -1;

COMMENT ON DATABASE postgres
  IS 'default administrative connection database';

-- Table: public.material

-- DROP TABLE public.material;

CREATE TABLE public.material
(
  cd_material character varying(20) NOT NULL,
  ds_material character varying(50),
  CONSTRAINT pk_cd_material PRIMARY KEY (cd_material)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.material
  OWNER TO postgres;

-- Table: public.loja

-- DROP TABLE public.loja;

CREATE TABLE public.loja
(
  cd_loja character varying(4) NOT NULL,
  localneg character varying(4),
  municipio character varying(24),
  uf_loja character varying(2),
  orgvenda double precision,
  bandeira character varying(19),
  canaldistribuicao integer,
  tipo character varying(8),
  CONSTRAINT pk_loja PRIMARY KEY (cd_loja)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.loja
  OWNER TO postgres;

-- Table: public.setor_industrial

-- DROP TABLE public.setor_industrial;

CREATE TABLE public.setor_industrial
(
	id_setor varchar(5) NOT NULL,
	ds_setor varchar(50) NULL,
 CONSTRAINT pk_idsetor PRIMARY KEY (id_setor)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.setor_industrial
  OWNER TO postgres;

-- Table: public.fornecedor

-- DROP TABLE public.fornecedor;

CREATE TABLE public.fornecedor
(
  cd_fornecedor character varying(10) NOT NULL,
  nu_cnpj character varying(20),
  nu_cpf character varying(11),
  ds_razaosocial character varying(50),
  id_setor character varying(5),
  uf_fornecedor character varying(3),
  CONSTRAINT pk_cdfornecedor PRIMARY KEY (cd_fornecedor),
  CONSTRAINT fk_idsetor FOREIGN KEY (id_setor)
      REFERENCES public.setor_industrial (id_setor) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.fornecedor
  OWNER TO postgres;

-- Table: public.cfop

-- DROP TABLE public.cfop;

CREATE TABLE public.cfop
(
  cd_cfop character varying(10) NOT NULL,
  desc_cfop character varying(50),
  CONSTRAINT pk_cfop PRIMARY KEY (cd_cfop)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.cfop
  OWNER TO postgres;

-- Table: public.categoria_notafiscal

-- DROP TABLE public.categoria_notafiscal;

CREATE TABLE public.categoria_notafiscal
(
  sg_categoria character varying(2) NOT NULL,
  ds_categoria character varying(40) NOT NULL,
  CONSTRAINT pk_sg_categoria PRIMARY KEY (sg_categoria)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.categoria_notafiscal
  OWNER TO postgres;

-- Table: public.nota_fiscal

-- DROP TABLE public.nota_fiscal;

CREATE TABLE public.nota_fiscal
(
  nu_docsap character varying(20) NOT NULL,
  cd_centro character varying(4) NOT NULL,
  nu_notafiscal character varying(20),
  nu_serie character varying(5),
  sg_categoria character varying(2),
  dt_lancamento date,
  cd_parceiro character varying(10),
  CONSTRAINT pk_docsap PRIMARY KEY (nu_docsap),
  CONSTRAINT fk_sg_categoria FOREIGN KEY (sg_categoria)
      REFERENCES public.categoria_notafiscal (sg_categoria) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.nota_fiscal
  OWNER TO postgres;

-- Table: public.item_notafiscal

-- DROP TABLE public.item_notafiscal;

CREATE TABLE public.item_notafiscal
(
  id integer NOT NULL DEFAULT nextval('item_notafiscal_id_seq'::regclass),
  nu_doc character varying(20) NOT NULL,
  nu_pedido character varying(20),
  cd_material character varying(20),
  nu_origem integer,
  iva character varying(20),
  ncm character varying(20),
  cst_icms character varying(20),
  qt_embalagembasica integer,
  un_medidasap character varying(5),
  qt_notafiscal double precision,
  vlr_precototalnota double precision,
  vlr_aliquotaicms double precision,
  vlr_basecofins double precision,
  vlr_cofins double precision,
  vlr_basepis double precision,
  vlr_pis double precision,
  vlr_ipi double precision,
  vlr_baseipi double precision,
  vlr_icms double precision,
  vlr_subtrib double precision,
  vlr_antecintegral double precision,
  vlr_estornoicms character varying(10),
  vlr_desconto double precision,
  vlr_despesas double precision,
  vlr_impimportacao double precision,
  vlr_difaliq double precision,
  cd_cfop character varying(10),
  vlr_aliquotacofins double precision,
  vlr_aliquotapis double precision,
  CONSTRAINT pk_id PRIMARY KEY (id),
  CONSTRAINT fk_nu_docsap FOREIGN KEY (nu_docsap)
      REFERENCES public.nota_fiscal (nu_docsap) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
 CONSTRAINT fk_cd_cfop FOREIGN KEY (cd_cfop)
      REFERENCES public.cfop (cd_cfop) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.item_notafiscal
  OWNER TO postgres;