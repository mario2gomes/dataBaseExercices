Questão 1:

CREATE TRIGGER Trg_atu_saldo_prod_movim
	AFTER INSERT
ON T_MOV_PRODUTO
FOR EACH ROW
BEGIN
FROM T_MOV_produto m, T_produto p
	IF m.TIP_MOVIM == 'E' THEN
		update p set p.SALDO_ESTOQUE = p.SALDO_ESTOQUE + m.QTD_MOVIM
		WHERE p.COD_PRODUTO = m.COD_PRODUTO
	END IF;
	IF m.TIP_MOVIM == 'S' THEN
		update p set p.SALDO_ESTOQUE = p.SALDO_ESTOQUE - m.QTD_MOVIM
		WHERE p.COD_PRODUTO = m.COD_PRODUTO
	END IF;
END Trg_atu_saldo_prod_movim;



Questão 2:

CREATE TRIGGER Trg_log_movim
	AFTER INSERT
	OR DELETE
	OR UPDATE OF TIP_MOVIM
ON T_MOV_PRODUTO
FOR EACH ROW
BEGIN
FROM T_MOV_produto m, T_produto p
		IF INSERTING THEN
			INSERT INTO T_LOG_MOVIM
				(Seq_movim,
				Cod_produto,
				Tipo_operacao,
				Dat_operacao,
				Usuario,
				Qtde_anter,
				Qtde_atual)
			VALUES (Seq_movim.NEXTVAL,
				m.Cod_produto,
				'I',
				SYSDATE,
				MATR_FUNC_MOV,
				:OLD.p.SALDO_ESTOQUE,
				:NEW.p.SALDO_ESTOQUE
				)
		END IF;
		IF DELETING THEN
			INSERT INTO T_LOG_MOVIM
				(Seq_movim,
				Cod_produto,
				Tipo_operacao,
				Dat_operacao,
				Usuario,
				Qtde_anter,
				Qtde_atual)
			VALUES (Seq_movim.NEXTVAL,
				m.Cod_produto,
				'D',
				SYSDATE,
				MATR_FUNC_MOV,
				:OLD.p.SALDO_ESTOQUE,
				:NEW.p.SALDO_ESTOQUE
				)
		END IF
		IF UPDATING THEN
			INSERT INTO T_LOG_MOVIM
				(Seq_movim,
				Cod_produto,
				Tipo_operacao,
				Dat_operacao,
				Usuario,
				Qtde_anter,
				Qtde_atual)
			VALUES (Seq_movim.NEXTVAL,
				m.Cod_produto,
				'U',
				SYSDATE,
				MATR_FUNC_MOV,
				:OLD.p.SALDO_ESTOQUE,
				:NEW.p.SALDO_ESTOQUE
				)			
		END IF
END Trg_log_movim;



Questão 3:

CREATE TRIGGER Trg_atu_saldo_prod_nota
	AFTER INSERT
ON T_NOTA_FISCAL
FOR EACH ROW
BEGIN
FROM T_NOTA_FISCAL n, T_ITEM_NF i, T_produto p
		update p set p.SALDO_ESTOQUE = p.SALDO_ESTOQUE + i.QTDE
		WHERE p.COD_PRODUTO = i.COD_PRODUTO AND i.NUM_NF = n.NUM_NF
END Trg_atu_saldo_prod_nota;