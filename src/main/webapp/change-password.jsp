<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Change Password</title>
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
    <link rel="shortcut icon" href="images/favicon.png" />
	
	<!-- material design icons --> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/7.4.47/css/materialdesignicons.min.css" integrity="sha512-/k658G6UsCvbkGRB3vPXpsPHgWeduJwiWGPCGS14IQw3xpr63AEMdA8nMYG2gmYkXitQxDTn6iiK/2fD4T87qA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   
    <!-- MDB -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" />

</head>

<body>
	<%
        String email = (String) request.getAttribute("emailMobile");
		
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
                            <h4>Change Password</h4>
                            <h6 class="font-weight-light">Enter the new password.</h6>
                            
							
                            <form class="pt-3" action="change-password-action.jsp"<%="?email="+email%> id="changePasswordForm" onsubmit="return validatePassword()">
                                <input type="hidden" name="emailPhone" value="<%= email %>">
                                
                                <div class="mb-3">
                  					<div class="input-group">
                                		<div class="form-floating">
                                    		<input type="password" class="form-control border-end-0" style="outline: none !important; box-shadow: none !important;" name="new-password" id="InputPassword" placeholder="New Password" >
                                    		<label class="form-label" for="InputPassword">New Password</label>
                                    	</div>
                                    	<div class="input-group-append">
                            				<span class="input-group-text toggle-password" style="height: 100%; background-color: transparent;"><i class="mdi mdi-eye-off"></i></span>
                        				</div>
                                	</div>
                                	<span id="passwordError" class="text-danger"></span>
                                </div>
                                
                                <div class="mb-3">
                  					<div class="input-group">
                                		<div class="form-floating">
                                    		<input type="password" class="form-control border-end-0" style="outline: none !important; box-shadow: none !important;" id="InputConfirmPassword" placeholder="Confirm Password">
		                                    <label class="form-label" for="InputConfirmPassword">Confirm Password</label>
                		                </div>
                		                <div class="input-group-append">
                            				<span class="input-group-text toggle-password" style="height: 100%; background-color: transparent;"><i class="mdi mdi-eye-off"></i></span>
                        				</div>
                		            </div>
                		            <span id="confirmPasswordError" class="text-danger"></span>
                		       </div>
                		       
                                <div class="mt-3">
                                    <button type="submit" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" >UPDATE PASSWORD</button>
                                </div>
                                <div class="text-center mt-4 font-weight-light">
                                    Remembered your password? <a href="login.jsp" class="text-primary">Sign In</a>
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
        function validatePassword() {
        	let isValid=true;
            let newPassword = document.getElementById("InputPassword").value;
            let confirmPassword = document.getElementById("InputConfirmPassword").value;
            document.getElementById('passwordError').innerText = '';
            document.getElementById('confirmPasswordError').innerText = '';
            if (newPassword===""){
            	document.getElementById('passwordError').innerText ="Passwords can't be empty.";
                isValid=false;
            }
            if (confirmPassword===""){
            	document.getElementById('confirmPasswordError').innerText ="Passwords can't be empty.";
            	isValid=false;
            }
            if (newPassword!=="" && confirmPassword!=="" && newPassword !== confirmPassword ) {
            	document.getElementById('confirmPasswordError').innerText ="Passwords do not match."
            		isValid=false;
            } 
			return isValid;

        }
    </script>
</body>

</html>


