<?php
// 1. Validar método POST (Seguridad)
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    exit('Método no permitido');
}

// 2. Sanitizar y validar inputs
$nombre_raw = filter_input(INPUT_POST, 'nombre', FILTER_SANITIZE_STRING);
$correo_raw = filter_input(INPUT_POST, 'correo', FILTER_VALIDATE_EMAIL);

if (!$nombre_raw || !$correo_raw) {
    http_response_code(400); // Bad Request
    exit('Datos inválidos o correo mal formateado');
}

// 3. Prevención XSS: Escapar salida
$nombre = htmlspecialchars($nombre_raw, ENT_QUOTES, 'UTF-8');
$correo = htmlspecialchars($correo_raw, ENT_QUOTES, 'UTF-8');

// 4. Iniciar sesión y guardar
session_start();
if (!isset($_SESSION['registros'])) {
    $_SESSION['registros'] = [];
}
$_SESSION['registros'][] = ['nombre' => $nombre, 'correo' => $correo];

// 5. Renderizar respuesta estructurada
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registros PHP</title>
</head>
<body>
    <h3>Registros almacenados (Sesión PHP)</h3>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr><th>Nombre</th><th>Correo</th></tr>
        <?php foreach ($_SESSION['registros'] as $reg): ?>
            <tr>
                <td><?php echo $reg['nombre']; ?></td>
                <td><?php echo $reg['correo']; ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
    <br>
    <a href="index.html">Volver al formulario</a>
</body>
</html>