﻿using ConFin.Common.Domain;
using ConFin.Common.Domain.Dto;
using ConFin.Domain.ContaFinanceira;
using System.Net;
using System.Web.Http;

namespace ConFin.Api.Controllers
{
    public class ContaFinanceiraController: ApiController
    {
        private readonly IContaFinanceiraRepository _contaFinanceiraRepository;
        private readonly IContaFinanceiraService _contaFinanceiraService;
        private readonly Notification _notification;

        public ContaFinanceiraController(Notification notification, IContaFinanceiraService contaFinanceiraService, IContaFinanceiraRepository contaFinanceiraRepository)
        {
            _notification = notification;
            _contaFinanceiraService = contaFinanceiraService;
            _contaFinanceiraRepository = contaFinanceiraRepository;
        }

        public IHttpActionResult GetAll(int idUsuario) => Ok(_contaFinanceiraRepository.GetAll(idUsuario));

        public IHttpActionResult Get(int idConta) => Ok(_contaFinanceiraRepository.Get(idConta));

        public IHttpActionResult Post(ContaFinanceiraDto conta)
        {
            _contaFinanceiraRepository.Post(conta);
            if (!_notification.Any)
                return Ok();

            return Content(HttpStatusCode.BadRequest, _notification.Get);
        }

        public IHttpActionResult Put(ContaFinanceiraDto conta)
        {
            _contaFinanceiraRepository.Put(conta);
            if (!_notification.Any)
                return Ok();

            return Content(HttpStatusCode.BadRequest, _notification.Get);
        }

        public IHttpActionResult Delete(int idUsuario, int idConta)
        {
            _contaFinanceiraRepository.Delete(idUsuario, idConta);
            if (!_notification.Any)
                return Ok();

            return Content(HttpStatusCode.BadRequest, _notification.Get);
        }
    }
}