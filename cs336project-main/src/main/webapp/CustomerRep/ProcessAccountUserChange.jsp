<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");
/*
out.println("<script>");
out.println("alert('bidtime: " + bidTime + "\\nAuction ID: " + auctionId + "\\nBid Amount: " + bidAmount + "');");
out.println("</script>");
*/

try {
	String newUsername = request.getParameter("newUsername");
	
	ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();

    Statement stmt = conn.createStatement();
    String query = "SELECT end_user_username FROM end_user WHERE end_user_username = '"+newUsername+"'";
    ResultSet rs = stmt.executeQuery(query);

    // check if name already exists
    if(!rs.next()){
	  	stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 0;");
	  	stmt.executeUpdate("UPDATE end_user SET end_user_username = '" +newUsername+ "' WHERE end_user_username = '"+username+"'");
	  	stmt.executeUpdate("UPDATE alert SET end_user_username = '" +newUsername+ "' WHERE end_user_username = '"+username+"'");
	  	stmt.executeUpdate("UPDATE auto_bid SET end_user_username = '" +newUsername+ "' WHERE end_user_username = '"+username+"'");
	  	stmt.executeUpdate("UPDATE auction SET end_user_username = '" +newUsername+ "' WHERE end_user_username = '"+username+"'");
	  	stmt.executeUpdate("UPDATE bid SET end_user_username = '" +newUsername+ "' WHERE end_user_username = '"+username+"'");
	  	stmt.executeUpdate("UPDATE item_alert SET end_user_username = '" +newUsername+ "' WHERE end_user_username = '"+username+"'");
	  	stmt.executeUpdate("UPDATE rep_message SET end_user_username = '" +newUsername+ "' WHERE end_user_username = '"+username+"'");
	  	stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 1;");
  	
    
	    request.setAttribute("successMessage", "Username Changed Successfully!");
	    request.getRequestDispatcher("ManageAccounts.jsp").forward(request, response);
    } else {
    	request.setAttribute("errorMessage", "Username already exists in the database!");
	    request.getRequestDispatcher("EditAccountInfo.jsp").forward(request, response);
    }
    stmt.close();
    conn.close();

	} catch (SQLException e) {
    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
    request.getRequestDispatcher("ManageAccounts.jsp").forward(request, response);
    
}
%>