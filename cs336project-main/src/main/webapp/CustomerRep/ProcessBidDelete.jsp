<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>

<%
String username = request.getParameter("username");
Float bidAmount = Float.parseFloat(request.getParameter("bidAmount"));
String auctionId = request.getParameter("auctionId");
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String bidTime = request.getParameter("bidTime");
/*
out.println("<script>");
out.println("alert('bidtime: " + bidTime + "\\nAuction ID: " + auctionId + "\\nBid Amount: " + bidAmount + "');");
out.println("</script>");
*/

try {
    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();
    Statement stmt = conn.createStatement();
	
    // excludes bids, messages, auctions, autobids for stuff like sales repo, 
  	stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 0;");
    stmt.executeUpdate("DELETE FROM bid WHERE end_user_username = '" + username + "' AND auction_id = '" +auctionId+ "' AND bid_date_time ='" + bidTime + "'");
  	stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 1;");

    
    request.setAttribute("successMessage", "Bid from "+username+" deleted successfully!");
    request.getRequestDispatcher("EditBids.jsp").forward(request, response);

    stmt.close();
    conn.close();
    
} catch (SQLException e) {
    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
    request.getRequestDispatcher("ManageAccounts.jsp").forward(request, response);
}
%>