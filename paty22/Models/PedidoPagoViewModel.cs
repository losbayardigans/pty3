namespace paty22.Models
{
    public class PedidoPagoViewModel
    {
        public Pedido Pedido { get; set; } = new Pedido();
        public List<PedidoProducto> PedidoProductos { get; set; } = new List<PedidoProducto>(); 
        public decimal Total { get; set; }
        public string? NumeroTarjeta { get; set; }
        public string? FechaExpiracion { get; set; }
        public string? Cvv { get; set; }
        public Pago Pago { get; set; } = new Pago();
    

     
        public string? Nombre { get; set; }   
        public string? Telefono { get; set; } 
        public string? Direccion { get; set; }

        public string MetodoPago { get; set; }
    }


}
