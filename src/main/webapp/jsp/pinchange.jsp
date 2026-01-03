<%@ page import="com.atm.entity.User, com.atm.service.UserService" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String currentPin = request.getParameter("currentPin");
    String newPin = request.getParameter("newPin");
    String confirmPin = request.getParameter("confirmPin");
    
    String errorMessage = null;
    String successMessage = null;

    if (currentPin != null && newPin != null && confirmPin != null) {
        if (!user.getPin().equals(currentPin)) {
            errorMessage = "Current PIN is incorrect";
        } else if (!newPin.equals(confirmPin)) {
            errorMessage = "New PINs do not match";
        } else if (newPin.length() != 4) {
            errorMessage = "PIN must be 4 digits";
        } else {
            UserService userService = new UserService();
            boolean success = userService.updateUserPin(user, newPin);
            
            if (success) {
                successMessage = "PIN changed successfully";
                user.setPin(newPin);
                session.setAttribute("user", user);
            } else {
                errorMessage = "Failed to change PIN. Please try again.";
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Change PIN - ATM System</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .container { background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); width: 400px; }
        h1 { color: #333; text-align: center; margin-bottom: 20px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; color: #555; }
        input { width: 100%; padding: 10px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 6px; font-size: 16px; }
        input:focus { border-color: #007bff; outline: none; box-shadow: 0px 0px 5px rgba(0, 123, 255, 0.5); }
        button { background-color: #007bff; color: white; padding: 12px 20px; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; width: 100%; }
        button:hover { background-color: #0056b3; }
        .back-btn { background-color: #6c757d; margin-top: 10px; }
        .back-btn:hover { background-color: #5a6268; }
        .message { color: green; font-weight: bold; margin-top: 10px; text-align: center; }
        .error { color: red; font-weight: bold; margin-top: 10px; text-align: center; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Change PIN</h1>
        <form action="pinchange.jsp" method="post">
            <label for="currentPin">Current PIN:</label>
            <input type="password" name="currentPin" placeholder="Enter current PIN" maxlength="4" required>
            
            <label for="newPin">New PIN:</label>
            <input type="password" name="newPin" placeholder="Enter new PIN" maxlength="4" required>
            
            <label for="confirmPin">Confirm New PIN:</label>
            <input type="password" name="confirmPin" placeholder="Confirm new PIN" maxlength="4" required>
            
            <button type="submit">Change PIN</button>
        </form>
        <button class="back-btn" onclick="window.location.href='main_class.jsp'">Back</button>
        
        <% if (errorMessage != null) { %>
            <p class="error"><%= errorMessage %></p>
        <% } else if (successMessage != null) { %>
            <p class="message"><%= successMessage %></p>
        <% } %>
    </div>
</body>
</html>