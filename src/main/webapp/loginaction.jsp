<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>

<%
	String email=request.getParameter("email");
	String password=request.getParameter("password");
	String msg,status;
	int s=0;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/vmail","root","root");
		
		String checkQuery = "select user_id, first_name, last_name, gender, password from users where vmailaddress=?";
        PreparedStatement checkStmt = con.prepareStatement(checkQuery);
        checkStmt.setString(1, email);
        ResultSet rs = checkStmt.executeQuery();
        if (rs.next()) {
            String pass=rs.getString(5);
            
            if(pass.equals(password)){
            	session.setAttribute("user_id",Integer.parseInt(rs.getString(1)));
            	session.setAttribute("first_name",rs.getString(2));
            	session.setAttribute("last_name",rs.getString(3));
            	session.setAttribute("gender",rs.getString(4));
            	System.out.println(rs.getString(4));
            	session.setAttribute("email",email);
            	session.setAttribute("login_msg","true");
            	response.sendRedirect("inbox.jsp");
            }
            else{
            	msg ="Incorrect Password.";
            	status= "danger";
            	response.sendRedirect("login.jsp?msg=" + msg+"&status="+status);
            }
        }
        else{
        	msg = "Couldn't find your Account.";
        	status= "danger";
        	response.sendRedirect("resetPassword.jsp?msg=" + msg+"&status="+status);
        }
	} 
	catch (Exception e) {
		msg="Exception Occured...";
		System.out.println("Exception");
	}
	
%>