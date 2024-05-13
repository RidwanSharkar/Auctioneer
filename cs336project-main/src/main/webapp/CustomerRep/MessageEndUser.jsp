<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>


  <%
  String endUserId = request.getParameter("endUserId");
  String messageText = request.getParameter("messageText");
  if (endUserId != null && !messageText.isEmpty()) {
  	try {
  	String repId = (String) session.getAttribute("username");
    ApplicationDB db1 = new ApplicationDB();
    Connection conn1 = db1.getConnection();
    
 	// Get the current date and time
    LocalDateTime now = LocalDateTime.now();

    // Format the date and time as a string
    String formattedDateTime = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

    
    
    Statement stmt6 = conn1.createStatement();
	stmt6.executeUpdate("INSERT INTO alert VALUES ('" + endUserId + "' , '" + formattedDateTime + "' , 'Message From Customer Representative: " + repId + " Message: " + 
			messageText + "' )");
	stmt6.close();
    
    
    
    request.setAttribute("successMessage", "Alert set successfully!");
    %>
    <%@ include file="ViewMessages.jsp" %>
    <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
    <%
	
	

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
