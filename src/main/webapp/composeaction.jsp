<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, com.vmail.model.ConnectionProvider" %>
<%
	String sender=(String)session.getAttribute("email");
	String recipient=request.getParameter("recipient");
	String subject=request.getParameter("subject");
	String message=request.getParameter("message");
	int user_id=(int)session.getAttribute("user_id");
	int recipient_user_id=-1,email_id=-1, rows=0;
	String vid = request.getParameter("email_id");
	String query ="";
	PreparedStatement pstmt;
	if(vid!=null){
    	email_id=Integer.parseInt(vid);
   	}
	
	
	System.out.println(email_id+" compose action");
	
	
	try {
		Connection con= ConnectionProvider.getConnection();
		if(email_id>0){
			query = "update emails set recipient_id=?, subject=?, message=?, folder='sent' where email_id=? and folder='drafts'";
			pstmt=con.prepareStatement(query);
			pstmt.setString(1, recipient);
            pstmt.setString(2, subject);
            pstmt.setString(3, message);
            pstmt.setInt(4, email_id);
			rows = pstmt.executeUpdate();
			System.out.println("Updated");
		}
		
		else{
			query = "insert into emails (user_id, sender_id, recipient_id, subject, message, folder,status) VALUES (?, ?, ?, ?, ?, 'sent','read')";
			pstmt=con.prepareStatement(query);
			pstmt.setInt(1, user_id);
        	pstmt.setString(2, sender);
        	pstmt.setString(3, recipient);
        	pstmt.setString(4, subject);
        	pstmt.setString(5, message);
			rows = pstmt.executeUpdate();
		}
        
        if(rows > 0) {
        	query = "select user_id from users where vmailaddress=?";
    		pstmt=con.prepareStatement(query);
    		pstmt.setString(1, recipient);
    		ResultSet rs= pstmt.executeQuery();
    		if(rs.next())
    			recipient_user_id=rs.getInt(1);
    		
    		query = "insert into emails (user_id, sender_id, recipient_id, subject, message, folder,status) VALUES (?, ?, ?, ?, ?, 'inbox','unread')";
    		pstmt=con.prepareStatement(query);
    		pstmt.setInt(1, recipient_user_id);
            pstmt.setString(2, sender);
            pstmt.setString(3, recipient);
            pstmt.setString(4, subject);
            pstmt.setString(5, message);
    		int rowr = pstmt.executeUpdate();
    		if(rowr > 0) {
    			
        	request.setAttribute("status", "success");
        	request.setAttribute("message", "Email sent successfully!");
    		}
        	%>
            <jsp:forward page="inbox.jsp"></jsp:forward>
            <%
        } else {
        	
            request.setAttribute("status", "danger");
            request.setAttribute("message", "Unable to sent email!");
            %>
            
            <jsp:forward page="compose.jsp"></jsp:forward>
            <%
        }
        con.close();
    } catch (Exception e) {
    	
        request.setAttribute("status", "danger");
        request.setAttribute("message", "Exception to sent email!");
        %>
        <jsp:forward page="compose.jsp"></jsp:forward>
        <%
    }
%>