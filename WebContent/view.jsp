<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sh.dao.noticeDao" %>
<%@ page import="sh.dao.impl.NoticeDaoSQLServerImpl" %>  
<%@ page import="java.util.HashMap"%>
<%@ page import="sh.util.*"%>  
<%@ page import="sh.vo.Notice" %>
<%@ page import="sh.factory.DAOFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>著海的学习平台</title>
<link rel="stylesheet" href="css/reg.css">
</head>
<body>
<%
	//页面计数
String str_counter=(String)application.getAttribute("counter");
if(str_counter!=null){
	int int_counter=Integer.parseInt(str_counter) ;
	int_counter+=1;
	str_counter= Integer.toString(int_counter);
	application.setAttribute("counter", str_counter);
}else{
	application.setAttribute("counter","1");
}
%>
<%
	if(session.getAttribute("me")!=null){
//用户已登
%>
<center>
<!--<img src="<%=session.getAttribute("image") %>">-->
<font class=title>著海的学习平台</font>
<a href="login.html">退出登录</a>
<hr>
	<jsp:useBean id="dao10" class="sh.dao.impl.NoticeDaoSQLServerImpl" scope="session"></jsp:useBean>
	<%
	noticeDao noticedao=new NoticeDaoSQLServerImpl();
	request.setCharacterEncoding("UTF-8");
	List<Notice> list=null;
	HashMap<String,String> tm=new HashMap();
	list=noticedao.queryLast();
	for(Notice n:list){
	%>
    <marquee behavior="scroll" direction="right">
    	<%=n.getN_subject() %>
    </marquee>
    <input type="button" value="查看全部公告" onclick="window.location.href='allnotice.jsp'">
    <%} %>
    
<hr>
<br>

<font color="blue">
<h2>登录成功！欢迎<font size="12" color="blue">


<%=session.getAttribute("me") %>
</font>
光临学习平台
</h2>
<h3>
您是第<%=(String) application.getAttribute("counter") %>位访客

</h3>
<h3><a href="runuser.jsp">用户管理</a>
&nbsp &nbsp &nbsp
<a href="list_notes.jsp">进入留言板</a>&nbsp &nbsp &nbsp
<a href="download.jsp">查看平台资源</a></h3>
</font>
<% }else{ //response.setHeader("refresh", "2;URL=login.html") ;%>
	
<center>
<font class=title>著海的学习平台</font>
<a href="login.html">会员登录</a>
<a href="alogin.html">管理员登录</a>
<hr>
<font color="blue">
<h3><a href="login.html">用户管理</a>
&nbsp &nbsp &nbsp
<a href="login.html">进入留言板</a>&nbsp &nbsp &nbsp
<a href="login.html">查看平台资源</a></h3>
</font>
<br>
 <% }%>


</center>
</body>
</html>