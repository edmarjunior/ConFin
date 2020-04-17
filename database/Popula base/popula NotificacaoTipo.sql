-- POPULA BASE TABELA [NotificacaoTipo]
USE confin

DECLARE @DataAtual datetime = GETDATE()

INSERT INTO NotificacaoTipo(Id, Descricao, DataCadastro) 
	VALUES (1, 'Convite para conta conjunta', @DataAtual),
		   (2, 'Aceita��o de convite para conta conjunta', @DataAtual),
		   (3, 'Recuso de convite para conta conjunta', @DataAtual),
		   (4, 'Cadastro de lan�amento em conta conjunta', @DataAtual),
		   (5, 'Edi��o de lan�amento em conta conjunta', @DataAtual),
		   (6, 'Remo��o de lan�amento em conta conjunta', @DataAtual),
		   (7, 'Cadastro de transfer�ncia em conta conjunta', @DataAtual),
		   (8, 'Edi��o de transfer�ncia em conta conjunta', @DataAtual),
		   (9, 'Remo��o de transfer�ncia em conta conjunta', @DataAtual),
		   (10, 'Cancelamento de compartilhamento de conta conjunta', @DataAtual)