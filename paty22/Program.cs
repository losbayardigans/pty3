using Microsoft.AspNetCore.DataProtection;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.EntityFrameworkCore;
using paty22.Models;
using DinkToPdf;
using DinkToPdf.Contracts;
using paty22.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// Necesario para acceder a la sesiónción de la base de datos MySQL
builder.Services.AddDbContext<ProyectoFinalContext>(options =>
    options.UseMySql(
        builder.Configuration.GetConnectionString("Connection"),
        ServerVersion.Parse("10.4.25-mariadb") // Ajusta la versión si es necesario
    ));

builder.Services.Configure<SmtpSettings>(
    builder.Configuration.GetSection("SmtpSettings"));

builder.Services.AddTransient<EmailService>();

// Configuración de sesiones
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.Cookie.Name = ".MyApp.Session";
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
    options.IdleTimeout = TimeSpan.FromMinutes(30);
});

// Configuración de localización
builder.Services.Configure<RequestLocalizationOptions>(options =>
{
    var supportedCultures = new[] { "es-ES", "en-US", "es-CL" };
    options.SetDefaultCulture("es-CL")
           .AddSupportedCultures(supportedCultures)
           .AddSupportedUICultures(supportedCultures);
});

builder.Services.AddResponseCompression();

// Registrar DinkToPdf
builder.Services.AddSingleton<IConverter, SynchronizedConverter>(sp => new SynchronizedConverter(new PdfTools()));

var app = builder.Build();

app.UseDeveloperExceptionPage();
app.UseExceptionHandler("/Home/Error");
app.UseHsts();

Console.WriteLine($"Entorno actual: {builder.Environment.EnvironmentName}");

app.UseHttpsRedirection();
app.UseStaticFiles(new StaticFileOptions
{
    OnPrepareResponse = ctx =>
    {
        // Agregar el encabezado Cache-Control a los archivos estáticos
        ctx.Context.Response.Headers.Append(
            "Cache-Control", "public, max-age=31536000");
    }
});
app.UseRequestLocalization();
app.UseHttpsRedirection();
app.UseRouting();
app.UseSession();
app.UseAuthorization();
builder.Host.UseEnvironment("Development");

// Mapeo de rutas
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");


app.Run();
