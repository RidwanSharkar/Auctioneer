<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<%@ include file="DatabaseUpdates.jsp" %>

  <%
  String repId = request.getParameter("repId");
  String messageText = request.getParameter("messageText");
  if (repId != null && !messageText.isEmpty()) {
  	try {
  	String userId = (String) session.getAttribute("username");
    ApplicationDB db1 = new ApplicationDB();
    Connection conn1 = db1.getConnection();

    // Query 1: Count of tuples in rep_message table
    Statement stmt3 = conn1.createStatement();
    String query3 = "SELECT COUNT(*) FROM rep_message";
    ResultSet rs2 = stmt3.executeQuery(query3);
    
    rs2.next();
    
    int msgCount = rs2.getInt(1);
    
    String msgId = userId + msgCount;
    
    Statement stmt4 = conn1.createStatement();
    String query2 = "INSERT INTO rep_message VALUES ('" + msgId + "' , '" + userId + "' , '" + repId + "' , '" + messageText + "' )";
    stmt4.executeUpdate(query2);
    
    request.setAttribute("successMessage", "Messaged successfully!");
    %>
    <%@ include file="ViewCustomerRep.jsp" %>
    <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
    <%
	
	
stmt3.close();
rs2.close();
conn1.close();	
} catch (SQLException e) {
    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
    request.getRequestDispatcher("Success.jsp").forward(request, response);
}
  	
  	
  	
  } else {
      // Handle the case where no auction ID was submitted
      %>
      <p>Please enter an auction ID to view details and bid.</p>
      <%
  }
  %>
