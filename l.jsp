<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html>
<head>
<title>Page Redirection</title>
</head>
<body>
<center>
	<h1>Page Redirection</h1>

</center>
<%

	String ad_id 	=	 request.getParameter("target");
	 String myDriver = "com.mysql.jdbc.Driver";
      String myUrl = "jdbc:mysql://localhost/ad_project";
      Class.forName(myDriver);
      Connection conn = DriverManager.getConnection(myUrl, "root", "");
      
      Statement st = conn.createStatement();
      String query = "SELECT `ad_master`.`link`,`ad_live`.`clicks` FROM `ad_live` LEFT JOIN  `ad_master` ON `ad_live`.`ad_id` = `ad_master`.`id` where ad_live.id = "+ ad_id +" limit 1";
      ResultSet rs = st.executeQuery(query);
      String l_link = "	/";
      int click=0;
      while (rs.next())
      {
  		l_link = rs.getString("link");
  		click=rs.getInt("clicks")+1;
  		String uQuery="Update ad_live SET `clicks`="+click+" WHERE id="+ad_id;
  		st.executeUpdate(uQuery);
        break;
      }
      st.close();
      
	// SELECT * FROM `ad_live` where id in (SELECT id FROM `ad_live` order by clicks asc) group by page_id      
   	
   	response.setStatus(response.SC_MOVED_TEMPORARILY);
	response.setHeader("Location", l_link); 
%>
</body>
</html>