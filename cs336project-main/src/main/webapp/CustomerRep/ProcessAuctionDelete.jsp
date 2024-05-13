<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>

<%
String auctionId = request.getParameter("auctionId");



try {
    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();
    Statement stmt = conn.createStatement();

  	stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 0;");
    stmt.executeUpdate("DELETE FROM auction WHERE auction_id = '" +auctionId+ "'");
  	stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 1;");
  	

    request.setAttribute("successMessage", "Auction "+auctionId+" deleted successfully!");
    request.getRequestDispatcher("EditAuctions.jsp").forward(request, response);

    stmt.close();
    conn.close();
    
} catch (SQLException e) {
    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
    request.getRequestDispatcher("EditAuctions.jsp").forward(request, response);
}
%>