<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sh.dao.noticeDao" %>  
<%@ page import="sh.dao.impl.NoticeDaoSQLServerImpl" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="sh.util.*"%>
<%@ page import="sh.vo.Notice"%>
<%@ page import="sh.util.SplitPage"%>
<%@ page import="sh.factory.DAOFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看所有公告</title>
<link rel="stylesheet" href="css/reg.css">
<script type="text/javascript" charset="utf-8">
function goPage(){
	   var v = document.getElementById("selectPage").value;
	   alert("我们将去页面Aallnotice.jsp?flag="+v);
	   document.open("Aallnotice.jsp?flag="+v,"_self","");
	}

</script>
<%
	String flag = request.getParameter("flag"); 
int totalRows=0;
int currentPage=1;
noticeDao noticedao=new NoticeDaoSQLServerImpl();
%>
</head>
<body>
<div id="wrap">
		<center>
			<br>
			<br /> <a href="Aview.jsp">首页</a> 
			<font class=title>著海学习平台的全部公告</font> <a href="Alogin.html">退出登录</a>
			<hr>
			<br>
			<br>
			<form method="post" action="Aallnotice.jsp?flag=first">
				<jsp:useBean id="spage" class="sh.util.SplitPage" scope="session"></jsp:useBean>
				<jsp:useBean id="dao11" class="sh.dao.impl.NoticeDaoSQLServerImpl"
					scope="session"></jsp:useBean>
				<% if(session.getAttribute("me")!=null){  
%>
				<table border=1>
					<tr>
						<th>公告ID</th>
						<th>公告内容</th>
						<th>发部时间</th>
						<th>操作</th>
					</tr>
					<%
request.setCharacterEncoding("UTF-8");
List<Notice> list=null;
HashMap<String,String> tm=new HashMap();
	totalRows=noticedao.getRows(tm);
	spage.setTotalRows(totalRows); 
	currentPage=spage.confirmPage(flag);
	list=noticedao.findAll(spage);
//每次刷新页面时都应当重新获取表中的记录数
//因为翻页过程中表中的数据可能随时会发生变化



for(Notice n:list){%>
					<tr>
						<td><%=n.getN_id() %></td>
						<td><%=n.getN_subject() %></td>
						<td><%=n.getCreate_time() %></td>
						<td><submit>
							<a href="IdnoticeServlet?id=<%=n.getN_id()%>">删除</a></submit></td>
					</tr>
					<% 
}
%>
				</table>
				<%} %>
			</form>
			<div id="foot">
				<a
					href="Aallnotice.jsp?flag=<%=SplitPage.FIRSTPAGE %>">首页</a>
				<a
					href="Aallnotice.jsp?flag=<%=SplitPage.PREVIOUSEPAGE %>">上一页</a>
				<a
					href="Aallnotice.jsp?flag=<%=SplitPage.NEXTPAGE %>">下一页</a>
				<a
					href="Aallnotice.jsp?flag=<%=SplitPage.LASTPAGE %>">尾页</a>
			</div>
			<select id="selectPage" name="selectPage"
				onchange="JavaScript:goPage();">
				<%
for(int i=1;i<=spage.getTotalPages();++i){
%>
				<option value="<%=i %>"
					<%=(spage.getCurrentPage()==i)?"selected='selected'":"" %>><%=i %>/<%=spage.getTotalPages() %></option>
				<% } %>
			</select>
		</center>
	</div>
</body>
</html>