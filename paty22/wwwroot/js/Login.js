document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("Login");
    if (form) {
        form.addEventListener("submit", function (event) {
            event.preventDefault();

            const email = document.getElementById("email").value.trim();
            const password = document.getElementById("contrasena").value.trim();
            const errorMessage = document.getElementById("error-message");

            if (!email) {
                errorMessage.style.display = "block";
                errorMessage.textContent = "Por favor, ingrese su correo electrónico.";
                return;
            }

            if (!emailRegex.test(email)) {
                errorMessage.style.display = "block";
                errorMessage.textContent = "Por favor, ingrese un correo electrónico válido.";
                return;
            }

            if (!password) {
                errorMessage.style.display = "block";
                errorMessage.textContent = "Por favor, ingrese su contraseña.";
                return;
            }

            errorMessage.style.display = "none";
            alert("Formulario validado y listo para enviar.");
        });
    } else {
        console.error("No se encontró el formulario con ID 'Login'.");
    }
});
