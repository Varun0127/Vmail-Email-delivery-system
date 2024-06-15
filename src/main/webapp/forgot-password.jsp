<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Forgot Password</title>
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

    <!-- MDB -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" />

</head>

<body>
	<% 
		String otpErrorMsg= (String)request.getAttribute("otpError");
		String emailErrorMsg= (String)request.getAttribute("emailError");
		String email= (String)request.getAttribute("emailMobile");
		String otp= (String)request.getAttribute("otp");
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
                            <h4>Forgot your password?</h4>
                            <h6 class="font-weight-light">No worries! Reset it in a few easy steps.</h6>
                
                            <form class="pt-3" action="otpvalidation.jsp" id="forgotPasswordForm">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="recoveryEmail" name="emailPhone" placeholder="Recovery Email or Phone" value="<%= email!=null?email:"" %>" required>
                                    <label class="form-label" for="InputRecovery">Recovery Email or Phone</label>
                                    <span id="emailPhoneError" class="text-danger"><%= emailErrorMsg!=null?emailErrorMsg:""%></span>
                                </div>
                                <div class="mt-3" id="sendOTPSection" style="<%= otpErrorMsg!=null?"display:none;":"display:block;" %>">
                                    <button type="button" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" onclick="sendOTP()">SEND OTP</button>
                                </div>
                                <div class="form-floating mb-3" id="otpSection" style="<%= otpErrorMsg!=null?"display:block;":"display:none;" %>" >
                                    <input type="text" class="form-control" id="inputOTP" name="otp" placeholder="OTP" value="<%= otpErrorMsg!=null?otp:"" %>" required>
                                    <label class="form-label" for="InputOTP">OTP</label>
                                   
                                    <span id="otpError" class="text-danger"><%= otpErrorMsg!=null?otpErrorMsg:""%></span>
                                    
                                </div>
                                <div class="mt-3" id="changePasswordSection" style="<%= otpErrorMsg!=null?"display:block;":"display:none;" %>">
                                    <button type="submit" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" onclick="changePassword()">CHANGE PASSWORD</button>
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
        function sendOTP() {
            let recoveryValue = document.getElementById("recoveryEmail").value;
            let isValid = validateRecoveryInput(recoveryValue);

            if (isValid) {
            	
            	// Check Vmail Address availability
                $.ajax({
                    url: 'checkVmail.jsp',
                    type: 'POST',
                    data: { vmailAddress: recoveryValue },
                    async: false,
                    success: function(response) {
                        if (response.trim() === 'available') {
                            document.getElementById('emailPhoneError').innerText = "Couldn't find your Account";
                        }
                        else{
                        	document.getElementById("sendOTPSection").style.display = "none";
                            document.getElementById("otpSection").style.display = "block";
                            document.getElementById("changePasswordSection").style.display = "block";
                        }
                    }
                });
                
            } else {
                document.getElementById('emailPhoneError').innerText="Please enter a valid recovery email or phone number.";
            }
        }

        function validateRecoveryInput(inputValue) {
            // Simple validation for email and phone number
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
            let phonePattern = /^[0-9]{10}$/;

            if (emailPattern.test(inputValue) || phonePattern.test(inputValue)) {
                return true;
            } else {
                return false;
            }
        }

        function changePassword() {
            let otp=document.getElementById("inputOTP").value;
            if(otp===''){
                document.getElementById("otpError").innerText="OTP  is required.";
            }
            else{
                document.getElementById("otpError").innerText="";
            }
            //window.location.href = "change-password.html"; 
        }
    </script>
</body>

</html>

