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
<title>著海学习平台管理员界面</title>
<link rel="stylesheet" href="css/reg.css">
</head>
<body>
<%
	if(session.getAttribute("me")!=null){
//用户已登
%>
<center>
<font class=title>著海学习平台的管理员届界面</font>
<a href="alogin.html">退出登录</a>
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
    <input type="button" value="查看全部公告" onclick="window.location.href='Aallnotice.jsp'">
    <%} %>
<hr>
<br>

<font color="blue">
<h2>登录成功！欢迎<font size="12" color="blue">


<%=session.getAttribute("me") %>
</font>
光临学习平台
</h2>
<h3><a href="Arunuser.jsp">会员管理</a>
&nbsp &nbsp &nbsp
<a href="Alist_notes.jsp">管理留言板</a>&nbsp &nbsp &nbsp
<a href="Adownload.jsp">管理平台资源</a>&nbsp &nbsp &nbsp
<a href="Anotice.jsp">发布公告</a></h3>
</font>
<% }else{ //response.setHeader("refresh", "2;URL=login.html") ;%>
	
<center>
<font class=title>著海的学习平台</font>
<a href="login.html">会员登录</a>
<a href="alogin.html">管理员登录</a>

<hr>
<font color="blue">
<h3><a href="alogin.html">用户管理</a>
&nbsp &nbsp &nbsp
<a href="alogin.html">进入留言板</a>&nbsp &nbsp &nbsp
<a href="alogin.html">查看平台资源</a></h3>
</font>
<br>
 <% }%>


</center>
</body>
</html>