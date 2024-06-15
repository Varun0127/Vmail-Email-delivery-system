  

  <!DOCTYPE html>
  <html lang="en">

  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Vmail - Login</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="vendors/feather/feather.css">
    <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link rel="stylesheet" href="css/vertical-layout-light/style.css">
    <!-- endinject -->
    <link rel="shortcut icon" href="images/favicon.svg" />
    
     <!-- material design icons --> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/7.4.47/css/materialdesignicons.min.css" integrity="sha512-/k658G6UsCvbkGRB3vPXpsPHgWeduJwiWGPCGS14IQw3xpr63AEMdA8nMYG2gmYkXitQxDTn6iiK/2fD4T87qA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   
    <!-- MDB -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.css" rel="stylesheet"/>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet"/>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"/>

  </head>

  <body>
  	<%
        String sessionOutMsg = (String) request.getAttribute("session_out");
    	String status = (String) request.getAttribute("status");
	%>
    <div class="container-scroller">
      <div class="container-fluid page-body-wrapper full-page-wrapper">
        <div class="content-wrapper d-flex align-items-center auth px-0">
          <div class="row w-100 mx-0">
            <div class="col-lg-4 mx-auto">
              <div class="auth-form-light text-left py-5 px-4 px-sm-5">
                <div class="brand-logo">
                  <img src="images/logo.svg" alt="logo">
                </div>
                <h4>Hello! let's get started</h4>
                <h6 class="font-weight-light">Sign in to continue.</h6>
                <%
                	if (sessionOutMsg != null && !sessionOutMsg.isEmpty()) {
				%>
				<h6 class="text-center mt-3 text-<%= status%>"><%= sessionOutMsg %></h6>
                <%
                	}
                	String pmsg=request.getParameter("passwordmsg"); //password change message
                	System.out.println(pmsg);
   					String msg = request.getParameter("msg");
                	status= request.getParameter("status");
   					if (msg != null && !msg.isEmpty()) {
				%>
        			<h6 class="text-center mt-3 text-<%= status%>"><%= msg %></h6>
    			<%
       				}
    			%>
    			<h6 class="text-center mt-3 text-success"><%= (pmsg != null && !pmsg.isEmpty())?pmsg:"" %></h6>
                <form class="pt-3" action="loginaction.jsp"  onsubmit="return validateForm()">
                  <div class="form-floating mb-3">
                    <input type="email" class="form-control" id="email" name="email" placeholder="Email" >
                    <label class="form-label" for="InputEmail1">Email</label>
                    <span id="emailError" class="text-danger"></span>
                  </div>
                  
                  <div class="mt-3">
                  	<div class="input-group">
                  		<div class="form-floating">
                    		<input type="password" class="form-control form-control-lg border-end-0" style="outline: none !important; box-shadow: none !important;" name="password" id="password" placeholder="Password">
                    		<label class="form-label" for="InputEmail1">Password</label>
                  		</div>
                  		<div class="input-group-append">
                            <span class="input-group-text toggle-password" style="height: 100%; background-color: transparent;"><i class="mdi mdi-eye-off"></i></span>
                        </div>
                  	</div>
                  	<span id="passwordError" class="text-danger"></span>
                  </div>
                  
                  <div class="mt-3">
                    <button type="submit" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn">SIGN IN</button>
                  </div>
                  <div class="my-2 d-flex justify-content-between align-items-center">
                  <div class="form-check">
                    <label class="form-label text-muted">
                      <input type="checkbox" class="form-check-input">
                      Keep me signed in
                    </label>
                  </div>
                  <a href="forgot-password.jsp" class="auth-link text-black">Forgot password?</a>
                </div>
                
                  <div class="text-center mt-4 font-weight-light">
                    Don't have an account? <a href="signup.jsp" class="text-primary">Create</a>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
        <!-- content-wrapper ends -->
      </div>
      <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->
    <!-- plugins:js -->
    <script src="vendors/js/vendor.bundle.base.js"></script>
    <!-- endinject -->
    <!-- Plugin js for this page -->
    <!-- End plugin js for this page -->
    <!-- inject:js -->
    <script src="js/off-canvas.js"></script>
    <script src="js/hoverable-collapse.js"></script>
    <script src="js/template.js"></script>
    <script src="js/settings.js"></script>
    <script src="js/todolist.js"></script>
    <!-- endinject -->
    
    
    <script>
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
    		});
 		});
        
	</script>
    
    <!-- Custom JavaScript for form validation -->
     <script>
        function validateForm() {
            let valid = true;
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            
         	// Resetting error messages
            document.getElementById('emailError').innerText = '';
            document.getElementById('passwordError').innerText = '';
            
            
         	// Validation for Email
            if (email === '') {
                document.getElementById('emailError').innerText = 'Email id is required.';
                valid = false;
            }
         	
         	// Validation for Password
            if (password === '') {
                document.getElementById('passwordError').innerText = 'Password is required.';
                valid = false;
            }
         	
         	
            return valid;
        }
            
     </script>
  </body>

  </html>
