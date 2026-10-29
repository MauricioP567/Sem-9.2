# Laboratorio 09 - Sistema de Registro de Contacto (PHP & JSP)

**Alumno:** [Tu Nombre Completo]
**Curso:** Desarrollo de Aplicaciones Web (IS093A)
**Fecha:** 29.10.2026
**Modalidad:** Individual

## Descripción del Proyecto
El presente laboratorio consiste en el desarrollo de un sistema de registro de contactos implementado en dos tecnologías backend diferentes: **PHP** y **JSP (Java)**. El objetivo es comparar el ciclo de vida, despliegue, gestión de estado y seguridad de ambas tecnologías. El sistema permite validar datos, sanitizarlos para prevenir ataques XSS y almacenar la información en sesiones del servidor.

## Estructura de Carpetas

A continuación se presenta la organización del código fuente del proyecto:

![Estructura de carpetas](capturas/estructura_carpetas.png)
*(Nota: Reemplaza "estructura_carpetas.png" por el nombre de la captura donde muestras tus carpetas).*

```text
Lab09_Contacto/
├── php-app/
│   ├── index.html
│   └── procesar.php
├── jsp-app/
│   ├── index.jsp
│   └── procesar.jsp
├── capturas/
└── README.md




[ CLIENTE (Navegador Web) ]
       │
       │ 1. El usuario llena el formulario y hace clic en "Enviar" (Petición POST).
       ▼
[ DNS / RED ]
       │
       │ 2. Resolución de dominio: localhost (127.0.0.1).
       │ 3. Conexión TCP/IP establecida (Puerto 80 para PHP / Puerto 8080 para JSP).
       ▼
[ SERVIDOR WEB ]
       │
       │ 4. Apache (XAMPP) recibe la petición PHP.
       │    Apache Tomcat recibe la petición JSP.
       ▼
[ BACKEND ]
       │
       │ 5. procesar.php o procesar.jsp:
       │    - Valida el método HTTP (Rechaza si no es POST).
       │    - Obtiene los parámetros (Nombre, Correo).
       │    - Sanitiza los datos (evita inyección de scripts).
       │    - Almacena en la sesión del servidor ($_SESSION / HttpSession).
       ▼
[ SERVIDOR WEB (Respuesta) ]
       │
       │ 6. Genera el código HTML dinámico con los datos registrados.
       │ 7. Envía HTTP Response (Código 200 OK, o errores 400/405).
       ▼
[ RENDER (Cliente) ]
       │
       │ 8. El navegador interpreta el HTML y renderiza la tabla de registros.








       