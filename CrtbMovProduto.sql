 drop table t_departamento;
 CREATE TABLE T_DEPARTAMENTO
(COD_DEPTO number(3) PRIMARY KEY ,             /* pk, fk para funcionario*/
Nome_DEPTO varchar2(30)
 );

drop table t_func;
CREATE TABLE T_FUNC
(MATR_FUNC NUMBER(05),
 Nome varchar2(30),
 CPF number(11),         -- unique
 Sexo char (1) ,               /* checar M ou F */
 cod_depto number(3),
 CONSTRAINT PK_FUNC PRIMARY KEY (MATR_FUNC),
 CONSTRAINT CK_FUNC_SEXO CHECK (SEXO IN  ('M' , 'F')),
 constraint fk_func_depto foreign key (cod_depto)
                 references t_departamento (cod_depto)
 ); 
 
 DROP TABLE T_DEPENDENTE;
 CREATE TABLE T_DEPENDENTE
(Matr_func number(5) ,             /* pk, fk para funcionario*/
Cod_depend number(3),          -- pk
Nome_depend varchar2(30),
Dt_nasc DATE,
Sexo char(1) CHECK (SEXO IN ('M','F')),
 CONSTRAINT PK_depend PRIMARY KEY (MATR_FUNC, COD_DEPEND),
 constraint fk_depend_func foreign key (matr_func)
               references t_func (matr_func)
 );

INSERT INTO T_DEPARTAMENTO VALUES (1, 'INFORMÁTICA')
INSERT INTO T_FUNC VALUES (10, 'JOSE', 999, 'm')
