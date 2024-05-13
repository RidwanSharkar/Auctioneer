<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");

try {
    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();
    Statement stmt = conn.createStatement();

    // Check if the username already exists
    ResultSet rs = stmt.executeQuery("SELECT * FROM customer_representative WHERE customer_rep_username ='" + username + "'");
    if (rs.next()) {
        // Username already exists
        request.setAttribute("errorMessage", "Username already in use. Please choose a different username.");
        request.getRequestDispatcher("CreateCustomerRepAccount.jsp").forward(request, response);
    } else {
        // Insert the new username and password
        stmt.executeUpdate("INSERT INTO customer_representative (customer_rep_username, admin_username, customer_rep_password) VALUES ('" + username + "', '" + session.getAttribute("username") + "', '" + password + "')");
        request.setAttribute("successMessage", "Account created successfully!");
        %>
        <%@ include file="CreateCustomerRepAccount.jsp" %>
        <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
        <%
    }

    rs.close();
    stmt.close();
    conn.close();
} catch (SQLException e) {
    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
    request.getRequestDispatcher("CreateCustomerRepAccount.jsp").forward(request, response);
}
%>