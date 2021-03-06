
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/svlt2"})
public class svlt2 extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            HttpSession session = request.getSession();
            int bookingID = Integer.parseInt(session.getAttribute("bookingID").toString());
            String actReturnDate = request.getParameter("actReturnDate");
            
            String initialReturnDate;
            String extendReturnDate;
            String extendStatus;
            int extraDays = 0;
            float vehiclePrice = 0;
            float initialPrice = 0;
            float extraFee = 0;
            Date date1;
            Date date2;
            Date date3;
            
            String driver = "com.mysql.jdbc.Driver";
            String connectionUrl = "jdbc:mysql://localhost:3306/";
            String database = "rentalproject";
            String userid = "root";
            String password = "";
            
            try {
                Class.forName(driver);
                Connection conn = DriverManager.getConnection(connectionUrl+database,userid,password);
               
                String sqlupdate = "delete from available where bookingID=?";
                PreparedStatement ps = conn.prepareStatement(sqlupdate);
                ps.setInt(1, bookingID);
                ps.executeUpdate();
                
                log(sqlupdate);
            }
            
            catch(Exception ex){
                ex.printStackTrace();
            }
            
            
            try {
                Class.forName(driver);
                Connection conn = DriverManager.getConnection(connectionUrl+database,userid,password);
               
                //prepared statement 
                
                String sqlselect = "select * from booking, vehicle where bookingID=? and booking.vehicleID=vehicle.vehicleID";
                PreparedStatement ps = conn.prepareStatement(sqlselect);
                ps.setInt(1, bookingID);
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    initialPrice = rs.getFloat("totalPrice");
                    vehiclePrice = rs.getFloat("price");
                    initialReturnDate = rs.getString("returnDate");
                    extendReturnDate = rs.getString("extendReturnDate");
                    extendStatus = rs.getString("extendStatus");
                    
                    date1=new SimpleDateFormat("yyyy-MM-dd").parse(initialReturnDate);
                    date2=new SimpleDateFormat("yyyy-MM-dd").parse(extendReturnDate);
                    date3=new SimpleDateFormat("yyyy-MM-dd").parse(actReturnDate);
                    
                    //diffDays = (int) ((date2.getTime() - date1.getTime())/(1000*60*60*24));
                    
                    if (extendStatus == "APPROVED") {
                        //actual return date - extend date
                        extraDays = (int) ((date3.getTime() - date2.getTime())/(1000*60*60*24));
                        if (extraDays > 0) {
                            extraFee = extraDays * vehiclePrice;
                            extraFee = extraFee + + (initialPrice * 1/4);
                        }
                        else {
                            extraFee = 0;
                        }
                    }
                    else {
                        //actual return date - return date
                        extraDays = (int) ((date3.getTime() - date1.getTime())/(1000*60*60*24));
                        if (extraDays > 0) {
                            extraFee = extraDays * vehiclePrice;
                            extraFee = extraFee + (initialPrice * 1/4);
                        }
                        else {
                            extraFee = 0;
                        }
                    }
                    
                    String sqlupdate = "update booking set returnDate=?, status=?, extraFee=? where bookingID=?";
                    ps = conn.prepareStatement(sqlupdate);
                    ps.setString(1, actReturnDate);
                    ps.setString(2, "COMPLETED");
                    ps.setFloat(3, extraFee);
                    ps.setInt(4, bookingID);
                    ps.executeUpdate();
                
                    log(sqlupdate);
                    
                    response.sendRedirect("booking_list.jsp");
                }
            }
            
            catch(Exception ex){
                ex.printStackTrace();
            }
        }
    }
}
