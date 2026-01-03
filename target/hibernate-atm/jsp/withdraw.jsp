<%@ page import="com.atm.entity.User, com.atm.service.TransactionService" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String amountStr = request.getParameter("amount");
    String errorMessage = null;
    String successMessage = null;

    if (amountStr != null && !amountStr.isEmpty()) {
        try {
            double amount = Double.parseDouble(amountStr);
            TransactionService transactionService = new TransactionService();
            boolean success = transactionService.withdraw(user, amount);
            
            if (success) {
                successMessage = "Rs. " + amount + " withdrawn successfully.";
            } else {
                errorMessage = "Insufficient balance.";
            }
        } catch (Exception e) {
            errorMessage = "Error: Invalid amount";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Withdraw - ATM System</title>
    <style>
        body { font-family: 'Arial', sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .withdraw-container { background: #ffffff; padding: 30px; border-radius: 12px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); text-align: center; width: 400px; }
        h1 { color: #333; margin-bottom: 20px; }
        label { display: block; font-weight: bold; text-align: left; margin-bottom: 5px; color: #555; }
        input { width: 100%; padding: 10px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 6px; font-size: 16px; transition: 0.3s; }
        input:focus { border-color: #007bff; outline: none; box-shadow: 0px 0px 5px rgba(0, 123, 255, 0.5); }
        button { background-color: #007bff; color: white; padding: 12px 20px; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; transition: 0.3s; width: 100%; margin-top: 10px; }
        button:hover { background-color: #0056b3; }
        .back-btn { background-color: #dc3545; }
        .back-btn:hover { background-color: #c82333; }
        .message { color: green; font-weight: bold; margin-top: 10px; }
        .error { color: red; font-weight: bold; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="withdraw-container">
        <h1>Withdraw Funds</h1>
        <form action="withdraw.jsp" method="post">
            <label for="amount">Enter Withdrawal Amount (Max: Rs. 10,000):</label>
            <input type="text" name="amount" id="amount" placeholder="Enter Amount" required>
            <button type="submit">Withdraw</button>
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