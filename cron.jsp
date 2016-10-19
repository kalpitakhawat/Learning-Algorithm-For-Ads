<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.helper.Validate" %>
<%@ page import="org.jsoup.helper.Validate" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
 
<%

	   String myDriver = "com.mysql.jdbc.Driver";
     String myUrl = "jdbc:mysql://localhost/ad_project";
     Class.forName(myDriver);
     Connection conn = DriverManager.getConnection(myUrl, "root", "");
      String pth = getServletContext().getRealPath("/");

     Statement st = conn.createStatement();

      String query = "SELECT `ad_live`.`id` as ad_live_id ,`ad_master`.`provider_id`,`ad_master`.`link`,`ad_master`.`price`,`ad_live`.`ad_id`,`ad_live`.`clicks`,`ad_live`.`page_id`,`ad_master`.`position_id` FROM  `ad_live`,`ad_master` where `ad_live`.`ad_id` = `ad_master`.`id`";
       ResultSet rs = st.executeQuery(query);

      while (rs.next())
      {
          
            int ad_id = rs.getInt("ad_id");
            int ad_live_id = rs.getInt("ad_live_id");
    		int page_id = rs.getInt("page_id");
    		int pos_id = rs.getInt("position_id");
            int click=rs.getInt("clicks");
            int x_pr=rs.getInt("price");

            if(click<=10)
            {
                Statement best_st = conn.createStatement();
                String bestAdQuery = "SELECT id,price FROM `ad_master` where `id` !=" + ad_id + " and `position_id` = " + pos_id +" ORDER BY price desc LIMIT 1";
                ResultSet rs_best_ad= best_st.executeQuery(bestAdQuery);
                while(rs_best_ad.next()){
                    int bestAdId=rs_best_ad.getInt("id");
                    int bestAdPrice=rs_best_ad.getInt("price");
                    
                    out.print("New Best ad "+bestAdId+" price( "+ bestAdPrice+") ");
                    out.print("will replace to live id "+ad_live_id+" ( ad "+ad_id+", price :"+x_pr+")<br>");

                    Statement update_st = conn.createStatement();
                    String uQuery="UPDATE ad_live SET ad_id="+bestAdId+" where id="+ad_live_id;
                    String reset_click_query="Update ad_live SET clicks = 0 where page_id ="+page_id;
                    update_st.executeUpdate(uQuery);
                    update_st.executeUpdate(reset_click_query);

                }

            }
                
    }
    st.close();
   	 
%>
cron job completed..