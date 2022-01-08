
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(urlPatterns = {"/svlt5"})
@MultipartConfig(maxFileSize = 16177216)
public class svlt5 extends HttpServlet {
    PrintWriter out;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            //nn
            String type = request.getParameter("type");
            String brand = request.getParameter("brand");
            String model = request.getParameter("model");
            String vehicleNo = request.getParameter("vehicleNo");
            String colour = request.getParameter("colour");
            int seats = Integer.parseInt(request.getParameter("seats"));
            String transmission = request.getParameter("transmission");
            String trunkSize = request.getParameter("trunkSize");
            int price = Integer.parseInt(request.getParameter("price"));
            int age = LocalDate.now().getYear() - Integer.parseInt(request.getParameter("year"));
            String rdTaxExpiry = request.getParameter("rdTaxExpiry");
            String image = request.getParameter("image");
            
            Part part=request.getPart("image");
            
            String driver = "com.mysql.jdbc.Driver";
            String connectionUrl = "jdbc:mysql://localhost:3306/";
            String database = "rentalproject";
            String userid = "root";
            String password = "";
            
            //FileInputStream fis=null;
            
            try {
                Class.forName(driver).newInstance();
                Connection conn = DriverManager.getConnection(connectionUrl+database,userid,password);
                //prepared statement 
                //File image = new File(myloc);
                String sqlinsert = "insert into vehicle (type,brand,model,vehicleNo,colour,seats,transmission,trunkSize,price,age,rdTaxExpiry,image) values (?,?,?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement ps = conn.prepareStatement(sqlinsert);
                InputStream is = part.getInputStream();
                ps.setString(1, type);
                ps.setString(2, brand);
                ps.setString(3, model);
                ps.setString(4, vehicleNo);
                ps.setString(5, colour);
                ps.setInt(6, seats);
                ps.setString(7, transmission);
                ps.setString(8, trunkSize);
                ps.setInt(9, price);
                ps.setInt(10, age);
                ps.setString(11, rdTaxExpiry);
                //fis = new FileInputStream(image);
                //ps.setBinaryStream(12, (InputStream) fis, (int) (image.length()));
                ps.setBlob(12, is);
                
                ps.executeUpdate();
                
                log(sqlinsert);
            
                response.sendRedirect("vehicle_list.jsp");
            }
            
            catch(Exception ex){
                ex.printStackTrace();
            }
    }
}
