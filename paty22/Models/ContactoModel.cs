
using System.ComponentModel.DataAnnotations;

namespace paty22.Models
{
    public class ContactoModel
    {
        [Required(ErrorMessage = "El nombre es obligatorio")]
        [StringLength(100, ErrorMessage = "El nombre no puede superar los 100 caracteres")]
        public string? Nombre { get; set; }

        [Required(ErrorMessage = "El email es obligatorio")]
        [EmailAddress(ErrorMessage = "Debe ser un email válido")]
        [StringLength(100, ErrorMessage = "El email no puede superar los 100 caracteres")]
        public string? Email { get; set; }

        [Required(ErrorMessage = "El mensaje es obligatorio")]
        [StringLength(500, ErrorMessage = "El mensaje no puede superar los 500 caracteres")]
        public string? Mensaje { get; set; }
    }
}
