<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Success Page</title>
    <style>
        /* Add your CSS styles here */
    </style>
</head>
<body>
    <%
    String username = (String) session.getAttribute("username");
    if (username == null) {
    %>
        <p>You are not logged in. Please <a href="AdminLogin.jsp">login</a> first.</p>
    <%
    } else {
    %>
        <h1>Welcome, <%= username %>!</h1>
        <p>You have successfully logged in.</p>
        <a href="CreateCustomerRepAccount.jsp">Create Customer Representative Account</a>
        <a href="GenerateSalesReport.jsp">Generate Sales Report</a>
        <a href="Logout.jsp">Logout</a>
    <%
    }
    %>
</body>
</html>