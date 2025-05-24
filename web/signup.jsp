<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - UniEvent</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body class="form-page">
    <header>
        <nav>
            <a href="index.jsp">Home</a>
            <a href="login.jsp">Login</a>
            <a href="signup.jsp">Sign Up</a>
        </nav>
    </header>

    <div class="main-content">
        <div class="left-panel">
            <div class="logo-container">
                <img src="images/logo.png" alt="UniEvent Logo" class="signup-logo">
            </div>

            <h2 class="form-title">Get Start Now</h2>

            <!-- ✅ Form starts here -->
            <form action="RegisterServlet" method="post">

                <!-- ✅ Radio buttons moved inside the form -->
                <div class="radio-group">
                    <label><input type="radio" name="role" value="Student" checked> Student</label>
                    <label><input type="radio" name="role" value="Club Organizer"> Club Organizer</label>
                    <label><input type="radio" name="role" value="Admin/Staff"> Admin/Staff</label>
                </div>

                <div class="form-group">
                    <label>Name</label>
                    <input type="text" name="name" placeholder="Enter your name" required>
                </div>

                <div class="form-group role-group" id="student-fields">
                    <label>Student No.</label>
                    <input type="text" name="studentId" placeholder="Enter student ID">
                </div>

                <div class="form-group role-group" id="club-fields">
                    <label>Club Email</label>
                    <input type="email" name="clubEmail" placeholder="Enter your club email">
                </div>

                <div class="form-group role-group" id="staff-fields">
                    <label>Staff ID</label>
                    <input type="text" name="staffId" placeholder="Enter staff ID">
                </div>

                <div class="form-group role-shared" id="email-field">
                    <label>Email address</label>
                    <input type="email" name="email" placeholder="Enter your email address">
                </div>

                <div class="form-group role-shared" id="phone-field">
                    <label>Phone Number</label>
                    <input type="tel" name="phone" placeholder="Enter your phone number">
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Enter your password" required>
                </div>

                <div class="form-group agreement">
                    <label class="agreement-label">
                        <input type="checkbox" name="terms" required>
                        <span>I agree to the <a href="#">terms & policy</a></span>
                    </label>
                </div>

                <button type="submit" class="blue-button">Signup</button>
            </form>
        </div>

        <div class="right-panel"></div>
    </div>

    <script>
        const roleRadios = document.querySelectorAll('input[name="role"]');
        const studentFields = document.getElementById('student-fields');
        const clubFields = document.getElementById('club-fields');
        const staffFields = document.getElementById('staff-fields');
        const emailField = document.getElementById('email-field');
        const phoneField = document.getElementById('phone-field');

        function updateFormFields() {
            const role = document.querySelector('input[name="role"]:checked').value;
            studentFields.style.display = 'none';
            clubFields.style.display = 'none';
            staffFields.style.display = 'none';
            emailField.style.display = 'none';
            phoneField.style.display = 'none';

            if (role === "Student") {
                studentFields.style.display = 'block';
                emailField.style.display = 'block';
                phoneField.style.display = 'block';
            } else if (role === "Club Organizer") {
                clubFields.style.display = 'block';
            } else if (role === "Admin/Staff") {
                staffFields.style.display = 'block';
                emailField.style.display = 'block';
                phoneField.style.display = 'block';
            }
        }

        updateFormFields();
        roleRadios.forEach(radio => {
            radio.addEventListener('change', updateFormFields);
        });
    </script>
</body>
</html>
