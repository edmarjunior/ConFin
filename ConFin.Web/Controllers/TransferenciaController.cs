﻿using ConFin.Application.AppService.ContaFinanceira;
using ConFin.Application.AppService.LancamentoCategoria;
using ConFin.Application.AppService.Transferencia;
using ConFin.Common.Domain.Dto;
using ConFin.Common.Web;
using ConFin.Web.ViewModel;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace ConFin.Web.Controllers
{
    public class TransferenciaController: BaseController
    {
        private readonly ITransferenciaAppService _transferenciaAppService;
        private readonly ILancamentoCategoriaAppService _lancamentoCategoriaAppService;
        private readonly IContaFinanceiraAppService _contaFinanceiraAppService;

        public TransferenciaController(ITransferenciaAppService transferenciaAppService, IContaFinanceiraAppService contaFinanceiraAppService, ILancamentoCategoriaAppService lancamentoCategoriaAppService)
        {
            _transferenciaAppService = transferenciaAppService;
            _contaFinanceiraAppService = contaFinanceiraAppService;
            _lancamentoCategoriaAppService = lancamentoCategoriaAppService;
        }

        public ActionResult Transferencia()
        {
            try
            {
                var response = _transferenciaAppService.Get(UsuarioLogado.Id);
                if (!response.IsSuccessStatusCode)
                    return Error(response);

                var contas = JsonConvert.DeserializeObject<IEnumerable<TransferenciaDto>>(response.Content.ReadAsStringAsync().Result);
                return View("Transferencia", contas.Select(x => new TransferenciaViewModel(x)));
            }
            catch (Exception ex)
            {
                return Error(ex.Message);
            }
        }

        public ActionResult GetModalCadastroEdicao(int? idTransferencia)
        {
            try
            {
                // combo de Contas
                var responseConta = _contaFinanceiraAppService.GetAll(UsuarioLogado.Id);
                if (!responseConta.IsSuccessStatusCode)
                    return Error(responseConta);

                var contas = JsonConvert.DeserializeObject<IEnumerable<ContaFinanceiraDto>>(responseConta.Content.ReadAsStringAsync().Result).ToList();
                if (!contas.Any())
                    return Error("Não foi encontrada nenhuma Conta para cadastrar o lançamento");

                // combo de Categorias de lançamento
                var responseCategoria = _lancamentoCategoriaAppService.Get(UsuarioLogado.Id);
                if (!responseCategoria.IsSuccessStatusCode)
                    return Error(responseCategoria);

                var categorias = JsonConvert.DeserializeObject<IEnumerable<LancamentoCategoriaDto>>(responseCategoria.Content.ReadAsStringAsync().Result).ToList();
                if (!categorias.Any())
                    return Error("Não foi encontrada nenhuma Categoria para cadastrar o lançamento");

                // cadastro
                if (!idTransferencia.HasValue)
                {
                    ViewBag.IndicadorCadastro = "S";

                    return View("_ModalCadastroEdicaoTransferencia", new TransferenciaViewModel()
                    {
                        ContasFinanceira = contas,
                        Categorias = categorias
                    });
                }

                // alteração
                ViewBag.IndicadorCadastro = "N";

                var response = _transferenciaAppService.Get((int) idTransferencia);
                if (!response.IsSuccessStatusCode)
                    return Error(response);

                var transferenciaDto = JsonConvert.DeserializeObject<TransferenciaDto>(response.Content.ReadAsStringAsync().Result);
                return View("_ModalCadastroEdicaoTransferencia", new TransferenciaViewModel(transferenciaDto)
                {
                    ContasFinanceira = contas,
                    Categorias = categorias
                });
            }
            catch (Exception ex)
            {
                return Error(ex.Message);
            }
        }

        public ActionResult Post(TransferenciaDto transferencia)
        {
            try
            {
                transferencia.IdUsuarioCadastro = UsuarioLogado.Id;
                var response = _transferenciaAppService.Post(transferencia);
                return response.IsSuccessStatusCode ? Ok("Transferência cadastrada com sucesso") : Error(response);
            }
            catch (Exception ex)
            {
                return Error(ex.Message);
            }
        }

        public ActionResult Put(TransferenciaDto transferencia)
        {
            try
            {
                transferencia.IdUsuarioUltimaAlteracao = UsuarioLogado.Id;
                var response = _transferenciaAppService.Put(transferencia);
                return response.IsSuccessStatusCode ? Ok("Transferência editada com sucesso") : Error(response);
            }
            catch (Exception ex)
            {
                return Error(ex.Message);
            }
        }

        public ActionResult Delete(int idTransferencia)
        {
            try
            {
                var response = _transferenciaAppService.Delete(idTransferencia);
                return response.IsSuccessStatusCode ? Ok("Transferência excluida com sucesso") : Error(response);
            }
            catch (Exception ex)
            {
                return Error(ex.Message);
            }
        }

        public ActionResult PutIndicadorPagoRecebido(TransferenciaDto transferencia)
        {
            try
            {
                transferencia.IdUsuarioUltimaAlteracao = UsuarioLogado.Id;
                var response = _transferenciaAppService.PutIndicadorPagoRecebido(transferencia);
                return response.IsSuccessStatusCode ? Ok() : Error(response);
            }
            catch (Exception ex)
            {
                return Error(ex.Message);
            }
        }
    }
}