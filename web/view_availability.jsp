
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Car Rental</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" crossorigin="anonymous">
        <link rel="stylesheet" href="admin.css">
        <style>
            .view {
                width: 75%;
                height: 100%;
                background-color: transparent;
                margin: auto;
                border: solid;
                border-color: white;
                border-width: 2px;
                border-radius: 15px;
            }
            .info {
                padding: 20px;
            }
            .detail {
                width: 100%;
                padding: 10px;
                background-color: white;
                border-radius: 15px;
            }
            .mess {
                width: 100%;
                margin-top: 10px;
                padding: 10px;
                background-color: #ccccff;
                border-radius: 15px;
            }
        </style>
    </head>
    <body>
        <%@include file="headerAdmin.jsp" %>
        <%
            //String bookingID = session.getAttribute("bookingID").toString();
            String vehicleID = (String)session.getAttribute("vehicleID");
//            String pickupDate = session.getAttribute("pickupDate").toString();
//            String extendReturnDate = session.getAttribute("extendReturnDate").toString();
        %>
        <h1>List of booking for vehicle #<%= vehicleID %></h1>
        <div class="view">
            <div class="info">
            <%
                String driver = "com.mysql.jdbc.Driver";
                String connectionUrl = "jdbc:mysql://localhost:3306/";
                String database = "rentalproject";
                String userid = "root";
                String password = "";
                        
                try {
                    Class.forName(driver);
                    Connection conn = DriverManager.getConnection(connectionUrl+database,userid,password);
                           
                    //prepared statement
                    String sqlselect = "select * from vehicle where vehicleID=?";
                    PreparedStatement ps = conn.prepareStatement(sqlselect);
                    ps.setString(1, vehicleID);
                    ResultSet rs = ps.executeQuery();
                            
                    while(rs.next()){
                                
            %>
                        <div class="detail">
                            <p><b>Brand : </b> <%= rs.getString("brand") %></p>
                            <p><b>Model :</b> <%= rs.getString("model") %> </p>
                            <p><b>Vehicle No :</b> <%= rs.getString("vehicleNo") %> </p>
                        </div>
                        
            <%
                    }
       
                }
                catch(Exception ex) {
                    ex.printStackTrace();
                }
            %>
            <div class="container">
                <table class="table table-dark">
                    <thead>
                        <tr>
                            <th scope="col">Pickup Date</th>
                            <th scope="col">Return Date</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                       
                        try {
                            Class.forName(driver);
                            Connection conn = DriverManager.getConnection(connectionUrl+database,userid,password);
                           
                            //prepared statement
                            String sqlselect = "select * from available where vehicleID=?";
                            PreparedStatement ps = conn.prepareStatement(sqlselect);
                            ps.setString(1, vehicleID);
   
                            ResultSet rs = ps.executeQuery();
                            
                            while(rs.next()){
                                int counter=1;
                            %>    
                        <tr>
                            <td> <%= rs.getString("pickupDate") %> </td>
                            <td> <%= rs.getString("returnDate") %> </td> 
                        </tr>
                            <%
                            }
       
                        }
                        catch(Exception ex) {
                            ex.printStackTrace();
                        }
                    %>
                    </tbody>
                </table>
            </div>    
            <%
                //session.setAttribute("vehicleID",vehicleID);
            %>

        </div>
        </div>
        
    </body>
</html>
