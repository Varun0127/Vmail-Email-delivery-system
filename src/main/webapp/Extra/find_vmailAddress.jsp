<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
String n=request.getParameter("val");
if(n.length()>0){
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/vmail","root","root");
		PreparedStatement ps=con.prepareStatement("select username from users where username='"+n+"'");
		ResultSet rs=ps.executeQuery();
		if(rs.next()){
			out.print("Address not available.");
		}
		else{
			out.print("Available");
		}
		con.close();
	}catch(Exception e){
		System.out.println("Username Exception");
		}
}//end of if
%>