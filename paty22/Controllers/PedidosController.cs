using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using paty22.Models;
using paty22.Services;
using System.Diagnostics;
using System.IO;
using System.Text;
using MailKit.Net.Smtp;
using MimeKit;


namespace paty22.Controllers
{
    public class PedidosController : Controller
    {
        private readonly ProyectoFinalContext _context;
        private readonly SmtpSettings _smtpSettings;
        public PedidosController(ProyectoFinalContext context, IOptions<SmtpSettings> smtpSettings)
        {
            _context = context;
            _smtpSettings = smtpSettings.Value;
        }

        public IActionResult GenerarPDF(int pedidoId)
        {
            // Obtener los datos del pedido desde la base de datos
            var pedido = _context.Pedidos
                .Include(p => p.Pagos)
                .Include(p => p.PedidoProductos)
                .ThenInclude(pp => pp.Producto)
                .Include(p => p.Cliente)
                .FirstOrDefault(p => p.Id == pedidoId);

            if (pedido == null || pedido.Cliente == null || string.IsNullOrEmpty(pedido.Cliente.Email))
            {
                return NotFound("Pedido o datos del cliente no encontrados.");
            }

            // Crear el mensaje de correo
            var message = new MimeMessage();
            message.From.Add(new MailboxAddress("Tienda Online", "codecraftsolution20@gmail.com"));
            message.To.Add(new MailboxAddress(pedido.Cliente.Nombre, pedido.Cliente.Email));
            message.Subject = "Resumen de Pedido #" + pedidoId;

            // Generar el contenido del correo
            var emailBody = new StringBuilder();
            emailBody.AppendLine($"<h1>¡Gracias por tu compra, {pedido.Cliente.Nombre}!</h1>");
            emailBody.AppendLine($"<p>Te enviamos un resumen de tu pedido realizado el {DateTime.Now:dd/MM/yyyy}:</p>");

            // Información del cliente
            emailBody.AppendLine("<h2>Detalles del Cliente:</h2>");
            emailBody.AppendLine($"<p>Nombre: {pedido.Cliente.Nombre}</p>");
            emailBody.AppendLine($"<p>Teléfono: {pedido.Cliente.Telefono}</p>");
            emailBody.AppendLine($"<p>Dirección: {pedido.Cliente.Direccion}</p>");

            // Información del pedido
            emailBody.AppendLine("<h2>Productos Comprados:</h2>");
            if (pedido.PedidoProductos != null && pedido.PedidoProductos.Any())
            {
                emailBody.AppendLine("<ul>");
                decimal total = 0;
                foreach (var item in pedido.PedidoProductos)
                {
                    var cantidad = item.Cantidad ?? 0;
                    var precio = item.Producto?.Precio ?? 0;
                    var subtotal = cantidad * precio;
                    total += subtotal;
                    emailBody.AppendLine($"<li>{item.Producto?.Nombre} - Cantidad: {cantidad}, Precio: {String.Format(new System.Globalization.CultureInfo("es-CL"), "{0:C}", precio)}, Total: {String.Format(new System.Globalization.CultureInfo("es-CL"), "{0:C}", subtotal)}</li>");

                }
                emailBody.AppendLine("</ul>");
                emailBody.AppendLine($"<p><strong>Total del Pedido: {String.Format(new System.Globalization.CultureInfo("es-CL"), "{0:C}", total)}</strong></p>");

            }
            else
            {
                emailBody.AppendLine("<p>No hay productos asociados a este pedido.</p>");
            }

            // Estado de pago
            var pago = pedido.Pagos?.FirstOrDefault();
            if (pago != null)
            {
                emailBody.AppendLine("<h2>Estado de Pago:</h2>");
                emailBody.AppendLine($"<p>Estado: {pago.EstadoPago}</p>");
                emailBody.AppendLine($"<p>Método: {pago.MetodoPago}</p>");
            }
            else
            {
                emailBody.AppendLine("<p>No se encontraron registros de pago asociados a este pedido.</p>");
            }

            emailBody.AppendLine("<p>Si tienes alguna duda, no dudes en contactarnos. ¡Gracias por confiar en nosotros!</p>");

            // Asignar el cuerpo al mensaje
            message.Body = new TextPart("html")
            {
                Text = emailBody.ToString()
            };

            // Enviar el correo
            using var client = new SmtpClient();
            try
            {
                client.Connect(_smtpSettings.Server, _smtpSettings.Port, MailKit.Security.SecureSocketOptions.StartTls);
                client.Authenticate(_smtpSettings.User, _smtpSettings.Password);
                client.Send(message);
                client.Disconnect(true);

                return Ok("Correo enviado exitosamente.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al enviar el correo: {ex.Message}");
            }
        }


    }
}