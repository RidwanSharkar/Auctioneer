<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
String username = (String) session.getAttribute("username");

session.invalidate();
/*
out.println("<script>");
out.println("alert('Username: " + username + "\\nAuction ID: " + auctionId + "\\nBid Amount: " + bidAmount + "');");
out.println("</script>");
*/

try {
    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();
    Statement stmt = conn.createStatement();
	
  	stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 0;");
    stmt.executeUpdate("DELETE FROM item_alert WHERE end_user_username = '" + username + "'");
    stmt.executeUpdate("DELETE FROM bid WHERE end_user_username = '" + username + "'");
    stmt.executeUpdate("DELETE FROM auto_bid WHERE end_user_username = '" + username + "'");
    stmt.executeUpdate("DELETE FROM alert WHERE end_user_username = '" + username + "'");
    stmt.executeUpdate("DELETE FROM end_user WHERE end_user_username = '" + username + "'");
  	stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 1;");
  	
  	// need to fix updating to whenever an account is deleted close the auction
    
    
    
    
    

    stmt.close();
    conn.close();
    
    

	 // Redirect to the login page
	 response.sendRedirect("EndUserLogin.jsp");
    
} catch (SQLException e) {
    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
    request.getRequestDispatcher("ManageAccounts.jsp").forward(request, response);
}
%>