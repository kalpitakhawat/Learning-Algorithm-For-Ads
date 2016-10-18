<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.Path" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%

	String ad_id 	=	 request.getParameter("target");
	String myDriver = "com.mysql.jdbc.Driver";
    String myUrl = "jdbc:mysql://localhost/ad_project";
    Class.forName(myDriver);
    Connection conn = DriverManager.getConnection(myUrl, "root", "");
      
      Statement st = conn.createStatement();
      String query = "SELECT `ad_master`.`img` FROM `ad_live` LEFT JOIN  `ad_master` ON `ad_live`.`ad_id` = `ad_master`.`id` where ad_live.id = "+ ad_id +" limit 1";
      ResultSet rs = st.executeQuery(query);
      String img = "/";

      while (rs.next())
      {

  		String l_link = rs.getString("img");
	   	out.print("<img src='"+l_link+"' width='100%'>");
      //response.setStatus(response.SC_MOVED_TEMPORARILY);
  		//response.setHeader("Location", l_link);  
  		break;
  	 }
     st.close();
      
	// SELECT * FROM `ad_live` where id in (SELECT id FROM `ad_live` order by clicks asc) group by page_id      
   	
%>
