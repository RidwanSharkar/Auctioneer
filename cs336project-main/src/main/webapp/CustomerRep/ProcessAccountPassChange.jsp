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
	String newPassword = request.getParameter("newPassword");
	ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();

    Statement stmt = conn.createStatement();
    String query = "SELECT end_user_username FROM end_user WHERE end_user_username = '"+username+"'";
    ResultSet rs = stmt.executeQuery(query);

    // check if username even exists
    if(rs.next()){
    	String query2 = "SELECT end_user_password FROM end_user WHERE end_user_password = '"+newPassword+"'";
        ResultSet rs2 = stmt.executeQuery(query);
        // chechk if password is the same
        if(rs2.next()){
        	stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 0;");
    	  	stmt.executeUpdate("UPDATE end_user SET end_user_password = '" +newPassword+ "' WHERE end_user_username = '"+username+"'");
    	  	stmt.executeUpdate("SET FOREIGN_KEY_CHECKS = 1;");
        } else {
        	request.setAttribute("errorMessage", "Password cannot be the same as old password!");
    	    request.getRequestDispatcher("EditAccountInfo.jsp").forward(request, response);
        }

	    request.setAttribute("successMessage", "Password Changed Successfully!");
	    request.getRequestDispatcher("ManageAccounts.jsp").forward(request, response);
    } else {
    	request.setAttribute("errorMessage", "Username "+username+" doesn't exists in the database!");
	    request.getRequestDispatcher("EditAccountInfo.jsp").forward(request, response);
    }
    stmt.close();
    conn.close();

	} catch (SQLException e) {
    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
    request.getRequestDispatcher("ManageAccounts.jsp").forward(request, response);
    
}
%>