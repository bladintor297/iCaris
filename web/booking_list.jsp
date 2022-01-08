
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" crossorigin="anonymous">
        <title>Booking List</title>
        <link rel="stylesheet" href="admin.css">
        
    </head>
    <body>
        <%@include file="headerAdmin.jsp" %>
        
        <h1>Booking List</h1>
        
        <div class="addsearch">
        <div class="searchinformation">
            <form class="searchinfo" action="svlt1" method="post">
                <div class="search">
                    <input name="searchinfo" type="text">
                    <button type="submit" class="submit">Search</button>
                </div>
                 </form>
        </div>
        
        <div class="addinformation">
            <form class="addinfo" action="svlt2" method="post">
                <button type="submit" class="add">Add new booking</button>
            </form>
        </div>
        </div>
        
        <div class="container">
        <table class="table table-dark">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Vehicle Model ID</th>
                    <th scope="col">Booking Date</th>
                    <th scope="col">Pickup Date</th>
                    <th scope="col">Return Date</th>
                    <th scope="col">Status</th>
                    <th scope="col">Extended Return Date Request</th>
                    <th scope="col">Extension Status</th>
                </tr>
            </thead>
            <tbody>
                    <%
                        //smmm
                        String driver = "com.mysql.jdbc.Driver";
                        String connectionUrl = "jdbc:mysql://localhost:3306/";
                        String database = "rentalproject";
                        String userid = "root";
                        String password = "";
                        
                        try {
                            Class.forName(driver);
                            Connection conn = DriverManager.getConnection(connectionUrl+database,userid,password);
                           
                            //prepared statement
                            String sqlselect = "select * from booking";
                            PreparedStatement ps = conn.prepareStatement(sqlselect);
   
                            ResultSet rs = ps.executeQuery();
                            
                            while(rs.next()){
                                
                            %>    
                    <tr>
                        <th scope="row"><a href="viewBooking.jsp?bookingID=<%=rs.getString("bookingID")%>"><%=rs.getString("bookingID")%></th>
                        <td> <a href="viewBooking.jsp?bookingID=<%=rs.getString("bookingID")%>"><%= rs.getString("vehicleID") %> </td>
                        <td> <%= rs.getString("bookDate") %> </td>
                        <td> <%= rs.getString("pickupDate") %> </td>
                        <td> <%= rs.getString("returnDate") %> </td>
                        <td> <%= rs.getString("status") %> </td>
                        <td> <%= rs.getString("extendReturnDate") %> </td>
                        <td> <%= rs.getString("extendStatus") %> </td>
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
    </body>
</html>
