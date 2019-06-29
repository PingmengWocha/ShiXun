<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sh.util.SplitPage"%>
<%@ page import="sh.factory.DAOFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sh.dao.ziyuanDao"%>    
<%@ page import="sh.dao.impl.ZiyuanDaoSQLServerImpl"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="sh.util.*"%>
<%@ page import="sh.vo.Ziyuan"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>著海学习平台的资源下载</title>
<link rel="stylesheet" href="css/reg.css">
<script type="text/javascript" charset="utf-8">
function goPage(){
	   var v = document.getElementById("selectPage").value;
	   alert("我们将去页面download.jsp?flag="+v);
	   document.open("download.jsp?flag="+v,"_self","");
	}

</script>
<%
	String flag = request.getParameter("flag"); 
int totalRows=0;
int currentPage=1;
ziyuanDao ziyuandao=new ZiyuanDaoSQLServerImpl(); 
String strItem=request.getParameter("item");
String strContent=request.getParameter("content");
%>
</head>
<body>
	<div id="wrap">
		<center>
			<br>
			<img src="<%=session.getAttribute("image")%>">
			<br /> <a href="view.jsp">首页</a> 
			<font class=title>著海学习平台的资源</font> <a href="login.html">退出登录</a>
			<hr>
			<br>
			<a href="upload.jsp">上传资源</a> <br>
			<form>
			<table width="500" border="0">
				<tr>
					<td>在</td>
					<td><select name="item">
							<option value="u_name">文件名称</option>
							<option value="h_nc">上传者</option>
					</select>中查询： 
					 <input type="text" name="content">
					 <input type="submit" name="submit" value="搜索"></td>
				</tr>
			</table>
			</form>
			<br>
			<form method="post" action="download.jsp?flag=first">
				<jsp:useBean id="spage" class="sh.util.SplitPage" scope="session"></jsp:useBean>
				<jsp:useBean id="dao9" class="sh.dao.impl.ZiyuanDaoSQLServerImpl"
					scope="session"></jsp:useBean>
				<% if(session.getAttribute("me")!=null){  
%>
				<table border=1>
					<tr>
						<th>资源名称</th>
						<th>上传者</th>
						<th>上传时间</th>
						<th>操作</th>
					</tr>
					<%
request.setCharacterEncoding("UTF-8");
List<Ziyuan> list=null;
HashMap<String,String> tm=new HashMap();
if(strContent==null||strContent==""||strContent.equals("null")){
	totalRows=ziyuandao.getRows(tm);
	spage.setTotalRows(totalRows); 
	currentPage=spage.confirmPage(flag);
	list=ziyuandao.findAll(spage);
}else{
	tm.put(strItem,strContent);
	totalRows=ziyuandao.getRows(tm);
	spage.setTotalRows(totalRows);
	currentPage=spage.confirmPage(flag);
	list=ziyuandao.queryByLike(tm,spage);
	//list=notedao.findAll(spage);
}
//每次刷新页面时都应当重新获取表中的记录数
//因为翻页过程中表中的数据可能随时会发生变化



for(Ziyuan n:list){%>
					<tr>
						<td><%=n.getU_name() %></td>
						<td><%=n.getH_nc() %></td>
						<td><%=n.getCreate_time() %></td>
						<td><submit>
							<a href="DownloadServlet?filename=<%=n.getU_name()%>">下载</a></submit></td>
					</tr>
					<% 
}
%>
				</table>
				<%} %>
			</form>
			<div id="foot">
				<a
					href="download.jsp?flag=<%=SplitPage.FIRSTPAGE %>&item=<%=strItem%>&content=<%=strContent%>">首页</a>
				<a
					href="download.jsp?flag=<%=SplitPage.PREVIOUSEPAGE %>&item=<%=strItem%>&content=<%=strContent%>">上一页</a>
				<a
					href="download.jsp?flag=<%=SplitPage.NEXTPAGE %>&item=<%=strItem%>&content=<%=strContent%>">下一页</a>
				<a
					href="download.jsp?flag=<%=SplitPage.LASTPAGE %>&item=<%=strItem%>&content=<%=strContent%>">尾页</a>
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