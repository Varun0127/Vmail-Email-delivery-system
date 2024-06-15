<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SignUP</title>

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

    <!-- MDB -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.css" rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" />

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
                        <form class="pt-3" action="signupaction.jsp" id="signupForm" onsubmit="return validateForm()">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="firstname" name="first_name"
                                            placeholder="First Name" required>
                                        <label class="form-label" for="form12">First Name</label>
                                        <span id="firstnameError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="lastname" name="last_name"
                                            placeholder="Last Name">
                                        <label class="form-label" for="form12">Last Name</label>
                                        <span id="lastnameError" class="text-danger"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <select class="form-select" id="gender" name="gender" required>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                        </select>
                                        <label class="form-label" for="floatingSelect">Gender</label>
                                        <span id="genderError" class="text-danger"></span>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="Date" class="form-control" id="dob" placeholder="Date of Birth"
                                            name="date_of_birth" required>
                                        <label class="form-label" for="floatingDate">Date of Birth</label>
                                        <span id="dobError" class="text-danger"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <select class="form-select" id="country" name="country" required>
                                            <option value="United States of America">United States of America</option>
                                            <option value="United Kingdom">United Kingdom</option>
                                            <option selected value="India">India</option>
                                            <option value="Germany">Germany</option>
                                            <option value="Argentina">Argentina</option>
                                        </select>
                                        <label class="form-label" for="floatingSelect">Country</label>
                                        <span id="countryError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" id="vmailAddress" aria-label="VmailAddress"
                                                placeholder="Vmail Address" name="vmailaddress" onkeyup="sendInfo()">
                                            <label class="form-label" for="vmailAddress">Vmail Address</label>
                                            <span id="vmailAddressError" class="text-danger" ></span>
                                        </div>
                                        <div class="input-group-append">
                                            <span class="input-group-text" style="height: 78.5%;">@vmail.com</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" id="password" name="password"
                                            placeholder="Password" required>
                                        <label class="form-label" for="floatingPassword">Password</label>
                                        <span id="passwordError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" id="confirmPassword"
                                            name="confirm_password" placeholder="Confirm Password" required>
                                        <label class="form-label" for="floatingPassword">Confirm Password</label>
                                        <span id="confirmPasswordError" class="text-danger"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="form-check">
                                    <label class="form-label text-muted">
                                        <input type="checkbox" class="form-check-input" id="termsCheckbox" required>
                                        I agree to all Terms & Conditions
                                    </label>
                                    <span id="termsCheckboxError" class="text-danger"></span>
                                </div>
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

    <script>
    var isValid = true;

    function validateForm() {
        isValid = true;
        var firstname = document.getElementById('firstname').value;
        var lastname = document.getElementById('lastname').value;
        var gender = document.getElementById('gender').value;
        var dob = document.getElementById('dob').value;
        var country = document.getElementById('country').value;
        var vmailAddress = document.getElementById('vmailAddress').value;
        var password = document.getElementById('password').value;
        var confirmPassword = document.getElementById('confirmPassword').value;
        var termsCheckbox = document.getElementById('termsCheckbox').checked;

        if (!firstname) {
            setError('firstnameError', 'Please enter your first name.');
        } else {
            clearError('firstnameError');
        }

        if (!lastname) {
            setError('lastnameError', 'Please enter your last name.');
        } else {
            clearError('lastnameError');
        }

        if (!gender) {
            setError('genderError', 'Please select your gender.');
        } else {
            clearError('genderError');
        }

        if (!dob) {
            setError('dobError', 'Please enter your date of birth.');
        } else {
            clearError('dobError');
        }

        if (!country) {
            setError('countryError', 'Please select your country.');
        } else {
            clearError('countryError');
        }

        if (!vmailAddress) {
            setError('vmailAddressError', 'Please enter a Vmail Address.');
        } else {
            sendInfo();
        }
        if(document.getElementById(id).innerText==="Address not available."){
        	console.log(document.getElementById(id).innerText);
        	isValid = false;
        }

        if (!password) {
            setError('passwordError', 'Please enter a password.');
        } else {
            clearError('passwordError');
        }

        if (!confirmPassword) {
            setError('confirmPasswordError', 'Please confirm your password.');
        } else {
            clearError('confirmPasswordError');
        }

        if (password !== confirmPassword) {
            setError('passwordError', 'Passwords do not match.');
            setError('confirmPasswordError', 'Passwords do not match.');
        } else {
            clearError('passwordError');
            clearError('confirmPasswordError');
        }

        if (!termsCheckbox) {
            setError('termsCheckboxError', 'Please agree to the Terms & Conditions.');
        } else {
            clearError('termsCheckboxError');
        }

        return isValid;
    }

    function setError(id, message) {
        document.getElementById(id).innerText = message;
        isValid = false;
    }

    function clearError(id) {
        document.getElementById(id).innerText = '';
    }

    var request;

    function sendInfo() {
    	$.ajax({
            url: 'checkVmail.jsp',
            type: 'POST',
            data: { vmailAddress: vmailAddress },
            async: false,
            success: function(response) {
                if (response.trim() !== 'available') {
                    document.getElementById('vmailAddressError').innerText = 'Vmail Address is not available';
                    valid = false;
                }
            }
        });
    }

    function getInfo() {
        if (request.readyState == 4) {
            var msg = request.responseText;
            if (!msg || msg.trim() === "Address not available.") {
                setError('vmailAddressError', 'Address not available.');
                isValid = false; 
            } else {
                setError('vmailAddressError', 'Address available.');
                 
            }
        }
    }

    </script>

</body>

</html>
