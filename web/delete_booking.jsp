<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirmation</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" crossorigin="anonymous">
        <link rel="stylesheet" href="admin.css">
        <style>
            .view {
                width: 75%;
                height: 100%;
                background-color: white;
                margin: auto;
                border-radius: 15px;
            }
        </style>
    </head>
    <body>
        <%@include file="headerAdmin.jsp" %>
        <%
            String vehicleID = session.getAttribute("bookingID").toString();
            
        %>
        <h1>Vehicle # <%= vehicleID %></h1>
        <div class="view">
        <div class="container">
            <form class="well form-horizontal" action="svlt3" method="post">
                <fieldset>
                    <!-- Form Name -->
                    <legend>Are you sure to delete this booking info?</legend>
            
                    <!-- Button -->
                    <div class="form-group">
                        <label class="col-md-4 control-label"></label>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary" >Confirm</button>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
        </div>
    </body>
</html>
