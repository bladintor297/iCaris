<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! 
            String userdbName;
            String userdbPsw;
            String userdbType;
        %>

<%
                        Connection conn= null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        
                        String driver = "com.mysql.jdbc.Driver";
                        String url = "jdbc:mysql://localhost:3306/";
                        String database = "rentalproject";
                        String userid = "root";
                        String password = "";
                        
                        String sqlselect = "select*from users where email = ? and password = ?" ;
                        
                        String name = request.getParameter("u");
                        String pwd = request.getParameter("p");
                        //String ut = "customer";
             //           String ut2 = "customer";
                        
                      
                        try{
                        //    out.println (name + pwd);
                            Class.forName(driver);
                            conn = DriverManager.getConnection(url+database,userid,password);
                          //  Statement stmt = conn.createStatement();
                            
                            ps = conn.prepareStatement(sqlselect);
                           // out.println (name + pwd);
                            ps.setString(1, name);
                            ps.setString(2, pwd);
//                            ps.setString(3, ut);
                           // out.println (name + pwd);
                            
                            rs = ps.executeQuery();
                            //out.println (name + pwd);
                           // conn.close();
                            
                            if(rs.next()){
                                userdbName = rs.getString("email");
                                userdbPsw = rs.getString("password");
                                userdbType = rs.getString("userType");
                                //out.println (name + pwd + ut);
                                
                                if(name.equals(userdbName) && pwd.equals(userdbPsw))
                                {
                                    session.setAttribute("name",userdbName);
                                   // out.println (name + pwd);
                                   
                                   if (userdbType.equals("customer"))
                                    response.sendRedirect("../customer/mainCustomer.jsp");
                                   
                                   else
                                    response.sendRedirect("../mainAdmin.jsp");
                                }
//else if
//                                {
//                                    session.setAttribute("name",userdbName);
//                                    response.sendRedirect("../customer/mainCustomer.jsp");
//                                }
                            }else {
                                   // response.sendRedirect("error.jsp");// problem
                                    rs.close();
                                    ps.close(); //problem
                                }
                            conn.close();
                            log(sqlselect);
                        }catch(Exception ex){
                            ex.printStackTrace();
                          }
                            
                                
                            %>