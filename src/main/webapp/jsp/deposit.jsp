<%@ page import="com.atm.entity.User, com.atm.service.TransactionService" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String amountStr = request.getParameter("amount");
    if (amountStr != null && !amountStr.isEmpty()) {
        try {
            double amount = Double.parseDouble(amountStr);
            TransactionService transactionService = new TransactionService();
            boolean success = transactionService.deposit(user, amount);
            
            if (success) {
                out.println("<script>alert('Rs. " + amount + " Deposited Successfully!');</script>");
            } else {
                out.println("<script>alert('Deposit failed. Please try again.');</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('Error: Invalid amount');</script>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Deposit - ATM System</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .container { background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); text-align: center; width: 400px; }
        h1 { color: #333; margin-bottom: 20px; }
        input[type="text"] { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 6px; font-size: 16px; }
        button { background-color: #28a745; color: white; padding: 12px 20px; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; transition: 0.3s; width: 100%; margin-top: 10px; }
        button:hover { background-color: #218838; }
        .back-btn { background-color: #dc3545; }
        .back-btn:hover { background-color: #c82333; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Deposit Funds</h1>
        <form action="deposit.jsp" method="post">
            <input type="text" name="amount" id="amount" placeholder="Enter Amount" required>
            <button type="submit">Deposit</button>
        </form>
        <button class="back-btn" onclick="window.location.href='main_class.jsp'">Back</button>
    </div>
</body>
</html>