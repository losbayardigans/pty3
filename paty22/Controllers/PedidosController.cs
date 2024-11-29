using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using paty22.Models;
using System.Diagnostics;
using System.IO;
using System.Text;

namespace paty22.Controllers
{
    public class PedidosController : Controller
    {
        private readonly ProyectoFinalContext _context;

        public PedidosController(ProyectoFinalContext context)
        {
            _context = context;
        }

        public IActionResult GenerarPDF(int pedidoId)
        {
            // Obtener los datos del pedido desde la base de datos
            var pedido = _context.Pedidos
                .Include(p => p.PedidoProductos)

                    .ThenInclude(pp => pp.Producto)
                    .Include(p => p.Cliente)
                .Where(p => p.Id == pedidoId)
                .FirstOrDefault();

            if (pedido == null)
            {
                return NotFound(); // Si no se encuentra el pedido, devolver error.
            }

            // Crear el HTML del contenido del PDF
            // Crear el HTML del contenido del PDF
            var htmlContent = @"
    <html>
        <head>
            <style>
                body { font-family: Arial, sans-serif; color: #333; }
                .header { text-align: center; font-size: 24px; margin-bottom: 20px; }
                .product-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
                .product-table th, .product-table td { padding: 8px; border: 1px solid #ddd; text-align: left; }
                .footer { text-align: center; font-size: 12px; margin-top: 20px; color: #777; }
                .table-header { background-color: #f7f7f7; border-bottom: 2px solid #ddd; }
                .total { font-weight: bold; }
            </style>
        </head>
        <body>
            <div class='header'>
                <h1>Boleta de Compra</h1>
                <p>Fecha: " + DateTime.Now.ToString("dd/MM/yyyy") + @"</p>
            </div>";

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

            if (pedido?.PedidoProductos != null && pedido.PedidoProductos.Any())
            {
                foreach (var item in pedido.PedidoProductos)
                {
                    htmlContent += @"
            <tr>
                <td>" + (item.Producto?.Nombre ?? "Producto no disponible") + @"</td>
                <td>" + item.Cantidad + @"</td>
                <td>$" + (item.Producto?.Precio.ToString("C0") ?? "0") + @"</td>
                <td>$" + (item.Cantidad * (item.Producto?.Precio ?? 0)) + @"</td>
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
            </table>
            <h4 class='total'>Total a Pagar: $" + (pedido?.PedidoProductos?.Sum(pp => pp.Cantidad * (pp.Producto?.Precio ?? 0)) ?? 0).ToString("C0") + @"</h4>
            <div class='footer'>
                <p>¡Gracias por tu compra!</p>
            </div>
        </body>
    </html>";


            // Guardar el contenido HTML en un archivo temporal
            var htmlFilePath = Path.Combine(Path.GetTempPath(), "temp.html");
            System.IO.File.WriteAllText(htmlFilePath, htmlContent, Encoding.UTF8);

            // Ruta al ejecutable wkhtmltopdf
            var wkhtmltopdfPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "wkhtmltox", "wkhtmltopdf", "bin", "wkhtmltopdf.exe");

            // Ruta del archivo PDF generado
            var pdfFilePath = Path.Combine(Path.GetTempPath(), "pedido_" + pedidoId + ".pdf");

            // Crear el proceso para ejecutar wkhtmltopdf
            var processStartInfo = new ProcessStartInfo
            {
                FileName = wkhtmltopdfPath,
                Arguments = $"\"{htmlFilePath}\" \"{pdfFilePath}\"", // Pasar los archivos como argumentos
                CreateNoWindow = true, // No mostrar ventana
                UseShellExecute = false, // No usar el shell
                RedirectStandardOutput = true,
                RedirectStandardError = true
            };

            var process = Process.Start(processStartInfo);
            process.WaitForExit(); // Esperar a que termine el proceso

            // Verificar si el archivo PDF fue generado correctamente
            if (!System.IO.File.Exists(pdfFilePath))
            {
                return StatusCode(500, "Error al generar el PDF.");
            }

            // Devolver el archivo PDF generado
            return File(System.IO.File.ReadAllBytes(pdfFilePath), "application/pdf", $"Pedido_{pedidoId}.pdf");
        }
    }
}
