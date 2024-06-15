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
    
    <!-- iziToast CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/izitoast/dist/css/iziToast.min.css">
    
   <!-- MDB -->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.css" rel="stylesheet"/>
	     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    


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
                    <li class="nav-item">
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

       

        


                <div class="main-panel">

					<div class="content-wrapper">
					<div class="col-lg-6 mx-auto">
        				<div class="card ">
            				<div class="card-header ">
              					<h4 class="card-title mt-2 mb-2">Account Settings</h4>
            				</div>
            				<div class="card-body">
              					<form id="changePasswordForm" action="resetPassword.jsp" onsubmit="return validateForm()" class="m-3">
                    				<%
					   					String pmsg = request.getParameter("passwordmsg");
					                	if (pmsg != null && !pmsg.isEmpty()) {
									%>
                    				<h6 class="text-center mt-3 text-danger"><%= pmsg %></h6>
                    				<%} %>
                    				<h5 class="card-title">Change Password</h5>
                    				<div class="mb-3"> 
                    					<div class="input-group">
                    						<div class="form-floating mb-0">
        										<input type="password" class="form-control border-end-0" style="outline: none !important; box-shadow: none !important;" id="currentPassword" name="currentPassword" placeholder="Current Password">
        										<label for="currentpassword" class="text-secondary">Current Password</label>
      										</div>
      										<div class="input-group-append">
                                            	<span class="input-group-text toggle-password" style="height: 100%; background-color: transparent;"><i class="mdi mdi-eye-off"></i></span>
                                        	</div>
      									</div>
      									<span id="currentPasswordError" class="text-danger"></span>
                                    </div>   
      								
      								<div class="mb-3">
      									<div class="input-group ">
                    						<div class="form-floating mb-0">
        										<input type="password" class="form-control border-end-0" style="outline: none !important; box-shadow: none !important;" id="newPassword" name="newPassword" placeholder="New Password">
        										<label for="currentpassword" class="text-secondary">New Password</label>
      										</div>
      										<div class="input-group-append">
        	                                    <span class="input-group-text toggle-password" style="height: 100%; background-color: transparent;"><i class="mdi mdi-eye-off"></i></span>
    	                                    </div>                                       
	      								</div>
      									<span id="newPasswordError" class="text-danger"></span>
      								</div>
      								
									<div class="mb-3">
	      								<div class="input-group">
    	                					<div class="form-floating mb-0">
        										<input type="password" class="form-control border-end-0" style="outline: none !important; box-shadow: none !important;" name="confirmPassword" id="confirmPassword" placeholder="Confirm Password">
        										<label for="currentpassword" class="text-secondary">Confirm Password</label>
      										</div>
      										<div class="input-group-append">
                        	                    <span class="input-group-text toggle-password" style="height: 100%; background-color: transparent;"><i class="mdi mdi-eye-off"></i></span>
                            	            </div>
      									</div>
      									<span id="confirmPasswordError" class="text-danger"></span>
      								</div>
      								
                    				<button type="submit" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn  mt-3" >Change Password</button>
                				</form>
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
  
  
  <script>
  console.log("1 ");
        document.addEventListener('DOMContentLoaded', function() {
            const togglePassword = document.querySelectorAll('.toggle-password');
            
            togglePassword.forEach((toggle) => {
                toggle.addEventListener('click', function() {
                    const input = this.closest('.input-group').querySelector('input');
                    if (input.type === 'password') {
                        input.type = 'text';
                        this.innerHTML = '<i class="mdi mdi-eye"></i>';
                    } else {
                        input.type = 'password';
                        this.innerHTML = '<i class="mdi mdi-eye-off"></i>';
                    }
                });
            });console.log("2 ");
        });
        
    </script>
    <script>
    function validateForm() {
    	var currentPassword = document.getElementById('currentPassword').value;
        var newPassword = document.getElementById('newPassword').value;
        var confirmPassword = document.getElementById('confirmPassword').value;

        var isValid = true;
        
        if (!currentPassword) {
            document.getElementById('currentPasswordError').innerText = 'Please enter current password.';
            isValid = false;
        } else {
            document.getElementById('currentPasswordError').innerText = '';
        }

        if (!newPassword) {
            document.getElementById('newPasswordError').innerText = 'Please enter new password.';
            isValid = false;
        } else {
            document.getElementById('newPasswordError').innerText = '';
        }
        
        if (!confirmPassword) {
            document.getElementById('confirmPasswordError').innerText = 'Please confirm your password.';
            isValid = false;
        } else {
            document.getElementById('confirmPasswordError').innerText = '';
        }

        if (newPassword !== confirmPassword) {
            document.getElementById('newPasswordError').innerText = 'Passwords do not match.';
            document.getElementById('confirmPasswordError').innerText = 'Passwords do not match.';
            isValid = false;
        } 
        return isValid;
    }
    
    </script>
    
    
    
<script src="https://cdn.jsdelivr.net/npm/izitoast"></script>
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
 