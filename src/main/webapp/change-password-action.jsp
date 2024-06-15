<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%
	
	String newPassword= request.getParameter("new-password");
	String email= request.getParameter("emailPhone");
	System.out.println(email);
	System.out.println(newPassword);
	try {
    	Class.forName("com.mysql.jdbc.Driver");
    	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vmail", "root", "root"); 
    	String query = "update users set password=? WHERE vmailaddress=?";
    	PreparedStatement pstmt = conn.prepareStatement(query);
    	pstmt.setString(1, newPassword);
    	pstmt.setString(2, email);
		int i = pstmt.executeUpdate();
		if(i>0){
			session.invalidate();
%>
		<jsp:forward page="login.jsp">
		<jsp:param value="Password reset, Login here." name="passwordmsg"/>
		</jsp:forward>
<%			
		}
	}
	catch(Exception e){
		
	}
%>