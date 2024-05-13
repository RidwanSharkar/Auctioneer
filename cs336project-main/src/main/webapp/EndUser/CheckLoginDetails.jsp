<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
    	ApplicationDB db = new ApplicationDB();
        Connection conn = db.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM end_user WHERE end_user_username ='" + username + "' AND end_user_password ='" + password + "'");

        if (rs.next()) {
            session.setAttribute("username", username);
            response.sendRedirect("Success.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("EndUserLogin.jsp").forward(request, response);
        }

        rs.close();
        stmt.close();
        conn.close();
    }  catch (SQLException e) {
        request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        request.getRequestDispatcher("EndUserLogin.jsp").forward(request, response);
    }
%>