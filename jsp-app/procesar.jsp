<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // ===== 1. VALIDAR MÉTODO POST =====
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.setStatus(405);
        out.println("<h3>405 - Método no permitido</h3>");
        return;
    }

    // ===== 2. OBTENER PARÁMETROS DEL FORMULARIO =====
    // Equivalente a $_POST['nombre'] en PHP
    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");

    // ===== 3. VALIDAR QUE NO VENGAN VACÍOS =====
    if (nombre == null || nombre.trim().isEmpty() ||
        correo == null || correo.trim().isEmpty()) {
        response.setStatus(400);
        out.println("<h3>400 - Datos inválidos</h3>");
        return;
    }

    // ===== 4. SANITIZAR (evitar XSS) =====
    // Reemplazamos < y > por sus entidades HTML
    nombre = nombre.replace("<", "&lt;").replace(">", "&gt;");
    correo = correo.replace("<", "&lt;").replace(">", "&gt;");

    // ===== 5. GUARDAR EN SESIÓN =====
    // Equivalente a session_start() y $_SESSION en PHP
    HttpSession sesion = request.getSession();
    List<Map<String, String>> registros =
        (List<Map<String, String>>) sesion.getAttribute("registros");
    if (registros == null) {
        registros = new ArrayList<>();
    }

    Map<String, String> nuevo = new HashMap<>();
    nuevo.put("nombre", nombre);
    nuevo.put("correo", correo);
    registros.add(nuevo);

    sesion.setAttribute("registros", registros);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Resultados JSP</title>
    <style>body { font-family: sans-serif; padding: 20px; }</style>
</head>
<body>
    <h3>Registros almacenados (Sesión JSP)</h3>
    <table border="1" cellpadding="8" cellspacing="0">
        <tr><th>Nombre</th><th>Correo</th></tr>
        <%-- Iteramos con JSTL (seguro contra XSS) --%>
        <c:forEach var="reg" items="${sessionScope.registros}">
            <tr>
                <td><c:out value="${reg.nombre}" /></td>
                <td><c:out value="${reg.correo}" /></td>
            </tr>
        </c:forEach>
    </table>
    <br>
    <a href="index.jsp">Volver al formulario</a>
</body>
</html>