using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using paty22.Models;
using System;
using System.Linq;
using System.Threading.Tasks;

public class CarroController : Controller
{
    private readonly ProyectoFinalContext _context;

    public CarroController(ProyectoFinalContext context)
    {
        _context = context;
    }


    public IActionResult Carrito()
    {
        int clienteId = GetClienteId();

        try
        {
            var carrito = _context.Carros
                .Include(c => c.Producto)
                .Where(c => c.ClienteId == clienteId)
                .ToList();

            decimal total = carrito.Sum(c => c.Producto.Precio * c.Cantidad);
            ViewBag.Total = total;

            return View(carrito);
        }
        catch (Exception ex)
        {
            ViewBag.ErrorMessage = "Ocurrió un error al cargar el carrito: " + ex.Message;
            return View("Error");
        }
    }


    [HttpPost]
    public async Task<IActionResult> AgregarAlCarrito(int productoId)
    {
        int clienteId = GetClienteId();

        if (clienteId == -1)
        {
            TempData["ErrorMessage"] = "Debe iniciar sesión para agregar productos al carrito.";
            return View("Carrito");
        }

        try
        {
            var productoEnCarrito = await _context.Carros
                .FirstOrDefaultAsync(c => c.ClienteId == clienteId && c.ProductoId == productoId);

            if (productoEnCarrito != null)
            {
                productoEnCarrito.Cantidad++;
                _context.Carros.Update(productoEnCarrito);
            }
            else
            {
                var nuevoCarro = new Carro
                {
                    ClienteId = clienteId,
                    ProductoId = productoId,
                    Cantidad = 1,
                    FechaAgregado = DateTime.Now
                };
                _context.Carros.Add(nuevoCarro);
            }

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = "Producto agregado al carrito con éxito.";
        }
        catch (Exception ex)
        {
            TempData["ErrorMessage"] = "Hubo un error al agregar el producto al carrito: " + ex.Message;
        }

        return RedirectToAction("Carrito");
    }

 
    public async Task<IActionResult> ModificarCantidad(int productoId, int cantidad)
    {
        int clienteId = GetClienteId();

        if (clienteId == -1)
        {
            TempData["ErrorMessage"] = "Debe iniciar sesión para modificar la cantidad de productos en el carrito.";
            return RedirectToAction("Carrito");
        }

        try
        {
            var productoEnCarrito = await _context.Carros
                .FirstOrDefaultAsync(c => c.ClienteId == clienteId && c.ProductoId == productoId);

            if (productoEnCarrito != null)
            {
                productoEnCarrito.Cantidad = cantidad;
                _context.Carros.Update(productoEnCarrito);
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Cantidad modificada con éxito.";
            }
            else
            {
                TempData["ErrorMessage"] = "El producto no se encuentra en el carrito.";
            }
        }
        catch (Exception ex)
        {
            TempData["ErrorMessage"] = "Hubo un error al modificar la cantidad: " + ex.Message;
        }

        return RedirectToAction("Carrito");
    }

   
    [HttpPost]
    public async Task<IActionResult> EliminarDelCarrito(int carroId)
    {
        int clienteId = GetClienteId();

        if (clienteId == -1)
        {
            TempData["ErrorMessage"] = "Debe iniciar sesión para eliminar productos del carrito.";
            return RedirectToAction("Carrito");
        }

        try
        {
            var carro = await _context.Carros
                .FirstOrDefaultAsync(c => c.Id == carroId && c.ClienteId == clienteId);

            if (carro != null)
            {
                _context.Carros.Remove(carro);
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Producto eliminado del carrito con éxito.";
            }
            else
            {
                TempData["ErrorMessage"] = "Producto no encontrado en el carrito.";
            }
        }
        catch (Exception ex)
        {
            TempData["ErrorMessage"] = "Hubo un error al eliminar el producto del carrito: " + ex.Message;
        }

        return RedirectToAction("Carrito");
    }


    public IActionResult ConfirmarCompra()
    {
        int clienteId = GetClienteId();
        if (clienteId == -1)
        {
            TempData["ErrorMessage"] = "Debe iniciar sesión para confirmar el pedido.";
            TempData.Keep();
            return RedirectToAction("Carrito");
        }

        var carrito = _context.Carros
            .Include(c => c.Producto)
            .Where(c => c.ClienteId == clienteId)
            .ToList();

        decimal total = carrito.Sum(c => c.Producto.Precio * c.Cantidad);
        ViewBag.Total = total;

        var viewModel = new PedidoPagoViewModel
        {
            PedidoProductos = carrito.Select(c => new PedidoProducto
            {
                ProductoId = c.ProductoId,
                Cantidad = c.Cantidad,
                Producto = c.Producto
            }).ToList(),
        };

        return View(viewModel);
    }

   
    [HttpPost]
    public async Task<IActionResult> ConfirmarCompra(PedidoPagoViewModel viewModel)
    {
        try
        {
            var clienteId = GetClienteId();
            if (clienteId == -1)
            {
                TempData["ErrorMessage"] = "Debe iniciar sesión para confirmar el pedido.";
                return RedirectToAction("Carrito");
            }
            var cliente = await _context.Clientes.FirstOrDefaultAsync(c => c.Id == clienteId);
            if (cliente == null)
            {
                TempData["ErrorMessage"] = "Cliente no encontrado.";
                return RedirectToAction("Carrito");
            }

            // actualizamos la direccion que el usuario ah ingresado en el formulario gaa
            if (!string.IsNullOrEmpty(viewModel.Direccion) ||
       !string.IsNullOrEmpty(viewModel.Telefono) ||
       !string.IsNullOrEmpty(viewModel.Nombre))
            {
                if (!string.IsNullOrEmpty(viewModel.Direccion))
                {
                    cliente.Direccion = viewModel.Direccion;
                }

                if (!string.IsNullOrEmpty(viewModel.Telefono))
                {
                    cliente.Telefono = viewModel.Telefono;
                }

                if (!string.IsNullOrEmpty(viewModel.Nombre))
                {
                    cliente.Nombre = viewModel.Nombre;
                }

                // Actualiza el cliente en la base de datos
                _context.Clientes.Update(cliente);
                await _context.SaveChangesAsync();
            }

            // Crea el pedido
            // Crear el pedido
            var pedido = new Pedido
            {
                ClienteId = clienteId,
                Fecha = DateTime.Now,
                Estado = "Pendiente",
                EstadoPedido = "Confirmado"
            };

            _context.Pedidos.Add(pedido);
            await _context.SaveChangesAsync(); //guardamos cambios 
            TempData["PedidoId"] = pedido.Id; // guardamos el id para poder verificarlog

            // ahora que existe el id agrega los valores ala nueva tabla pedidoprdoucto
            var carrito = _context.Carros
                .Where(c => c.ClienteId == clienteId)
                .Include(c => c.Producto)
                .ToList();

            foreach (var carro in carrito)
            {
                var pedidoProducto = new PedidoProducto
                {
                    PedidoId = pedido.Id, //asociamos el nuevo id 
                    ProductoId = carro.ProductoId, // tenemos el id del carro 
                    Cantidad = carro.Cantidad // los productos que tiene en l carro 
                };

                _context.PedidoProductos.Add(pedidoProducto);
            }

            await _context.SaveChangesAsync(); // si todo esta bien guardamos cambios 
            TempData["PedidoProductos"] = carrito.Count; // guardamos la cantidad de producros 

            // creamos y luego guardamos el pago ojo que el pago es simulado noma xd
            var pago = new Pago
            {
                PedidoId = pedido.Id,
                MetodoPago = viewModel.Pago.MetodoPago,
                EstadoPago = "Pendiente",
                FechaPago = DateTime.Now
            };

            _context.Pagos.Add(pago);
            await _context.SaveChangesAsync();
            TempData["PagoEstado"] = pago.EstadoPago; //guardamos el estado de pago para verificarlo 

            // Limpiar el carrito después de la compra
            var carritoCliente = _context.Carros.Where(c => c.ClienteId == clienteId).ToList();
            _context.Carros.RemoveRange(carritoCliente);
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = "Pedido confirmado con éxito.";
            return RedirectToAction("FinalizarCompra", new { id = pedido.Id });
        }
        catch (Exception ex)
        {
            TempData["ErrorMessage"] = "Ocurrió un error al confirmar el pedido: " + ex.Message;
            return View("Error");
        }
    }

//esto muestra la vista del pedido 
    public IActionResult FinalizarCompra(int id)
{
    var pedido = _context.Pedidos
        .Include(p => p.PedidoProductos)
            .ThenInclude(pp => pp.Producto)
        .Include(p => p.Cliente)
        .FirstOrDefault(p => p.Id == id);

    if (pedido == null)
    {
        TempData["ErrorMessage"] = "Pedido no encontrado.";
        return RedirectToAction("Carrito");
    }

    var pago = _context.Pagos.FirstOrDefault(p => p.PedidoId == id);

    var total = pedido.PedidoProductos.Sum(pp => pp.Cantidad * pp.Producto.Precio);

    var viewModel = new PedidoPagoViewModel
    {
        Pedido = pedido,
        PedidoProductos = pedido.PedidoProductos?.ToList() ?? new List<PedidoProducto>(),
        Total = total ?? 0m,
        Pago = pago ?? new Pago(),
        Nombre = pedido.Cliente.Nombre ?? string.Empty,
        Telefono = pedido.Cliente.Telefono ?? string.Empty,
        Direccion = pedido.Cliente.Direccion ?? string.Empty
    };

    return View(viewModel);
}

    


    //almacenamos al cliente por sesion !
    private int GetClienteId()
    {
        var clienteId = HttpContext.Session.GetInt32("ClienteId");

        // si no encuentra al usuairo dirigimos al login 
        if (clienteId == null)
        {
            return -1;  // retornamos para ver que el usuario no esta registrado
        }

        return clienteId.Value;  // retornamos al cliente registrado
    }

}
