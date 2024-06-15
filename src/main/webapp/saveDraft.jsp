<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, com.vmail.model.ConnectionProvider" %>




		
<%
	System.out.println("draft");
    String sender = (String) session.getAttribute("email");
    String recipient = request.getParameter("recipient");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");
    int user_id = (int) session.getAttribute("user_id");
    
    int email_id = -1, rows=0;
    String query="",status_message="";
    String vid=request.getParameter("id");
   	if(vid!=null){
    	email_id=Integer.parseInt(vid);
   	}
   	System.out.println(email_id);
    try {
    	Connection con= ConnectionProvider.getConnection();
        if(email_id>0){
        	query = "update emails set recipient_id=?, subject=?, message=? where email_id=?";
        	PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, recipient);
            pstmt.setString(2, subject);
            pstmt.setString(3, message);
            pstmt.setInt(4, email_id);
            rows = pstmt.executeUpdate();
        }
        else{
        	query = "insert into emails (user_id, sender_id, recipient_id, subject, message,folder, status) VALUES (?, ?, ?, ?, ?, 'drafts', 'read')";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, user_id);
        pstmt.setString(2, sender);
        pstmt.setString(3, recipient);
        pstmt.setString(4, subject);
        pstmt.setString(5, message);
        rows = pstmt.executeUpdate();
        }
        if (rows > 0) {
        	      	
        	session.setAttribute("dstatus", "success");
            session.setAttribute("dmessage", "Draft saved successfully");
        	status_message="success";
        } 
        else {
        	session.setAttribute("dstatus", "danger");
        	session.setAttribute("dmessage", "Failed to save draft");
        	status_message="danger";
        }
        
    } 
    catch (Exception e) {
        e.printStackTrace();
    }
    
    out.print(status_message);
%>
