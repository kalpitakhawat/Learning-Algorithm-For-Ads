/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package JavaApplication1;
import org.jsoup.Jsoup;
import org.jsoup.helper.Validate;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLConnection;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import static jdk.nashorn.internal.objects.Global.print;
import org.jsoup.Connection;

/**
 *
 * @author dell
 */
public class DomainName {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args)throws IOException, URISyntaxException {
        // TODO code application logic here
        
        /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/**
 *
 * @author GPIT1
 */



    
    Document doc = Jsoup.connect("http://www.msn.com/").get();
        Elements links = doc.select("a[href]");
        Elements media = doc.select("[src]");
        Elements imports = doc.select("link[href]");
    
        Pattern p = Pattern.compile(".*?([^.]+\\.[^.]+)");
        
        /*for (Element src : media) {
            System.out.println( src.attr("abs:src"));*/
        String website_domain= "http://www.msn.com/";
         URI uri_web = new URI(website_domain);
            //eg: uri.getHost() will return "www.foo.com"
            Matcher m1 = p.matcher(uri_web.getHost());
            if (m1.matches()) {
                System.out.println(m1.group(1));
            }
        print("\nMedia: (%d)", media.size());
        System.out.println("Media");
           for (Element src : media){
                          
            String url = new String  (src.attr("abs:src"));
           
            URI uri = new URI(url);
            //eg: uri.getHost() will return "www.foo.com"
            if(uri.getHost()!= null){
            Matcher m = p.matcher(uri.getHost());
            if (m.matches()) {
                //System.out.println(m.group(1));
               
                //String domain= m.group(1);
                if (m.group(1).equals(m1.group(1)))
                {
                    
                     print("Website Link <%s>",m.group(1));
                     //String url = "http://www.twitter.com";

            //String url = "http://bit.ly/23414";
            HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();
            con.setInstanceFollowRedirects(false);
            con.connect();  
            String realURL = con.getHeaderField(3).toString(); 
                    print("Real URL", realURL);
                }
            
             else{
                     print("Advertisement <%s>",m.group(1));
                        
                    }
                    
                   
               
            }
            }
        }
           
           
           
           print("\nLinks: (%d)", links.size());
        System.out.println("Links");
           for (Element src : links)  {
           String url_link = new String (src.attr("abs:href"));
                   
            URI uri = new URI(url_link);
            //eg: uri.getHost() will return "www.foo.com"
             
            if(uri.getHost()!= null)
            { 
               Matcher m = p.matcher(uri.getHost());
            
            
            if (m.matches()) {
               // System.out.println(m.group(1));
                String domain=m.group(1);
                if (m.group(1).equals(m1.group(1)))
                {
                    print("Website Url <%s>",m.group(1));
//                    HttpURLConnection con = (HttpURLConnection) new URL(url_link).openConnection();
//con.setInstanceFollowRedirects(false);
//con.connect();
//String realURL = con.getHeaderField("Location"); 


Connection.Response response = Jsoup
        .connect(url_link)
        .method(Connection.Method.POST)
        .followRedirects(false)
        .execute();

System.out.println(" --- "+response.header("Location"));
                 //   print("Real URL <%s>", realURL);
                }
            
            else{
                print("Advertisement <%s>",m.group(1));
            }
            }
            }
        }
                   
            print("\nImports: (%d)", imports.size());
           System.out.println("Imports");
            for (Element src : imports) {
            String url_imports = new String (src.attr("abs:href"));
            
            URI uri = new URI(url_imports);
            //eg: uri.getHost() will return "www.foo.com"
            if(uri.getHost()!= null)
            {
            Matcher m = p.matcher(uri.getHost());
            if (m.matches()) {
                System.out.println(m.group(1));
            }
             else{
                System.out.println("No Match");
            }
            }
        }
            
//        for (String url:urls) {
//            URI uri;
//        uri = new URI(url);
//            //eg: uri.getHost() will return "www.foo.com"
//            Matcher m = p.matcher(uri.getHost());
//            if (m.matches()) {
//                System.out.println(m.group(1));
//            }
//        }
        
    }

    private static void print(String msg, Object... args) {
        System.out.println(String.format(msg, args));
    }
    }



    
    
    

