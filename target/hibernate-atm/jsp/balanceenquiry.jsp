<%@ page import="com.atm.entity.User, com.atm.service.TransactionService" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    TransactionService transactionService = new TransactionService();
    Double balance = transactionService.getBalance(user.getPin());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Balance Enquiry - ATM System</title>
    <style>
        body { font-family: 'Arial', sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .container { background: #ffffff; padding: 30px; border-radius: 12px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); width: 400px; text-align: center; }
        h1 { color: #333; margin-bottom: 20px; }
        .balance { font-size: 24px; font-weight: bold; color: #28a745; margin-bottom: 20px; padding: 10px; background: #eaffea; border-radius: 6px; }
        .btn { width: 100%; padding: 10px; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; transition: 0.3s; }
        .btn-back { background-color: #dc3545; color: white; }
        .btn-back:hover { background-color: #c82333; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Your Current Balance</h1>
        <p class="balance">Rs. <%= balance %></p>
        <button onclick="window.location.href='main_class.jsp'" class="btn btn-back">Back</button>
    </div>
</body>
</html>