
USE conFin

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_InsSolicitacaoTrocaSenhaLogin]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[SP_InsSolicitacaoTrocaSenhaLogin]
GO

CREATE PROCEDURE [dbo].[SP_InsSolicitacaoTrocaSenhaLogin]
	@IdUsuario	int,
	@Token		varchar(100)

	AS

	/*
	Documenta��o
	Arquivo Fonte.....: Usuario.sql
	Objetivo..........: Insere uma solicita��o de troca de senha de acesso para o usuario  
	Autor.............: Edmar Costa
 	Data..............: 07/08/2017
	Ex................: BEGIN TRANSACTION
						DECLARE @Ret int
						EXEC @Ret = [dbo].[SP_InsSolicitacaoTrocaSenhaLogin] 5, 'tokenTeste123'
						SELECT @Ret
						ROLLBACK TRANSACTION
	*/

	BEGIN

		INSERT INTO LoginSolicitacaoTrocaSenha(IdUsuario, Token, DataCadastro) 
			VALUES (@IdUsuario, @Token, GETDATE())

	END
GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_SelSolicitacaoTrocaSenhaLogin]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[SP_SelSolicitacaoTrocaSenhaLogin]
GO

CREATE PROCEDURE [dbo].[SP_SelSolicitacaoTrocaSenhaLogin]
	@IdUsuario	int,
	@Token		varchar(100)

	AS

	/*
	Documenta��o
	Arquivo Fonte.....: Usuario.sql
	Objetivo..........: Retorna os dados a solicita��o de troca de senha cadastrada na base   
	Autor.............: Edmar Costa
 	Data..............: 07/08/2017
	Ex................: BEGIN TRANSACTION
						DECLARE @Ret int
						EXEC @Ret = [dbo].[SP_SelSolicitacaoTrocaSenhaLogin] 5, 'tokenTeste123'
						SELECT @Ret
						ROLLBACK TRANSACTION
	*/

	BEGIN

		SELECT  IdUsuario,
				Token,
				DataCadastro,
				DataUsuarioConfirmacao
			FROM LoginSolicitacaoTrocaSenha WITH(NOLOCK)
			WHERE IdUsuario = @IdUsuario
				AND Token = @Token

	END
GO




IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_UpdSolicitacaoTrocaSenhaLogin]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[SP_UpdSolicitacaoTrocaSenhaLogin]
GO

CREATE PROCEDURE [dbo].[SP_UpdSolicitacaoTrocaSenhaLogin]
	@IdUsuario	int,
	@Token		varchar(100)

	AS

	/*
	Documenta��o
	Arquivo Fonte.....: Usuario.sql
	Objetivo..........: Altera a data de confirma��o da solicita��o de troca de senha de acesso do usu�rio   
	Autor.............: Edmar Costa
 	Data..............: 07/08/2017
	Ex................: BEGIN TRANSACTION
						DECLARE @Ret int
						EXEC @Ret = [dbo].[SP_UpdSolicitacaoTrocaSenhaLogin] 5, 'tokenTeste123'
						SELECT @Ret
						ROLLBACK TRANSACTION
	*/

	BEGIN

		UPDATE LoginSolicitacaoTrocaSenha 
			SET DataUsuarioConfirmacao = GETDATE()
			WHERE IdUsuario = @IdUsuario 
				AND Token = @Token

	END
GO