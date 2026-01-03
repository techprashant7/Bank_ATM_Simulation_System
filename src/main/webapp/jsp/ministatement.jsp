<%@ page import="com.atm.entity.User, com.atm.entity.Transaction, com.atm.service.TransactionService, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    TransactionService transactionService = new TransactionService();
    List<Transaction> transactions = transactionService.getMiniStatement(user.getPin());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mini Statement - ATM System</title>
    <style>
        body { font-family: 'Arial', sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; flex-direction: column; height: 100vh; margin: 0; }
        .statement-container { background: #ffffff; padding: 30px; border-radius: 12px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); width: 600px; text-align: center; }
        h1 { color: #333; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 12px; text-align: center; border-bottom: 1px solid #ddd; }
        th { background-color: #007bff; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .back-btn { background-color: #dc3545; color: white; padding: 10px 20px; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; transition: 0.3s; margin-top: 20px; }
        .back-btn:hover { background-color: #c82333; }
    </style>
</head>
<body>
    <div class="statement-container">
        <h1>Mini Statement</h1>
        <table>
            <tr>
                <th>Date</th>
                <th>Transaction Type</th>
                <th>Amount</th>
            </tr>
            <% 
                if (transactions != null && !transactions.isEmpty()) {
                    for (Transaction transaction : transactions) {
            %>
                        <tr>
                            <td><%= transaction.getTransactionDate() %></td>
                            <td><%= transaction.getTransactionType() %></td>
                            <td>Rs. <%= transaction.getAmount() %></td>
                        </tr>
            <%
                    }
                } else {
            %>
                    <tr>
                        <td colspan="3">No transactions found</td>
                    </tr>
            <%
                }
            %>
        </table>
        <button class="back-btn" onclick="window.location.href='main_class.jsp'">Back</button>
    </div>
</body>
</html>