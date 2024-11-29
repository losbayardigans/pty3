namespace paty22.Services
{
    using MailKit.Net.Smtp;
    using MimeKit;
    using Microsoft.Extensions.Options;
    using paty22.Models;

    public class EmailService
    {
        private readonly SmtpSettings _smtpSettings;

        public EmailService(IOptions<SmtpSettings> smtpSettings)
        {
            _smtpSettings = smtpSettings.Value;
        }

        public void SendEmail(string userEmail, string subject, string body)
        {
            var message = new MimeMessage();

            // El 'From' es el correo de tu servidor (ya autenticado)
            message.From.Add(new MailboxAddress("usuario", "codecraftsolution20@gmail.com"));  // Aquí usas tu correo de administrador

            // El 'To' es tu correo, para que recibas el mensaje
            message.To.Add(new MailboxAddress("proyecto_paty", "codecraftsolution20@gmail.com"));
            message.To.Add(new MailboxAddress("proyecto_paty", "ariel.villalobos.garcia@cftmail.cl"));

            // Agregar el correo del usuario en 'Reply-To'
            message.ReplyTo.Add(new MailboxAddress("", userEmail)); // Aquí configuras el correo del usuario como 'Reply-To'

            message.Subject = subject;
            message.Body = new TextPart("plain") { Text = body };

            using (var client = new SmtpClient())
            {
                client.Connect(_smtpSettings.Server, _smtpSettings.Port, MailKit.Security.SecureSocketOptions.StartTls);
                client.Authenticate(_smtpSettings.User, _smtpSettings.Password);
                client.Send(message);
                client.Disconnect(true);
            }
        }
        public void SendEmailWithAttachmentToUser(string userEmail, string subject, string body, string attachmentPath)
        {
            // Crear el mensaje
            var message = new MimeMessage();

            // Desde: El correo de tu servidor (puede ser el correo administrador o el que se configure)
            message.From.Add(new MailboxAddress("", "codecraftsolution20@gmail.com"));

            // Para: El correo del usuario al que se le enviará el mensaje
            message.To.Add(new MailboxAddress("Cliente", userEmail));

            // Asunto del mensaje
            message.Subject = subject;

            // Cuerpo del mensaje (puedes personalizarlo)
            message.Body = new TextPart("plain")
            {
                Text = body
            };

            // Crear el adjunto (PDF)
            var attachment = new MimePart("application", "pdf")
            {
                Content = new MimeContent(File.OpenRead(attachmentPath)),
                ContentDisposition = new ContentDisposition(ContentDisposition.Attachment),
                FileName = Path.GetFileName(attachmentPath)
            };

            // Crear el multipart (mensaje con adjunto)
            var multipart = new Multipart("mixed")
    {
        message.Body,
        attachment
    };

            message.Body = multipart;

            // Enviar el correo
            try
            {
                using (var client = new SmtpClient())
                {
                    // Conectarse al servidor SMTP (esto puede variar según el servidor)
                    client.Connect("smtp.gmail.com", 587, MailKit.Security.SecureSocketOptions.StartTls);

                    // Autenticarse con las credenciales del servidor SMTP
                    client.Authenticate("codecraftsolution20@gmail.com", "mitz phwf grnx unkn");

                    // Enviar el mensaje
                    client.Send(message);

                    // Desconectar
                    client.Disconnect(true);
                }
            }
            catch (Exception ex)
            {
                // Manejo de errores si ocurre algo al enviar el correo
                Console.WriteLine($"Error al enviar el correo: {ex.Message}");
            }
        }
    }
}