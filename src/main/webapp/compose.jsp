<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*, java.util.ArrayList, java.util.List, com.vmail.model.ConnectionProvider" %>
<%
String  sender_id=null,recipient_id=null,subject=null,message=null, created_at=null, forward_msg=null;
int email_id=-1;
String action=request.getParameter("action");
   try {
	   	Connection conn= ConnectionProvider.getConnection(); 
	   	String vid=request.getParameter("id");
	   	if(vid!=null){
        	email_id=Integer.parseInt(vid);
        	
	   	}
	   	
        PreparedStatement pstmt=null;
        pstmt = conn.prepareStatement("select * from emails where email_id=?");
        pstmt.setInt(1,  email_id);
        ResultSet rs= pstmt.executeQuery();
        
        if(rs.next()){
        	sender_id=rs.getString(3);
        	recipient_id= rs.getString(4);
        	subject= rs.getString(5);
        	message= rs.getString(6);
        	created_at=rs.getString(9);
        }
        //request.setAttribute("e_id", email_id);
    	//System.out.println(email_id+" compose");
        
        conn.close();
        if("reply".equals(action)||"forward".equals(action)){
        	email_id=-1;
        }
        if("forward".equals(action)){
        	forward_msg="---------- Forwarded message ---------\n From: <"+sender_id+">\n Date: "+ created_at +"\n Subject: "+subject +"\n To: <"+ recipient_id+">\n\n";
        }
        
        
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
    
    
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vmail - Compose Mail</title>

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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/7.4.47/css/materialdesignicons.min.css"
        integrity="sha512-/k658G6UsCvbkGRB3vPXpsPHgWeduJwiWGPCGS14IQw3xpr63AEMdA8nMYG2gmYkXitQxDTn6iiK/2fD4T87qA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
     
     
    <!-- iziToast CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/izitoast/dist/css/iziToast.min.css">

	
	

</head>

<body>
		
		<%
			String sentstatus = (String) request.getAttribute("status"); //Unable to sent mail setAttribute() from composeaction.jsp 
			String login_msg = (String) session.getAttribute("login_msg"); //checking for valid session
			if(login_msg==null){
				request.setAttribute("session_out","Session out! Please login again.");
				request.setAttribute("status", "danger");
		%>
				<jsp:forward page="login.jsp"></jsp:forward>
		<%
			}
			if ("danger".equals(sentstatus)) {
				%>
			    <script>
			        $(document).ready(function() {
			            toastr.warning('Unable to send Email!', '', { positionClass: 'toast-top-center', closeButton: true, timeOut: 3000 });
			        });
			    </script>
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
                            <input type="text" class="form-control" id="navbar-search-input" placeholder="Search now"
                                aria-label="search" aria-describedby="search">
                        </div>
                    </li>
                </ul>
                <ul class="navbar-nav navbar-nav-right">
                    <li class="nav-item nav-profile dropdown ">
                            <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">
                                <% if("Male".equals(session.getAttribute("gender"))){ %>
                                	<img src="images/faces/face21.jpg" class="m-2" alt="profile">
                               	<%}else {%>
                           			<img src="images/faces/face23.jpg" class="m-2" alt="profile">
                           		<%} %>
                                <span class="font-weight-bold font-italic">Hi, <%= session.getAttribute("first_name") %></span>
                            </a>
                            <div class="pt-0 dropdown-menu dropdown-menu-right navbar-dropdown" style="min-width:20vw" aria-labelledby="profileDropdown">
                            	<div class="bg-secondary pt-3" >
                            		<div class="mb-3 text-center">	
                            			<% if("Male".equals(session.getAttribute("gender"))){ %>
                                			<img src="images/faces/face21.jpg" class="m-2" alt="profile">
                                		<%}else {%>
                                			<img src="images/faces/face23.jpg" class="m-2" alt="profile">
                                		<%} %>	
                            		</div>
                            		<h6 class="mb-0 text-center "><%= session.getAttribute("first_name")+" "+ session.getAttribute("last_name")%></h6>
                            		<div class="dropdown-header text-center text-xs text-light pt-0"><%= session.getAttribute("email") %></div>
                            	</div>
                            	<div class="dropdown-divider"></div>
                                <a href="settings.jsp" class="dropdown-item mt-2">
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
                <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button"
                    data-toggle="offcanvas">
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
                    <li class="nav-item active ">
                        <a class="nav-link" href="compose.jsp">
                            <i class="mdi mdi-border-color menu-icon"></i>
                            <span class="menu-title">Compose</span>
                        </a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="inbox.jsp">
                            <i class="mdi mdi-inbox menu-icon"></i>
                            <span class="menu-title">Inbox</span>
                        </a>
                    </li>
                    <li class="nav-item">
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
                    <li class="nav-item">
                        <a class="nav-link" href="bin.jsp">
                            <i class="mdi mdi-delete menu-icon"></i>
                            <span class="menu-title">Bin</span>
                        </a>
                    </li>

                </ul>
            </nav>
            <!-- partial -->

            <div class="main-panel">
                <div class="content-wrapper">
                    <div class="row">
                        <div class="col-md-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title">Compose Mail</h4>
                                    <form class="forms-sample" action="composeaction.jsp" onsubmit="return validateForm()">
                                    	
                                        	<input type="hidden" name="email_id" value="<%= email_id %>">
                                        
                                        <div class="form-group">
                                            <label for="to">To</label>
                                            <input type="email" class="form-control" name="recipient" id="recipient" value="<%= action!=null && action.equals("reply")?sender_id:"" %><%= action==null && recipient_id!=null?recipient_id:"" %>" placeholder="To">
                                            <span id="emailError" class="text-danger"></span>
                                        </div>
                                        <div class="form-group">
                                            <label for="subject">Subject</label>
                                            <input type="text" class="form-control" id="subject" name="subject" value="<%= action!=null && action.equals("reply")?(subject.contains("Re:")?subject:"Re: "+subject):"" %><%="forward".equals(action)?subject:"" %><%= action==null && subject!=null?subject:"" %>" placeholder="Subject">
                                        </div>
                                       
                                        <div class="form-group">
                                            <label for="message">Message</label>
                                            <textarea class="form-control" name="message" id="message"  rows="10"><%="forward".equals(action)?forward_msg + message:(message!=null?message:"") %></textarea>
                                        </div>
                                        
                                        <button type="submit" class="btn btn-primary mr-2">Send</button>
                                        <button class="btn btn-light">Cancel</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- partial:../../partials/_footer.html -->
                <footer class="footer">
                    <div class="d-sm-flex justify-content-center justify-content-sm-between">
                        <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2021. Vmail. All rights reserved.</span>
                        <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i
                                class="ti-heart text-danger ml-1"></i></span>
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
    <script src="https://cdn.jsdelivr.net/npm/izitoast"></script>
    
    <script>
    	let mailSent = false;
        function validateForm() {
            let isValid = true;
            const email = document.getElementById('recipient').value;
            const subject = document.getElementById('subject').value;
         	// Resetting error messages
            document.getElementById('emailError').innerText = '';
            
            console.log("hello")
         	// Validation for Email
            if (email === '') {
                document.getElementById('emailError').innerText = 'Recipient id is required.';
                isValid = false;
            }
            else{
            	$.ajax({
                    url: 'checkVmail.jsp',
                    type: 'POST',
                    data: { vmailAddress: email },
                    async: false,
                    success: function(response) {
                        if (response.trim() === 'available') {
                            document.getElementById('emailError').innerText = "Couldn't find recipient";
                            isValid = false;
                        }
                    }
                });
            }
            if (subject.trim() === '' && isValid === true) {
                isValid = confirm('Subject is empty. Do you want to send the email without a subject?')
            }
         	
         	if(isValid){
         		mailSent = true;
         	}        	
            return isValid;
        }
        
     // Function to save draft
        function saveDraft() {
        	console.log("saveDraft function called");
            const email = document.getElementById('recipient').value;
            const subject = document.getElementById('subject').value;
            const message = document.getElementById('message').value;
            const user_id = '<%= session.getAttribute("user_id") %>';
            const sender = '<%= session.getAttribute("email") %>';
            if ((email === '' && subject === '' && message === '')||mailSent===true) {
                return;  
            }
            $.ajax({
                url: <%= email_id > 0 ? "'saveDraft.jsp?id=" + email_id+"'" : "'saveDraft.jsp'" %>,
                type: 'POST',
                async: true,
                data: {
                    user_id: user_id,
                    sender: sender,
                    recipient: email,
                    subject: subject,
                    message: message
                },
                success: function(response) {
                	
                	if(response.trim() === 'success'){
                		//if session attributes are set here then
                		//the session attributes are being set regardless of whether the AJAX call is successful or not
                		//for that reason session attributes are set in save Draft.jsp
                        console.log("Draft saved successfully");
                	}
                	//if i check for danger condition and set the session attributes 
                	//then attributes sets at last will be consider no matter it is in else block or not
                	               	
                },
                error: function(error) {
                    console.log("Error saving draft:", error);
                }
            });
        }

        // Call saveDraft function when the page is unloaded
        window.addEventListener('beforeunload', function(event) {
            saveDraft();
            
        });
            
     </script>
     
     
  <!-- Draft save notification-->
  <!-- this code is at End of page because saveDraft is called by ajax i.e asynchronous call-->
  <!-- ajax call can be complete before page load or after page load-->
  <!-- ajax call after page load then at the top of body no notification will be called-->
  <script>
            <%
            String dstatus = (String) session.getAttribute("dstatus"); 		//Mail Successfully sent to draft setAttribute() from compose.jsp saveDraft() script function
            String dmessage = (String) session.getAttribute("dmessage");	//Mail Successfully sent to draft setAttribute() from compose.jsp saveDraft() script function
            if ("success".equals(dstatus)) {
            %>
            	iziToast.success({
                title: 'Success',
                message: '<%= dmessage %>',
                position: 'bottomLeft'
            	});
            <%
            }
            else if ("danger".equals(dstatus)) {
            %>
            	iziToast.error({
                title: 'Error',
                message: '<%= dmessage %>',
                position: 'bottomLeft'
            	});
            <%
            	
            }
            session.removeAttribute("dstatus");
            session.removeAttribute("dmessage");
            %>
    </script>
</body>

</html>