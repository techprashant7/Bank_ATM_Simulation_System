<%@ page import="com.atm.service.UserService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String name = request.getParameter("name");
    String city = request.getParameter("city");
    String pin = request.getParameter("pin");
    String confirmPin = request.getParameter("confirmPin");

    if (name != null && city != null && pin != null && confirmPin != null) {
        if (!pin.equals(confirmPin)) {
            out.println("<script>alert('PINs do not match');</script>");
        } else if (pin.length() != 4) {
            out.println("<script>alert('PIN must be 4 digits');</script>");
        } else {
            UserService userService = new UserService();
            boolean success = userService.registerUser(name, city, pin);
            
            if (success) {
                out.println("<script>alert('Registration successful! Please login with your card number and PIN.'); window.location='login.jsp';</script>");
            } else {
                out.println("<script>alert('Registration failed. Please try again.');</script>");
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up - ATM System</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .signup-container { background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); width: 350px; }
        h1 { color: #333; text-align: center; margin-bottom: 20px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; color: #555; }
        input { width: 100%; padding: 10px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 6px; font-size: 16px; }
        input:focus { border-color: #007bff; outline: none; box-shadow: 0px 0px 5px rgba(0, 123, 255, 0.5); }
        button { background-color: #007bff; color: white; padding: 12px 20px; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; width: 100%; }
        button:hover { background-color: #0056b3; }
        .login-button { background-color: #6c757d; margin-top: 10px; }
        .login-button:hover { background-color: #5a6268; }
    </style>
</head>
<body>
    <div class="signup-container">
        <h1>Create Account</h1>
        <form action="signup.jsp" method="post">
            <label for="name">Full Name:</label>
            <input type="text" name="name" placeholder="Enter your name" required>
            
            <label for="city">City:</label>
            <input type="text" name="city" placeholder="Enter your city" required>
            
            <label for="pin">PIN (4 digits):</label>
            <input type="password" name="pin" placeholder="Enter PIN" maxlength="4" required>
            
            <label for="confirmPin">Confirm PIN:</label>
            <input type="password" name="confirmPin" placeholder="Confirm PIN" maxlength="4" required>
            
            <button type="submit">Register</button>
        </form>
        <button class="login-button" onclick="window.location.href='login.jsp'">Back to Login</button>
    </div>
</body>
</html>