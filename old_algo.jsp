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
out.print("<style>body{ background: black; font-family:monospace;color:green;} red{color : red;}</style>");
	 String myDriver = "com.mysql.jdbc.Driver";
     String myUrl = "jdbc:mysql://localhost/ad_project";
     Class.forName(myDriver);
     Connection conn = DriverManager.getConnection(myUrl, "root", "");
     Statement page_st = conn.createStatement();
	 String pth = getServletContext().getRealPath("/");

	 String page_query = "SELECT * FROM `page_master`";
	 ResultSet page_rs = page_st.executeQuery(page_query);
	String final_out_ar= ""; 
	 while (page_rs.next())
	 {

		//out.print(page_rs.getString("name")+"<br>");	
// PAGE LOOP
		try{


			String str = pth+ page_rs.getString("name");
			String currentPgeId = page_rs.getString("id");
			File ftest = new File(str);
			
			byte[] encoded = Files.readAllBytes(Paths.get(str));
			String fileAsString =  new String(encoded, StandardCharsets.UTF_8);
			Document doc = Jsoup.parse( fileAsString );
			Elements links = doc.getElementsByTag("a");

				for (Element link : links) 
				{
				    String linkHref = link.attr("href");
		  			Elements img = link.getElementsByTag("img");
					String old_style_img = img.attr("style");
					String old_class_img = img.attr("class");
					String old_id_img = img.attr("id");
					String old_img_lnk = img.attr("src");
							
							final_out_ar += "| Currrent Page id : "+currentPgeId+" <br>Currrent Page url : "+page_rs.getString("name")+" <br> Probable Ad : "+linkHref+"<br>Ad Image link : "+old_img_lnk+"<br> <hr/><br>";
						
				 }
			
			  		String htmToWrite = "";
					htmToWrite = doc.outerHtml();

			}
			catch(Exception ex)
			{
				continue;
			}
	}
	page_st.close();
	String[] f_ar = final_out_ar.split("|");
	for( int ix = 0;ix < f_ar.length-2; ix++ ){
		out.print(f_ar[ix]);
	}
	out.print("<hr> <red>Extraction has been done for all pages..  </red>");
 %>

