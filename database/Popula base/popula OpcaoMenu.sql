-- POPULA BASE TABELA [Periodo]
USE confin

DECLARE @Dat_Atual datetime = GETDATE()

INSERT INTO OpcaoMenu(Codigo, CodigoMae, Descricao, DataCadastro, Uri) 
	VALUES (1, NULL, 'Home', @Dat_Atual, 'Home/Home'),
		   (2, NULL, 'Contas Financeiras', @Dat_Atual, 'ContaFinanceira/ContaFinanceira'),
		   (3, NULL, 'Lancamentos', @Dat_Atual, 'Lancamento/Lancamento'),
		   (4, NULL, 'Categorias Lan�amento', @Dat_Atual, 'LancamentoCategoria/LancamentoCategoria'),
		   (5, NULL, 'Transfer�ncias', @Dat_Atual, 'Transferencia/Transferencia'),
		   (6, NULL, 'Convites Conta Conjunta', @Dat_Atual, 'ContaConjunta/ContaConjunta'),
		   (7, NULL, 'Relat�rios', @Dat_Atual, NULL),
		   (8, 7, 'Lan�amentos', @Dat_Atual, 'RelLancamento/RelLancamento')
