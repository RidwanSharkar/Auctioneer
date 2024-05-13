<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Submit Auction</title>
</head>
<body>
	<form action="AuctionDetailsAndBidding.jsp" method="post">
	    <label for="auctionId">Please Enter An AuctionID To View Further Details and Bid:</label>
	    <input type="text" id="auctionId" name="auctionId" required>
	    <input type="submit" value="Submit">
	</form>


	<form action="AuctionBidHistory.jsp" method="post">
	    <label for="auctionId">Please Enter An AuctionID To View Bid History:</label>
	    <input type="text" id="auctionId" name="auctionId" required>
	    <input type="submit" value="Submit">
	</form>
	
	<form action="EndUserBidHistory.jsp" method="post">
	    <label for="userId">Please Enter An User's Username To View Their Bid History:</label>
	    <input type="text" id="userId" name="userId" required>
	    <input type="submit" value="Submit">
	</form>
	
	<form action="EndUserAuctionHistory.jsp" method="post">
	    <label for="userId">Please Enter An User's Username To View Their Auction History:</label>
	    <input type="text" id="userId" name="userId" required>
	    <input type="submit" value="Submit">
	</form>
	
	<form action="SpecificSearch.jsp" method="post">
	    <label for="partName">Please Enter A Part Type to Conduct a Specific Search:</label>
	    <input type="text" id="partName" name="partName" required>
	    <input type="submit" value="Submit">
	</form>
	
	<form action="PlaceAutomaticBid.jsp" method="post">
	    <label for="auctionId">Place An Automatic Bid On AuctionID:</label>
	    <input type="text" id="auctionId" name="auctionId" required>
	    <label for="upperLimit">With Upper Limit:</label>
	    <input type="text" id="upperLimit" name="upperLimit" required>
	    <input type="submit" value="Submit">
	</form>
	
	
		
	
	
    <%
    	//Table Row: auction id / pc part type / brand / closing time 
    	
    	try {
		    ApplicationDB db = new ApplicationDB();
		    Connection conn = db.getConnection();
		
		    // Query 1: Count of tuples in pc_part table
		    Statement stmt1 = conn.createStatement();
		    String query1 = "SELECT * FROM auction LEFT JOIN pc_part ON auction.pc_part = pc_part.item_id WHERE pc_part.status = 0";
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
		    
		%>
		   <table>
			    <thead>
			        <tr>
			            <!-- Display column names (headers) -->
			            <% for (String columnName : columnNames) { %>
			                <th><%= columnName %></th>
			            <% } %>
			        </tr>
			    </thead>
			    <tbody>
			        <!-- Display data rows -->
			        <% for (ArrayList<String> row : fullResultSet) { %>
			            <tr>
			                <% for (String value : row) { %>
			                    <td><%= value %></td>
			                <% } %>
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