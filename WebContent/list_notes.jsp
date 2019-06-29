<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sh.dao.noteDao"%>    
<%@ page import="sh.dao.impl.NoteDaoSQLServerImpl"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="sh.util.*"%>
<%@ page import="sh.vo.Note"%>
<%@ page import="sh.util.SplitPage"%>
<%@ page import="sh.factory.DAOFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>留言板</title>
<link rel="stylesheet" href="css/reg.css">
<script type="text/javascript" charset="utf-8">
function goPage(){
	   var v = document.getElementById("selectPage").value;
	   alert("我们将去页面list_notes.jsp?flag="+v);
	   document.open("list_notes.jsp?flag="+v,"_self","");
	}

</script>
<%
	String flag = request.getParameter("flag"); 
int totalRows=0;
int currentPage=1;
noteDao notedao=new NoteDaoSQLServerImpl(); 
String strItem=request.getParameter("item");
String strContent=request.getParameter("content");
%>
</head>
<body>
<div id="wrap">
		<center>
			<br>
			<a href="userinfor.jsp"><img src="<%=session.getAttribute("image")%>" alt="修改头像"></a>
			<br /> <a href="view.jsp">首页</a> 
			<font class=title>著海学习平台的留言板</font> <a href="login.html">退出登录</a>
			<hr>
			<br>
			<a href="insert.jsp">添加新的留言</a> <br>
			<form>
			<table width="500" border="0">
				<tr>
					<td>在</td>
					<td><select name="item">
							<option value="title">标题</option>
							<option value="author">作者</option>
							<option value="content">内容</option>
					</select>中查询： <input type="text" name="content"> <input
						type="submit" name="submit" value="搜索"></td>

				</tr>
			</table>
			</form>
			<br>
			<form method="post" action="list_notes.jsp?flag=first">
				<jsp:useBean id="spage" class="sh.util.SplitPage" scope="session"></jsp:useBean>
				<jsp:useBean id="dao4" class="sh.dao.impl.NoteDaoSQLServerImpl"
					scope="session"></jsp:useBean>
				<% if(session.getAttribute("me")!=null){  
%>
				<table border=1>
					<tr>
						<th>留言标题</th>
						<th>留言内容</th>
						<th>作者</th>
						<th>发表时间</th>
						<th>操作</th>
					</tr>
					<%
request.setCharacterEncoding("UTF-8");
List<Note> list=null;
HashMap<String,String> tm=new HashMap();
if(strContent==null||strContent==""||strContent.equals("null")){
	totalRows=notedao.getRows(tm);
	spage.setTotalRows(totalRows); 
	currentPage=spage.confirmPage(flag);
	list=notedao.findAll(spage);
}else{
	tm.put(strItem,strContent);
	totalRows=notedao.getRows(tm);
	spage.setTotalRows(totalRows);
	currentPage=spage.confirmPage(flag);
	list=notedao.queryByLike(tm,spage);
	//list=notedao.findAll(spage);
}
//每次刷新页面时都应当重新获取表中的记录数
//因为翻页过程中表中的数据可能随时会发生变化



for(Note n:list){%>
					<tr>
						<td><%=n.getM_title() %></td>
						<td><%=n.getM_content() %></td>
						<td><%=n.getH_nc() %></td>
						<td><%=n.getCreate_time() %></td>
						<td><submit>
							<a href="IdmessageServlet?id=<%=n.getM_id()%>">查看详情</a></submit></td>
					</tr>
					<% 
}
%>
				</table>
				<%} %>
			</form>
			<div id="foot">
				<a
					href="list_notes.jsp?flag=<%=SplitPage.FIRSTPAGE %>&item=<%=strItem%>&content=<%=strContent%>">首页</a>
				<a
					href="list_notes.jsp?flag=<%=SplitPage.PREVIOUSEPAGE %>&item=<%=strItem%>&content=<%=strContent%>">上一页</a>
				<a
					href="list_notes.jsp?flag=<%=SplitPage.NEXTPAGE %>&item=<%=strItem%>&content=<%=strContent%>">下一页</a>
				<a
					href="list_notes.jsp?flag=<%=SplitPage.LASTPAGE %>&item=<%=strItem%>&content=<%=strContent%>">尾页</a>
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