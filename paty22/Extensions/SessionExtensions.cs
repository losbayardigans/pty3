using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;

namespace paty22.Extensions
{
    public static class SessionExtensions
    {
        // Método para guardar objetos complejos en la sesión
        public static void SetObject(this ISession session, string key, object value)
        {
            session.SetString(key, JsonConvert.SerializeObject(value));
        }

        // Método para obtener objetos complejos desde la sesión
        public static T? GetObject<T>(this ISession session, string key) where T : class
        {
            var value = session.GetString(key);
            // Si no se encuentra un valor en la sesión, retornamos null
            return value == null ? null : JsonConvert.DeserializeObject<T>(value);
        }
    }
}
