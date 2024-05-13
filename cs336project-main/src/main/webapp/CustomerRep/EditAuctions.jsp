<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Bid History</title>
</head>
<body>
<%
    	//Table Row: auction id / pc part type / brand / closing time 
    	String username = request.getParameter("username");
    	try {
    		String successMessage = (String)request.getAttribute("successMessage");
            if(successMessage != null && !successMessage.isEmpty()) {
    		%>
                <p style="color: green;"><%= successMessage %></p>
    		<%
            }
            
            String errorMessage = (String)request.getAttribute("errorMessage");
            if(errorMessage != null && !errorMessage.isEmpty()) {
    		%>
                <p style="color: red;"><%= errorMessage %></p>
    		<%
            }
		    ApplicationDB db = new ApplicationDB();
		    Connection conn = db.getConnection();
		
		    Statement stmt1 = conn.createStatement();
		    String query1 = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE pc_part.status = 0 AND end_user_username = '"+username+"'";
		    ResultSet rs1 = stmt1.executeQuery(query1);
		    
		    ArrayList<ArrayList<String>> fullResultSet = new ArrayList<>();
		    
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    
		    while(rs1.next()){
		    	String auctionId = rs1.getString(1);
		    	String partType = "";
		    	if(rs1.getObject(11) != null){
		    		partType = "cpu";
		    	}
		    	else if (rs1.getObject(14) != null){
		    		partType = "ram";
		    	}
		    	else if (rs1.getObject(16) != null){
		    		partType = "motherboard";
		    	}
		    	else if (rs1.getObject(17) != null){
		    		partType = "gpu";
		    	}
		    	else if (rs1.getObject(19) != null){
		    		partType = "power supply";
		    	}
		    	else if (rs1.getObject(21) != null){
		    		partType = "hdd";
		    	}
		    	else if (rs1.getObject(23) != null){
		    		partType = "sdd";
		    	}
		    	
		    	ArrayList<String> arrList = new ArrayList<>();
		    	arrList.add(auctionId); 
		    	arrList.add(partType);
		    	//Brand
		        arrList.add(rs1.getString(10));
		    	//Closing Date
		    	Timestamp closingTime = rs1.getTimestamp(4);
		        arrList.add(dateFormat.format(closingTime));
		        
		        fullResultSet.add(arrList);
		    	
		    }
		    
		    ArrayList<String> columnNames = new ArrayList<>();
		    columnNames.add("Auction Id");
		    columnNames.add("Part Type");
		    columnNames.add("Brand");
		    columnNames.add("Closing Time");
		    columnNames.add("Action");
		    
		%>
		   <table>
			    <thead>
			        <tr>
			            <% for (String columnName : columnNames) { %>
			                <th><%= columnName %></th>
			            <% } %>
			        </tr>
			    </thead>
			    <tbody>
			        <% for (ArrayList<String> row : fullResultSet) { %>
			            <tr>
			                <% for (int i = 0; i < row.size(); i++) { %>
			                    <td><%= row.get(i) %></td>
			                <% } %>
			                <td>
			                    <form method="post" action="ProcessAuctionDelete.jsp">
			                        <input type="hidden" name="auctionId" value="<%= row.get(0) %>">
			                        <input type="submit" value="Delete">
			                    </form>
			                </td>
			            </tr>
			        <% } %>
			    </tbody>
			</table>
		    
		<%
		stmt1.close();
		rs1.close();
		conn.close();
		} catch (SQLException e) {
		    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
		    request.getRequestDispatcher("CreateEndUserAccount.jsp").forward(request, response);
		}
    
		%>
</body>
</html>