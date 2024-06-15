   <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.sql.*, java.util.ArrayList, java.util.List, com.vmail.model.Email, com.vmail.model.ConnectionProvider" %>
<%
	Email email = new Email();
	String sender_name="";
   try {

	   Connection conn= ConnectionProvider.getConnection(); 
       //int email_id=Integer.parseInt(request.getParameter("id"));
       String status= request.getParameter("status");
       PreparedStatement pstmt=null;
       if(status.equals("unread")){
       	pstmt = conn.prepareStatement("update emails set status='read' where email_id=?");
       	pstmt.setInt(1,  Integer.parseInt(request.getParameter("id")));
       	int i = pstmt.executeUpdate();
       }
       pstmt = conn.prepareStatement("SELECT * FROM Emails WHERE email_id = ?");
       pstmt.setInt(1,  Integer.parseInt(request.getParameter("id")));
       ResultSet rs = pstmt.executeQuery();
        
        while(rs.next()) {
            email.setEmailId(rs.getInt("email_id"));
            email.setSenderId(rs.getString("sender_id"));
            email.setRecipientId(rs.getString("recipient_id"));
            email.setSubject(rs.getString("subject"));
            email.setMessage(rs.getString("message"));
            email.setFolder(rs.getString("folder"));
            email.setStatus(rs.getString("status"));
            email.setCreatedAt(rs.getString("created_at"));
            email.setUpdatedAt(rs.getString("updated_at"));
            
        }
        
        pstmt = conn.prepareStatement("SELECT * FROM users WHERE vmailaddress = ?");
        pstmt.setString(1, email.getSenderId());
        rs = pstmt.executeQuery();
        while(rs.next()) {
        	sender_name=rs.getString("first_name")+" "+rs.getString("last_name");
        }
        	
        conn.close();
        request.setAttribute("email", email);
        
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Vmail - Inbox</title>
	<!-- plugins:css -->
  <link rel="stylesheet" href="vendors/feather/feather.css">
  <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" type="text/css" href="js/select.dataTables.min.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="images/favicon.svg" />
  <!-- material design icons --> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/7.4.47/css/materialdesignicons.min.css" integrity="sha512-/k658G6UsCvbkGRB3vPXpsPHgWeduJwiWGPCGS14IQw3xpr63AEMdA8nMYG2gmYkXitQxDTn6iiK/2fD4T87qA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <!-- Jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>


</head>


<body>

		<%
			String login_msg = (String) session.getAttribute("login_msg");
			if(login_msg==null){											//checking for valid session
				request.setAttribute("session_out","Session out! Please login again.");
				request.setAttribute("status", "danger");
		%>
				<jsp:forward page="login.jsp"></jsp:forward>
		<%
			}
		%>
			
	           
        <div class="container-scroller">

            <!-- partial:partials/_navbar.html -->
            <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
                <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
                    <a class="navbar-brand brand-logo mr-5" href="inbox.jsp"><img src="images/logo.svg" class="mr-2" alt="logo"/></a>
                    <a class="navbar-brand brand-logo-mini" href="inbox.jsp"><img src="images/logo-mini.svg" alt="logo"/></a>
                </div>
                <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
                    <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
                        <span class="icon-menu"></span>
                    </button>
                    <ul class="navbar-nav mr-lg-2">
                        <li class="nav-item nav-search d-none d-lg-block">
                            <div class="input-group">
                                <div class="input-group-prepend hover-cursor" id="navbar-search-icon">
                                    <span class="input-group-text" id="search">
                                        <i class="icon-search"></i>
                                    </span>
                                </div>
                                <input type="text" class="form-control" id="navbar-search-input" placeholder="Search now" aria-label="search" aria-describedby="search">
                            </div>
                        </li>
                    </ul>
                    <ul class="navbar-nav navbar-nav-right">
                        <li class="nav-item nav-profile dropdown ">
                            <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">
                                <img src="images/faces/face21.jpg" class="m-2" alt="profile">
                                <span class="font-weight-bold font-italic">Hi, <%= session.getAttribute("first_name") %></span>
                            </a>
                            <div class="pt-0 dropdown-menu dropdown-menu-right navbar-dropdown" style="min-width:20vw" aria-labelledby="profileDropdown">
                            	<div class="bg-secondary pt-3" >
                            		<div class="mb-3 text-center">	
                            			<img src="images/faces/face21.jpg"alt="profile">	
                            		</div>
                            		<h6 class="mb-0 text-center "><%= session.getAttribute("first_name")+" "+ session.getAttribute("last_name")%></h6>
                            		<div class="dropdown-header text-center text-xs text-light pt-0"><%= session.getAttribute("email") %></div>
                            	</div>
                            	<div class="dropdown-divider"></div>
                                <a class="dropdown-item mt-2">
                                    <i class="ti-settings text-primary"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="logout.jsp">
                                    <i class="ti-power-off text-primary"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                    </ul>
                    <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
                        <span class="icon-menu"></span>
                    </button>
                </div>
            </nav>
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
            <!-- partial:partials/_settings-panel.html -->
                <div class="theme-setting-wrapper">
                    <div id="settings-trigger"><i class="ti-settings"></i></div>
                    <div id="theme-settings" class="settings-panel">
                        <i class="settings-close ti-close"></i>
                        <p class="settings-heading">SIDEBAR SKINS</p>
                        <div class="sidebar-bg-options selected" id="sidebar-light-theme">
                            <div class="img-ss rounded-circle bg-light border mr-3"></div>Light
                        </div>
                        <div class="sidebar-bg-options" id="sidebar-dark-theme">
                            <div class="img-ss rounded-circle bg-dark border mr-3"></div>Dark 
                        </div>
                        <p class="settings-heading mt-2">HEADER SKINS</p>
                        <div class="color-tiles mx-0 px-4">
                            <div class="tiles success"></div>
                            <div class="tiles warning"></div>
                            <div class="tiles danger"></div>
                            <div class="tiles info"></div>
                            <div class="tiles dark"></div>
                            <div class="tiles default"></div>
                        </div>
                    </div>
                </div>
                <!-- partial -->

                <!-- partial:partials/_sidebar.html -->
                <nav class="sidebar sidebar-offcanvas" id="sidebar">
                  <ul class="nav">
                    <li class="nav-item">
                        <a class="nav-link" href="compose.jsp">
                            <i class="mdi mdi-border-color menu-icon"></i>
                            <span class="menu-title">Compose</span>
                        </a>
                    </li>
                    <li class="nav-item <%=email.getFolder().equals("inbox")?"active":""%>">
                        <a class="nav-link" href="inbox.jsp">
                            <i class="mdi mdi-inbox menu-icon"></i>
                            <span class="menu-title">Inbox</span>
                        </a>
                    </li>
                    <li class="nav-item <%=email.getFolder().equals("sent")?"active":""%>" >
                        <a class="nav-link" href="sent.jsp">
                            <i class="mdi mdi-send menu-icon"></i>
                            <span class="menu-title">Sent</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="drafts.jsp">
                            <i class="mdi mdi-note-outline menu-icon"></i>
                            <span class="menu-title">Drafts</span>
                        </a>
                    </li>
                    <li class="nav-item <%=email.getFolder().equals("bin")?"active":""%>">
                        <a class="nav-link" href="bin.jsp">
                            <i class="mdi mdi-delete menu-icon"></i>
                            <span class="menu-title">Bin</span>
                        </a>
                    </li>
                
                  </ul>
                </nav>

       

        


                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <div class="col-md-12 grid-margin">
                                <div class="card">
                                	<div class="card-body">
                                		<div class="row">
                							<div class="col-4">
                                				
                                				<a href="<%=email.getFolder() %>.jsp" class="mr-5" title="Back to <%=email.getFolder() %>"><i class="mdi mdi-arrow-left"></i></a>
                                				
                                				
                                				<%if(!email.getFolder().equals("bin")) {%>
                                				<a href="moveToBin.jsp?id=<%=email.getEmailId()%>&folder=<%=email.getFolder() %>" class="mr-4" title="Delete"><i class="mdi mdi-delete deleteEmail"></i></a>
                                				
                                				<%} 
                                				else{
                                				%>
                                				<a href="deleteMail.jsp?id=<%=email.getEmailId()%>" class="mr-4" title="Delete forever"><i class="mdi mdi-delete deleteEmail"></i></a>
                                				<a href="restoreMail.jsp?id=<%=email.getEmailId()%>" class="mr-4" title="Restore mail"><i class="mdi mdi-file-restore" title="Restore mail"></i></a>
                                				<%
                                				}
                                				%>
                                				<%if(!email.getFolder().equals("sent")) {%>
                                				<a href="mark_Read_Unread.jsp?id=<%=email.getEmailId()%>&status=<%=email.getStatus() %>&folder=<%=email.getFolder() %>" title="Mark as unread"><i class="mdi mdi-email-mark-as-unread markUnread"></i></a>
                                                <%} %>
                                			</div>
                  						</div>
                                		<div class="row ml-5 mt-5">
                                			
                                				<div class="col-12">
                                        			<h3><%=email.getSubject().equals("")?"(no subject)":email.getSubject()%></h3>
                                    			</div>
                                		</div>
                                		<div class="row ml-5 mt-3">
                                    	    <div class="col-12">
                                    	    <span class="font-weight-bold"><%=sender_name%></span>, <small><span class="text-muted">&lt;<%=email.getSenderId()%>&gt;</span></small>
                                        		<small class="float-right text-muted"><%=email.getCreatedAt().substring(0,16)%></small>
                                        	</div>
                                    	</div>
                                		<div class="row ml-5 mt-0">
		                                    <div class="col-12">
		                                        <small class="text-muted">to, <span ><%=email.getSenderId()%></span></small>
        		                            </div>
                		                </div>
                		                <div class="row ml-5 mt-3">
                                    		<div class="col-12">
                                        		<p><%=email.getMessage()%></p>
                                    		</div>
                                		</div>	
                                		<div class="row ml-5 mt-3">
                                        	<div class="col-12">
                                        		<a href="compose.jsp?id=<%=email.getEmailId()%>&action=reply"><button type="submit" class="btn btn-outline-primary font-weight-medium auth-form-btn pl-3"><i class="mdi mdi-reply"></i> &nbsp;Reply</button></a>
                                        		<a href="compose.jsp?id=<%=email.getEmailId()%>&action=forward"><button type="submit" class="btn btn-outline-primary  font-weight-medium auth-form-btn pl-3 ml-2"><i class="mdi mdi-share"></i> &nbsp;Forward</button></a>
                                        		
                                    		</div>
                                		</div>
                		                
                  						
                                    </div>     
                                </div>
                            </div>
                        </div>
                    </div>
                

                    <!-- partial:../../partials/_footer.html -->
                    <footer class="footer">
                        <div class="d-sm-flex justify-content-center justify-content-sm-between">
                            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2021.  Vmail. All rights reserved.</span>
                            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="ti-heart text-danger ml-1"></i></span>
                        </div>
                    </footer>
                    <!-- partial -->
                </div>
        </div>
    </div>
    <!-- container-scroller -->

	<!-- plugins:js -->
  <script src="vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <script src="vendors/chart.js/Chart.min.js"></script>
  <script src="vendors/datatables.net/jquery.dataTables.js"></script>
  <script src="vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
  <script src="js/dataTables.select.min.js"></script>

  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="js/off-canvas.js"></script>
  <script src="js/hoverable-collapse.js"></script>
  <script src="js/template.js"></script>
  <script src="js/settings.js"></script>
  <script src="js/todolist.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="js/dashboard.js"></script>
  <script src="js/Chart.roundedBarCharts.js"></script>
  <!-- End custom js for this page-->
  

</body>
</html>
 