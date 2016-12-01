<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.helper.Validate" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>

<%@ page import="java.io.IOException" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.net.URISyntaxException" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLConnection" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="static jdk.nashorn.internal.objects.Global.print" %>
<%@ page import="org.jsoup.Connection" %>
<%@ page import= "java.net.URI" %>
<%@ page import= "java.net.URISyntaxException" %>
<%@ page import= "java.net.URL" %>
<%@ page import= "java.net.URLDecoder" %>
<%@ page import= "java.net.URLConnection" %>

<%
long startTime = System.currentTimeMillis();

    out.print("<style>body{ background: #1F1F21; font-family:monospace;color:green; width: 100%; word-wrap: break-word;} pad{color:#4CD964} red{color : red;} orange{color:orange;} sky{color:aquamarine}white{color:white;}gray{color:C3C3C3;}</style>");

        String pth = getServletContext().getRealPath("/");
        String str = pth+"test_1.html";
        String currentWebsite = "updatesmarugujarat";
        out.println(str);
        File ftest = new File(str);    
        byte[] encoded = Files.readAllBytes(Paths.get(str));
        String fileAsString =  new String(encoded, StandardCharsets.UTF_8);
        Document doc = Jsoup.parse(fileAsString);
        Elements links = doc.getElementsByTag("a");

        String[] keys={"onclick","adserve","advertise","popads","adlink","campaign","popup","doubleclick","click"};

        List<LinkData> linksArray = new ArrayList<LinkData>();
        int probAds = 0;
        int extLinks = 0;
        int intLinks = 0;
        for (Element link : links) 
        {
            String href = link.attr("href");
            int d = stringContainsItemFromList( href, keys, out );
            //out.println("<hr>"+d+"<hr>");
            
            if( d > 0 )
            {
                probAds++;
                linksArray.add( new LinkData( href, d, true) );
                // out.println("external:");    
            }
            else
            {
                linksArray.add( new LinkData( href, d, false) );
             //   out.println("internal:");
            }

            if( href.indexOf( currentWebsite )!= -1 )
            {
                String testUr = URLDecoder.decode(href);  

                    int hasAd = hasAdInQueryStringParams( href, keys, out); 
                    if( hasAd > 0)
                    {
                        linksArray.get( linksArray.size() - 1 ).count = hasAd ;
                    }
                
                intLinks++;
                linksArray.get( linksArray.size() - 1 ).isExternal = false ;
            }
            else
            {
                extLinks++;
                linksArray.get( linksArray.size() - 1 ).isExternal = true ;
            }
            
            
        }

        for ( LinkData ld : linksArray )
        {
            out.println("<br>" +ld.toString() );
        }
        int totalLinks = links.size();

long endTime   = System.currentTimeMillis();
long totalTime = endTime - startTime;
out.println("<hr><table>");
out.println("<tr><td width='100px;'><white>TIME Acquired</white></td><td><white>"+totalTime+"</white><gray> Mili Seconds</gray></td></tr>");
out.println("<tr><td width='100px;'><white>Total Links </white></td><td><white>"+totalLinks+"</white><gray> Links</gray></td></tr>");
out.println("<tr><td width='100px;'><white>External Links </white></td><td><white>"+extLinks+"</white><gray> links</gray></td></tr>");
out.println("<tr><td width='100px;'><white>Internal Links </white></td><td><white>"+intLinks+"</white><gray> links</gray></td></tr>");
out.println("<tr><td width='100px;'><white>Probable Ads </white></td><td><white>"+probAds+"</white><gray>  Extracted</gray></td></tr>");
out.println("</table>");

%>
<%!

    class LinkData
    {
        public String link;
        public int count;
        public boolean isAd;
        public boolean isExternal;
        public String linkInLowerCase;
        public String hostName;

        LinkData( String l, int c, boolean ie )
        {
            this.link = l;
            this.count = c;
            this.isAd = ie;
            this.linkInLowerCase = l.toLowerCase();

            try 
            {
                URI u = new URI(this.link);
                this.hostName =  u.getHost();
            }
            catch(Exception e){ 
                this.hostName = this.link.split("/")[2];
            }
        }
        public String toString()
        {
            return this.count + " | " + (this.isExternal ? "<orange>External</orange>" : "<sky>Internal</sky>") + " | "+  (this.isAd ? "<red>Probable AD.</red>" : "Normal") +" | " +(this.isAd ? "<pad>"+this.link+"</pad>" : this.link);
        }
    }

    public int hasAdInQueryStringParams( String s , String[] items,  JspWriter out)
    {
        try { 
            String qcompo[] = s.split("?");
            String amp[]  = qcompo[1].split("&");
            
            for( String amps : amp )
            {
                String keyVal[] = amps.split("=");
                for(String val:keyVal)
                {
                        try 
                        {
                            URL testUrl = new URL(val);

                            int d = stringContainsItemFromList( val , items, out );
                            if( d > 0 )
                            {
                                return d;
                            }
                        } 
                        catch ( Exception malformedURLException ) 
                        { 
                           // nothing to do here 
                        }
                        
                    }
                }
       
            return 0;
        } catch (Exception e){
            return 0;
        }
    }
    public int stringContainsItemFromList(String inputString, String[] items, JspWriter out) throws IOException
    {
        int count = 0;
        for(int i =0; i < items.length; i++)
        {
            //out.println("<hr><i><b>"+inputString.toLowerCase()+"</b></i><hr>");
        
            if(inputString.toLowerCase().contains(items[i]))
            {
               count++;
            }
        }
        return count;
    }
    
%>