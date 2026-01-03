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
            boolean success = transactionService.withdraw(user, amount);
            
            if (success) {
                out.println("<script>alert('Rs. " + amount + " Debited Successfully!');</script>");
            } else {
                out.println("<script>alert('Insufficient balance');</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('Error: Invalid amount');</script>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Fast Cash - ATM System</title>
    <style>
        body { font-family: 'Arial', sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .fastcash-container { background: #ffffff; padding: 30px; border-radius: 12px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); text-align: center; width: 400px; }
        h1 { color: #333; margin-bottom: 20px; }
        .button-container { display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px; }
        button { background-color: #007bff; color: white; padding: 12px 20px; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; transition: 0.3s; width: 100%; }
        button:hover { background-color: #0056b3; }
        .back-btn { background-color: #dc3545; margin-top: 15px; }
        .back-btn:hover { background-color: #c82333; }
    </style>
</head>
<body>
    <div class="fastcash-container">
        <h1>Select Withdrawal Amount</h1>
        <form action="fastcash.jsp" method="post">
            <div class="button-container">
                <button type="submit" name="amount" value="100">Rs. 100</button>
                <button type="submit" name="amount" value="500">Rs. 500</button>
                <button type="submit" name="amount" value="1000">Rs. 1000</button>
                <button type="submit" name="amount" value="2000">Rs. 2000</button>
                <button type="submit" name="amount" value="5000">Rs. 5000</button>
                <button type="submit" name="amount" value="10000">Rs. 10000</button>
            </div>
        </form>
        <button class="back-btn" onclick="window.location.href='main_class.jsp'">Back</button>
    </div>
</body>
</html>