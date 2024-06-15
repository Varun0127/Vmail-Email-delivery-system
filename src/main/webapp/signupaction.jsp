<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>

<%
	String first_name=request.getParameter("first_name");
	String last_name=request.getParameter("last_name");
	String gender=request.getParameter("gender");
	String date_of_birth=request.getParameter("date_of_birth");
	String country=request.getParameter("country");
	String vmailaddress=request.getParameter("vmailaddress")+"@vmail.com";
	String password=request.getParameter("password");
	String msg,status;
	int s=0;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/vmail","root","root");
		
		String checkQuery = "select * from users where vmailaddress=?";
        PreparedStatement checkStmt = con.prepareStatement(checkQuery);
        checkStmt.setString(1, vmailaddress);
        ResultSet rs = checkStmt.executeQuery();
        if (rs.next()) {
        	status="danger";
            msg = "Vmail Address already exists";
        }
        else{
			PreparedStatement ps=con.prepareStatement("insert into users (first_name, last_name, gender, date_of_birth, country, vmailaddress, password) VALUES (?, ?, ?, ?, ?, ?, ?)");
			ps.setString(1, first_name);
        	ps.setString(2, last_name);
	        ps.setString(3, gender);
    	    ps.setString(4, date_of_birth);
	        ps.setString(5, country);
    	    ps.setString(6, vmailaddress);
        	ps.setString(7, password);
       		s=ps.executeUpdate();
       	
       		if(s>0){
       			msg="Sign up Successfully...";
       			status="success";
       			response.sendRedirect("login.jsp?msg=" + msg+"&status="+status);
       			return;
       		}
       		else{
       			status="danger";
       			msg="Sign up Failed...";	
       		}
        }
       	
        System.out.println(s);
	} catch (Exception e) {
		msg="Exception Occured...";
		status="danger";
		System.out.println("Exception");
	}
	response.sendRedirect("signup.jsp?msg=" + msg+"&status="+status);
%>

