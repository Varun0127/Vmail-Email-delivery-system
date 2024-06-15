<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vmail- SignUP</title>

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
   
    <!-- MDB -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.css" rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>

<body>
    <div class="container-scroller">
        <div class="container-fluid page-body-wrapper full-page-wrapper">
            <div class="content-wrapper d-flex align-items-center auth px-0">
                <div class="col-8 grid-margin mx-auto">
                    <div class="auth-form-light text-left py-5 px-4 px-sm-5">
                        <div class="brand-logo">
                            <img src="images/logo.svg" alt="logo">
                        </div>
                        <h4>New here?</h4>
                        <h6 class="font-weight-light">Signing up is easy. It only takes a few steps</h6>
                        
                        <%
        					String msg = request.getParameter("msg");
                        	String status= request.getParameter("status");
        					if (msg != null && !msg.isEmpty()) {
    					%>
            			<h6 class="text-center mt-3 text-<%= status%>"><%= msg %></h6>
    					<%
        					}
    					%>
                        <form class="pt-3" action="signupaction.jsp" id="signupForm" onsubmit="return validateForm()">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="firstname" name="first_name"
                                            placeholder="First Name">
                                        <label class="form-label" for="form12">First Name</label>
                                        <span id="firstnameError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="lastname" name="last_name"
                                            placeholder="Last Name" >
                                        <label class="form-label" for="form12">Last Name (optional)</label>
                                        <span id="lastnameError" class="text-danger"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <select class="form-select" id="gender" name="gender" >
                                            <option value="">Select Gender</option>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                        </select>
                                        <label class="form-label" for="floatingSelect">Gender</label>
                                        <span id="genderError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="date" class="form-control" id="dob" placeholder="Date of Birth"
                                            name="date_of_birth">
                                        <label class="form-label" for="floatingDate">Date of Birth</label>
                                        <span id="dobError" class="text-danger"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <select class="form-select" id="country" name="country">
                                            <option value="">Select Country</option>
                                            <option value="United States of America">United States of America</option>
                                            <option value="United Kingdom">United Kingdom</option>
                                            <option value="India">India</option>
                                            <option value="Germany">Germany</option>
                                            <option value="Argentina">Argentina</option>
                                        </select>
                                        <label class="form-label" for="floatingSelect">Country</label>
                                        <span id="countryError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="col-md-6  mb-3">
                                    <div class="input-group">
                                        <div class="form-floating mb-0">
                                            <input type="text" class="form-control" id="vmailAddress" aria-label="VmailAddress"
                                                placeholder="Vmail Address" name="vmailaddress" required>
                                            <label class="form-label" for="vmailAddress">Vmail Address</label>
                                        </div>
                                        <div class="input-group-append">
                                            <span class="input-group-text" style="height: 100%;">@vmail.com</span>
                                        </div>
                                    </div>
                                    <span id="vmailAddressError" class="text-danger mt-0"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                	<div class="input-group ">
                                    	<div class="form-floating ">
                                        	<input type="password" class="form-control border-end-0" style="outline: none !important; box-shadow: none !important;" id="password" name="password"
                                            	placeholder="Password" >
                                        	<label class="form-label" for="floatingPassword">Password</label>
                                        	
                                    	</div>
                                    	<div class="input-group-append">
                        	                    <span class="input-group-text toggle-password" style="height: 100%; background-color: transparent;"><i class="mdi mdi-eye-off"></i></span>
                            	        </div>
                                   	</div>
                                   	<span id="passwordError" class="text-danger"></span>
                                </div>
                                <div class="col-md-6 mb-3">
                                	<div class="input-group ">
                                    	<div class="form-floating">
                                        	<input type="password" class="form-control border-end-0" style="outline: none !important; box-shadow: none !important;" id="confirmPassword"
                                            	name="confirm_password" placeholder="Confirm Password" >
                                        	<label class="form-label" for="floatingPassword">Confirm Password</label>
                                        	
                                    	</div>
                                    	<div class="input-group-append">
                        	                    <span class="input-group-text toggle-password" style="height: 100%; background-color: transparent;"><i class="mdi mdi-eye-off"></i></span>
                            	        </div>
                                	</div>
                                	<span id="confirmPasswordError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="form-check">
                                    <label class="form-label text-muted">
                                        <input type="checkbox" class="form-check-input" id="termsCheckbox" >
                                        I agree to all Terms & Conditions
                                    </label>
                                    
                                </div>
                                <span id="termsCheckboxError" class="text-danger"></span>
                            </div>
                            <div class="mt-3">
                                <button type="submit" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn">SIGN UP</button>
                            </div>
                            <div class="text-center mt-4 font-weight-light">
                                Already have an account? <a href="login.jsp" class="text-primary">Login</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

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

    
    
    
  <!-- Custom JavaScript for show/hide password -->  
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

            const firstname = document.getElementById('firstname').value;
            const lastname = document.getElementById('lastname').value;
            const gender = document.getElementById('gender').value;
            const dob = document.getElementById('dob').value;
            const country = document.getElementById('country').value;
            const vmailAddress = document.getElementById('vmailAddress').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const termsCheckbox = document.getElementById('termsCheckbox').checked;

            // Resetting error messages
            document.getElementById('firstnameError').innerText = '';
            document.getElementById('lastnameError').innerText = '';
            document.getElementById('genderError').innerText = '';
            document.getElementById('dobError').innerText = '';
            document.getElementById('countryError').innerText = '';
            document.getElementById('vmailAddressError').innerText = '';
            document.getElementById('passwordError').innerText = '';
            document.getElementById('confirmPasswordError').innerText = '';
            document.getElementById('termsCheckboxError').innerText = '';

            // Validation for First Name
            if (firstname === '') {
                document.getElementById('firstnameError').innerText = 'First Name is required';
                valid = false;
            }

            // Validation for Last Name
            //if (lastname === '') {
              //  document.getElementById('lastnameError').innerText = 'Last Name is required';
                //valid = false;
            //}

            // Validation for Gender
            if (gender === '') {
                document.getElementById('genderError').innerText = 'Please select a gender';
                valid = false;
            }

            // Validation for Date of Birth
            if (dob === '') {
                document.getElementById('dobError').innerText = 'Date of Birth is required';
                valid = false;
            }

            // Validation for Country
            if (country === '') {
                document.getElementById('countryError').innerText = 'Please select a country';
                valid = false;
            }

            // Validation for Vmail Address
            if (vmailAddress === '') {
                document.getElementById('vmailAddressError').innerText = 'Vmail Address is required';
                valid = false;
            } else {
                // Check Vmail Address availability
                $.ajax({
                    url: 'checkVmail.jsp',
                    type: 'POST',
                    data: { vmailAddress: vmailAddress+"@vmail.com" },
                    async: false,
                    success: function(response) {
                        if (response.trim() !== 'available') {
                            document.getElementById('vmailAddressError').innerText = 'Vmail Address is not available';
                            valid = false;
                        }
                    }
                });
            }

            // Validation for Password
            if (password === '') {
                document.getElementById('passwordError').innerText = 'Password is required';
                valid = false;
            } else if (password.length < 6) {
                document.getElementById('passwordError').innerText = 'Password should be at least 6 characters';
                valid = false;
            }

            // Validation for Confirm Password
            if (confirmPassword === '') {
                document.getElementById('confirmPasswordError').innerText = 'Confirm Password is required';
                valid = false;
            } 
            if (password !== '' && confirmPassword !== '' && password !== confirmPassword) {
                document.getElementById('confirmPasswordError').innerText = 'Passwords do not match';
                valid = false;
            }

            // Validation for Terms & Conditions Checkbox
            if (!termsCheckbox) {
                document.getElementById('termsCheckboxError').innerText = 'Please agree to the Terms & Conditions';
                valid = false;
            }

            return valid;
        }
    </script>
</body>

</html>
