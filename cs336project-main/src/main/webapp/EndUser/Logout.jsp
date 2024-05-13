<%
// Retrieve the username attribute before invalidating the session
String username = (String) session.getAttribute("username");

// Invalidate the session
session.invalidate();

// Redirect to the login page
response.sendRedirect("EndUserLogin.jsp");
%>