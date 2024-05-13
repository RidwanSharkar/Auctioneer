<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ include file="DatabaseUpdates.jsp" %>
<%
    String auctionId1 = request.getParameter("auctionId");
    String upperLimit = request.getParameter("upperLimit");
   	

    try {
    	ApplicationDB db1 = new ApplicationDB();
        Connection conn1 = db1.getConnection();
        Statement stmt4 = conn1.createStatement();
        
        String update = "INSERT INTO auto_bid VALUES ('" + (String)session.getAttribute("username") + "' , '" + auctionId1 + "' , " + upperLimit + ")";
        
        stmt4.executeUpdate(update);
        
        request.setAttribute("successMessage", "Automatic Bid set successfully!");
    	
    	%>
        <%@ include file="BidForAnAuction.jsp" %>
        <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
        <%

        stmt4.close();
        conn1.close();
    }  catch (SQLException e) {
        request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        request.getRequestDispatcher("BidForAnAuction.jsp").forward(request, response);
    }
%>