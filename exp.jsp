<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.helper.Validate" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>

<%@ page import="java.io.IOException" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.net.URISyntaxException" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLConnection" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="static jdk.nashorn.internal.objects.Global.print" %>
<%@ page import="org.jsoup.Connection" %>
<%
	String s="http://stackoverflow.com/questions/12643683/how-to-check-if-a-string-contains-a-substring-containing-spaces";
	if(s.contains("")){
		out.println("yes");
	}
	else{
		out.println("no");
	}
%>