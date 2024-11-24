using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using paty22.Models;
using BCrypt.Net;
using System;
using System.Threading.Tasks;

namespace patyy.Controllers
{
    public class ClientesController : Controller
    {
        private readonly ProyectoFinalContext _context;

        public ClientesController(ProyectoFinalContext context)
        {
            _context = context;
        }

        // GET: Clientes/Login

        public IActionResult Login()
        {
            return View();
        }

    
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(string email, string contrasena)
        {
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(contrasena))
            {
                ModelState.AddModelError(string.Empty, "Correo y contraseña son obligatorios.");
                return View();
            }

            var cliente = await _context.Clientes
                .FirstOrDefaultAsync(c => c.Email == email);

            if (cliente == null)
            {
                ModelState.AddModelError(string.Empty, "Correo o contraseña incorrectos.");
                return View();
            }

            //verificamos si la contra es la misma que la creada 
            bool isPasswordCorrect = BCrypt.Net.BCrypt.Verify(contrasena, cliente.Contrasena);

            if (!isPasswordCorrect)
            {
                ModelState.AddModelError(string.Empty, "Correo o contraseña incorrectos.");
                return View();
            }

            HttpContext.Session.SetInt32("ClienteId", cliente.Id);  // guardamos al usuario en la sesion es la forma mas basica ,(no pude hacerlo por identy xD)
           
            TempData["SuccessMessage"] = "¡Has iniciado sesión con éxito!";

            HttpContext.Session.SetString("NombreCliente", cliente.Nombre ?? "Usuario");

            return RedirectToAction("Index", "Home");
        }



        // GET: Clientes/Logout
        public IActionResult Logout()
        {
            HttpContext.Session.Clear(); // Limpiamos la sesion del cliente
            return RedirectToAction("Login");
        }


        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Register(Cliente model)
        {
            if (ModelState.IsValid)
            {
                // Hashear la contraseña con bcrypt
                var hashedPassword = BCrypt.Net.BCrypt.HashPassword(model.Contrasena);

                var cliente = new Cliente
                {
                    Nombre = model.Nombre,
                    Telefono = model.Telefono,
                    Email = model.Email,
                    Contrasena = hashedPassword, // almacenamos la contra hasheada 
                };

                // Agregamos ala tabala cliente 
                _context.Clientes.Add(cliente);
                await _context.SaveChangesAsync();

                // nos vamos ala vista login 
                return RedirectToAction("Login");
            }

            return View(model);
        }

    }
}

