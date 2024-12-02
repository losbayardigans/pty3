using System;
using System.Collections.Generic;

namespace paty22.Models;

public partial class Cliente
{
    public int Id { get; set; }

    public string Nombre { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string? Telefono { get; set; }

    public string? Direccion { get; set; }

    public string Contrasena { get; set; } = null!;

    public string? NumeroTarjeta { get; set; }

    public string? FechaExpiracion { get; set; }

    public string? Cvv { get; set; }

    public virtual ICollection<Carro> Carros { get; set; } = new List<Carro>();

    public virtual ICollection<ClienteProducto> ClienteProductos { get; set; } = new List<ClienteProducto>();

    public virtual ICollection<Pedido> Pedidos { get; set; } = new List<Pedido>();
}
