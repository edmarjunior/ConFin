USE confin

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[FNC_PegaTotalNotificacaoNaoLida]') AND objectproperty(id, N'IsScalarFunction')=1)
	DROP FUNCTION [dbo].[FNC_PegaTotalNotificacaoNaoLida]
GO 

CREATE FUNCTION [dbo].[FNC_PegaTotalNotificacaoNaoLida]
	(@IdUsuario int)

	RETURNS int

	AS

	/*
		Documenta��o
		Objetivo..........:	Pega o total de notifica��es que ainda n�o foram lidas pelo usu�rio
		Autor.............:	Edmar Costa
 		Data..............:	14/10/2017
		Exemplo...........: SELECT [dbo].[FNC_PegaTotalNotificacaoNaoLida](9002)

	*/

	BEGIN
		
		DECLARE @Tot int

		 SELECT @Tot = COUNT(*) 
			FROM Notificacao WITH(NOLOCK)
			WHERE IdUsuarioDestino = @IdUsuario
				AND DataLeitura IS NULL

		RETURN ISNULL(@Tot, 0)
		
	END
GO


