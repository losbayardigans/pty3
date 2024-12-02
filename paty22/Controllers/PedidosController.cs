using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using paty22.Models;
using paty22.Services;
using System.Diagnostics;
using System.IO;
using System.Text;
using MimeKit;
using MailKit.Net.Smtp;
using MailKit.Security;

namespace paty22.Controllers
{
    public class PedidosController : Controller
    {
        private readonly ProyectoFinalContext _context;
        private readonly SmtpSettings _smtpSettings;
        private readonly IConfiguration _configuration;

        public PedidosController(ProyectoFinalContext context, IOptions<SmtpSettings> smtpSettings, IConfiguration configuration)
        {
            _context = context;
            _smtpSettings = smtpSettings.Value;
            _configuration = configuration;
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

            if (pedido == null)
            {
                return NotFound(); // Si no se encuentra el pedido, devolver error.
            }

            var htmlContent = @"
<html>
    <head>
        <style>
            body { 
                font-family: Arial, sans-serif; 
                color: #333; 
                background-color: #f4f4f4; 
                margin: 0; 
                padding: 0;
            }
            .boleta-container {
                width: 80%; 
                max-width: 700px; 
                margin: 20px auto; 
                background-color: #fff; 
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .header {
                text-align: center; 
                font-size: 24px; 
                margin-bottom: 20px;
                color: #333;
            }
            .header p {
                font-size: 14px;
                color: #555;
            }
            .payment-status {
                text-align: center; 
                margin-bottom: 20px;
                padding: 10px;
                background-color: #e0f7fa; 
                color: #00796b;
                font-weight: bold;
                border-radius: 5px;
            }
            .product-table { 
                width: 100%; 
                border-collapse: collapse; 
                margin-top: 20px; 
            }
            .product-table th, .product-table td { 
                padding: 8px; 
                border: 1px solid #ddd; 
                text-align: left; 
                font-size: 14px;
            }
            .product-table th {
                background-color: #f7f7f7;
                color: #333;
                font-weight: bold;
            }
            .product-table td {
                color: #666;
            }
            .total {
                font-weight: bold;
                font-size: 18px;
                margin-top: 20px;
                text-align: right;
                color: #333;
            }
            .footer {
                text-align: center;
                font-size: 12px;
                margin-top: 20px;
                color: #777;
            }
            .table-header { 
                background-color: #f7f7f7; 
                border-bottom: 2px solid #ddd; 
            }
        </style>
    </head>
    <body>
        <div class='boleta-container'>
            <div class='header'>
                <h1>Boleta de Compra</h1>
                <p>Fecha: " + DateTime.Now.ToString("dd/MM/yyyy") + @"</p>
            </div>";

            // Verificar el estado de pago
            if (pedido.Pagos != null && pedido.Pagos.Any())
            {
                var pago = pedido.Pagos.FirstOrDefault();
                if (pago != null && pago.EstadoPago == "Pagado")
                {
                    htmlContent += @"
                    <div class='payment-status'>
                        <p><strong>Pago Realizado</strong></p>
                        <p>El pago ha sido confirmado y procesado exitosamente, estarás recibiendo un correo con la confirmación.</p>
                    </div>";
                }
                else
                {
                    htmlContent += @"
                    <div class='payment-status'>
                        <p><strong>Estado de Pago:</strong> " + (pago?.EstadoPago ?? "No disponible") + @"</p>
                    </div>";
                }

                // Mostrar el método de pago utilizado
                if (pago != null)
                {
                    htmlContent += @"
                    <div class='payment-status'>
                        <p><strong>Método de Pago:</strong> " + (pago?.MetodoPago ?? "No disponible") + @"</p>
                    </div>";
                }
            }
            else
            {
                htmlContent += @"
                <div class='payment-status'>
                    <p><strong>Estado de Pago:</strong> No disponible</p>
                </div>";
            }

            // Mostrar información del cliente
            if (pedido?.Cliente != null)
            {
                htmlContent += @"
                <h3>Cliente: " + (pedido.Cliente?.Nombre ?? "Nombre no disponible") + @"</h3>
                <h4>Teléfono: " + (pedido.Cliente?.Telefono ?? "Teléfono no disponible") + @"</h4>
                <h4>Dirección: " + (pedido.Cliente?.Direccion ?? "Dirección no disponible") + @"</h4>";
            }
            else
            {
                htmlContent += @"
                <h3>Cliente: No disponible</h3>
                <h4>Teléfono: No disponible</h4>
                <h4>Dirección: No disponible</h4>";
            }

            htmlContent += @"
            <h4>Productos Comprados:</h4>
            <table class='product-table'>
                <thead>
                    <tr class='table-header'>
                        <th>Producto</th>
                        <th>Cantidad</th>
                        <th>Precio</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>";

            decimal totalPedido = 0; // Para calcular el total del pedido

            if (pedido?.PedidoProductos != null && pedido.PedidoProductos.Any())
            {
                foreach (var item in pedido.PedidoProductos)
                {
                    var cantidad = item.Cantidad ?? 0;  // Si es null, usa 0
                    var precio = item.Producto?.Precio ?? 0;  // Si es null, usa 0
                    var totalProducto = cantidad * precio;
                    totalPedido += totalProducto;

                    htmlContent += @"
                    <tr>
                        <td>" + (item.Producto?.Nombre ?? "Producto no disponible") + @"</td>
                        <td>" + cantidad + @"</td>
                        <td>" + String.Format(new System.Globalization.CultureInfo("es-CL"), "{0:C}", precio) + @"</td>
                        <td>" + String.Format(new System.Globalization.CultureInfo("es-CL"), "{0:C}", totalProducto) + @"</td>
                    </tr>";
                }
            }
            else
            {
                htmlContent += @"
                <tr>
                    <td colspan='4'>No hay productos en este pedido</td>
                </tr>";
            }

            htmlContent += @"
                </tbody>
            </table>";

            // Mostrar total del pedido
            htmlContent += @"
            <div class='total'>
                <p>Total: " + String.Format(new System.Globalization.CultureInfo("es-CL"), "{0:C}", totalPedido) + @"</p>
            </div>";

            htmlContent += @"
            <div class='footer'>
                <p>¡Gracias por tu compra! Si necesitas ayuda no dudes en contactarnos.</p>
            </div>
        </div>
    </body>
</html>";



            // Guardar HTML en un archivo temporal
            var htmlFilePath = Path.Combine(Path.GetTempPath(), "temp.html");
            System.IO.File.WriteAllText(htmlFilePath, htmlContent, Encoding.UTF8);

            // Obtener la ruta de wkhtmltopdf desde la configuración
            var wkhtmlToPdfPath = _configuration["WkHtmlToPdfPath"];

            if (string.IsNullOrEmpty(wkhtmlToPdfPath))
            {
                return StatusCode(500, "La ruta de wkhtmltopdf no está configurada correctamente.");
            }

            // Ruta del archivo PDF generado
            var pdfFilePath = Path.Combine(Path.GetTempPath(), $"pedido_{pedidoId}.pdf");

            // Ejecutar el proceso de wkhtmltopdf
            var processStartInfo = new ProcessStartInfo
            {
                FileName = wkhtmlToPdfPath,
                Arguments = $"\"{htmlFilePath}\" \"{pdfFilePath}\"",
                CreateNoWindow = true,
                UseShellExecute = false,
                RedirectStandardOutput = true,
                RedirectStandardError = true
            };

            var process = Process.Start(processStartInfo);
            process?.WaitForExit();

            // Verificar si el archivo PDF fue generado correctamente
            if (!System.IO.File.Exists(pdfFilePath))
            {
                return StatusCode(500, "Error al generar el PDF.");
            }

            // Enviar el PDF por correo al cliente
            var pdfBytes = System.IO.File.ReadAllBytes(pdfFilePath);
            var message = new MimeMessage();
            message.From.Add(new MailboxAddress("Usuario", "tu-correo@example.com"));
            message.To.Add(new MailboxAddress("Cliente", pedido?.Cliente?.Email)); // Asegúrate de que el correo del cliente esté disponible
            message.Subject = "Boleta de Compra - Pedido #" + pedidoId;
            message.Body = new TextPart("plain") { Text = $"Se adjunta el PDF del pedido #{pedidoId} realizado el {DateTime.Now:dd/MM/yyyy}." };

            var attachment = new MimePart("application", "pdf")
            {
                Content = new MimeContent(new MemoryStream(pdfBytes)),
                ContentDisposition = new ContentDisposition(ContentDisposition.Attachment),
                FileName = $"Pedido_{pedidoId}.pdf"
            };

            var multipart = new Multipart("mixed") { message.Body, attachment };
            message.Body = multipart;

            var client = new SmtpClient();
            client.Connect(_smtpSettings.Server, _smtpSettings.Port, SecureSocketOptions.StartTls);
            client.Authenticate(_smtpSettings.User, _smtpSettings.Password);
            client.Send(message);
            client.Disconnect(true);

            // Eliminar el archivo temporal después de enviarlo
            System.IO.File.Delete(pdfFilePath);

            // Devolver el archivo PDF al cliente como descarga
            return File(pdfBytes, "application/pdf", $"Pedido_{pedidoId}.pdf");
        }
    }
}
