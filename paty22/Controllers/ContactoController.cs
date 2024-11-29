using Microsoft.AspNetCore.Mvc;
using paty22.Models;
using paty22.Services;

namespace paty22.Controllers
{
    public class ContactoController : Controller
    {
        private readonly EmailService _emailService;

        // Inyectar el servicio de EmailService
        public ContactoController(EmailService emailService)
        {
            _emailService = emailService;
        }

        // Acción para mostrar el formulario de contacto
        public IActionResult Formulario()
        {
            var model = new ContactoModel();  // Asegúrate de que el modelo está inicializado
            return View(model);  // Pasar
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Enviar(ContactoModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    _emailService.SendEmail(model.Email, "Nuevo mensaje de contacto", model.Mensaje);
                    TempData["MensajeExito"] = "Tu mensaje ha sido enviado correctamente.¡Gracias por contactarnos!";
                    return RedirectToAction("Formulario");
                }
                catch (Exception ex)
                {
                    TempData["MensajeError"] = "Hubo un error al enviar tu mensaje. Intenta nuevamente.";
                }
            }

            return View("Formulario", model);
        }
    }
}
