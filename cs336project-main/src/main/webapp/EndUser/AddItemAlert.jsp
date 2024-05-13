<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ include file="DatabaseUpdates.jsp" %>
<%
    String partType = request.getParameter("partType");
    String partBrand = request.getParameter("partBrand");
   	

    try {
    	ApplicationDB db1 = new ApplicationDB();
        Connection conn1 = db1.getConnection();
        Statement stmt5 = conn1.createStatement();
        ResultSet rs1 = stmt5.executeQuery("SELECT * FROM item_alert WHERE item_alert.end_user_username = '" 
        + session.getAttribute("username")  + "' AND item_alert.pc_part_type = '" + 
        partType + "' AND item_alert.pc_part_brand = '" + partBrand + "'");

        if (rs1.next()) {
        	request.setAttribute("errorMessage", "Alert already in use.");
            request.getRequestDispatcher("ViewAlerts.jsp").forward(request, response);
        } else {
        	stmt5.executeUpdate("INSERT INTO item_alert VALUES ('" + session.getAttribute("username") + "' , '" + partType + "' , '" + partBrand + "' )");
        	request.setAttribute("successMessage", "Alert set successfully!");
        	
        	%>
            <%@ include file="ViewAlerts.jsp" %>
            <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
            <%
        }

        rs1.close();
        stmt5.close();
        conn1.close();
    }  catch (SQLException e) {
        request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        request.getRequestDispatcher("ViewAlerts.jsp").forward(request, response);
    }
%>