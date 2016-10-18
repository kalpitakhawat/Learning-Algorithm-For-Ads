<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%

	  String myDriver = "com.mysql.jdbc.Driver";
      String myUrl = "jdbc:mysql://localhost/ad_project";
      Class.forName(myDriver);
      Connection conn = DriverManager.getConnection(myUrl, "root", "");
      Statement st = conn.createStatement();

      String query = "SELECT `ad_master`.`id`,`ad_master`.`provider_id`,`ad_master`.`link`,`ad_master`.`price`,`ad_live`.`ad_id`,`ad_live`.`clicks`,`ad_live`.`page_id`,`ad_master`.`position_id` FROM  `ad_live`,`ad_master` where `ad_live`.`id` in (SELECT id FROM `ad_live` order by clicks asc) and `ad_live`.`id` = `ad_master`.`id` group by `page_id`;";
      ResultSet rs = st.executeQuery(query);

      while (rs.next())
      {
 
  		int ad_id = rs.getInt("ad_id");
  		int pos_id = rs.getInt("position_id");
  		String ="SELECT * FROM `ad_master` where `id` !=" + ad_id + " and `position_id` = " + pos_id;

  		st.executeUpdate(uQuery);
        break;
      }
      st.close();
            
   	
   	response.setStatus(response.SC_MOVED_TEMPORARILY);
	response.setHeader("Location", l_link); 
%>