<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create End User Account</title>
</head>
<body>
    <h1>Create Customer Representative Account</h1>
    <form action="CheckNewCustomerRepLogin.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        <input type="submit" value="Create Account">
    </form>

    <%
    // You can add any additional JSP code or HTML here
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
    %>
    <p style="color:red;"><%= errorMessage %></p>
    <%
    }
    %>


</body>
</html>