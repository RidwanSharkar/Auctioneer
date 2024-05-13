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
    ResultSet rs = stmt.executeQuery("SELECT * FROM end_user WHERE end_user_username ='" + username + "'");
    if (rs.next()) {
        // Username already exists
        request.setAttribute("errorMessage", "Username already in use. Please choose a different username.");
        request.getRequestDispatcher("CreateEndUserAccount.jsp").forward(request, response);
    } else {
        // Insert the new username and password
        stmt.executeUpdate("INSERT INTO end_user (end_user_username, end_user_password) VALUES ('" + username + "', '" + password + "')");
        request.setAttribute("successMessage", "Account created successfully!");
        %>
        <%@ include file="CreateEndUserAccount.jsp" %>
        <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
        <%
    }

    rs.close();
    stmt.close();
    conn.close();
} catch (SQLException e) {
    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
    request.getRequestDispatcher("CreateEndUserAccount.jsp").forward(request, response);
}
%>