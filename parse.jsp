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
			    String pos 		= link.attr("data-position");
			    
			    if(pos.length() > 0)
			    {
     				Statement st = conn.createStatement();
			      	String query = "SELECT `ad_live`.`id` as ad_live_id, `ad_master`.`id` as ad_master_id, `ad_master`.`reg_ex`, `ad_master`.`img`, `ad_master`.`link`, `ad_master`.`provider_id`, `ad_master`.`price`,`ad_master`.`width`,`ad_master`.`position_id`,`ad_master`.`height`,`ad_live`.`page_id` FROM `ad_live` LEFT JOIN `ad_master` ON `ad_live`.`ad_id` = `ad_master`.`id` where `ad_live`.`page_id` = " + currentPgeId+ " and `ad_master`.`position_id` = "+ pos;

				    ResultSet rs = st.executeQuery(query);
			
					while (rs.next())
			    	{
			    		String h = rs.getString("height");
			    		String w = rs.getString("width");
			  			
			  			String ad_live_id = rs.getString("ad_live_id");
						String old_style_a = link.attr("style");
						String old_lnk = link.attr("href");
						String lnk = "/ads/l.jsp?target="+ad_live_id;
			  		    link.attr("style","position:relative; display:inline-block;"+old_style_a);
						link.attr("href",lnk);
						    
						Elements img = link.getElementsByTag("img");
						String old_style_img = img.attr("style");
						String old_class_img = img.attr("class");
						String old_id_img = img.attr("id");
						String old_img_lnk = img.attr("src");
						
						final_out_ar += "| Currrent Page id : "+currentPgeId+" <br>Currrent Page url : "+page_rs.getString("name")+" <br> Probable Ad : "+old_lnk+"<br>Ad Image link : "+old_img_lnk+" <br> new Ad URL :"+lnk+"<br> new Image URL: /ads/image.jsp?target="+ad_live_id+"<br> <hr/><br>";


						link.html("<div style='position:absolute; height:100%; width:100%; z-index:1;'></div><iframe style=\""+ old_style_img +";overflow-y:hidden!important;border:none;z-index: 2;width:"+w+"px!important;height:"+h+"px!important;\" id=\""+old_id_img+"\" class=\""+old_class_img+"\" scrolling=\"no\" src=\"/ads/image.jsp?target="+ad_live_id+"\" />");

						break;
			  		}
			  		st.close();
			    }
					
			}

		  		String htmToWrite = "";
				htmToWrite = doc.outerHtml();

		  		File file = new File(str);
			    FileWriter writer = new FileWriter(file); 	      
		    	  // Writes the content to the file
			      writer.write( htmToWrite ); 
			      writer.flush();
			      writer.close();

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
	out.print("<hr> <red>Parsing has been done for all pages..  </red>");
 %>

