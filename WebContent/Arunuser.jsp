<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sh.dao.personDao"%>    
<%@ page import="sh.dao.impl.PersonDaoSQLServerImpl"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="sh.util.*"%>
<%@ page import="sh.vo.Person"%>
<%@ page import="sh.util.SplitPage"%>
<%@ page import="sh.factory.DAOFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会员管理界面</title>
<link rel="stylesheet" href="css/reg.css">
<script type="text/javascript" charset="utf-8">
function goPage(){
	   var v = document.getElementById("selectPage").value;
	   alert("我们将去页面Arunuser.jsp?flag="+v);
	   document.open("Arunuser.jsp?flag="+v,"_self","");
	}

</script>
<%
	String flag = request.getParameter("flag"); 
int totalRows=0;
int currentPage=1;
personDao persondao=new PersonDaoSQLServerImpl(); 
String strItem=request.getParameter("item");
String strContent=request.getParameter("content");
%>
</head>
<body>
<div id="wrap">
		<center>
			<br>
			<br>
			<br /> <a href="Aview.jsp">首页</a> 
			<font class=title>会员管理界面</font> <a href="Alogin.html">退出登录</a>
			<hr>
			<br>
			<!-- <a href="insert.jsp">添加新的留言</a> <br> -->
			<form>
			<table width="500" border="0">
				<tr>
					<td>在</td>
					<td><select name="item">
							<option value="h_id">会员ID</option>
							<option value="h_nc">会员昵称</option>
					</select>中查询： <input type="text" name="content"> <input
						type="submit" name="submit" value="搜索"></td>

				</tr>
			</table>
			</form>
			<br>
			<form method="post" action="Arunuser.jsp?flag=first">
				<jsp:useBean id="spage" class="sh.util.SplitPage" scope="session"></jsp:useBean>
				<jsp:useBean id="daoa" class="sh.dao.impl.PersonDaoSQLServerImpl"
					scope="session"></jsp:useBean>
				<% if(session.getAttribute("me")!=null){  
%>
				<table border=1>
					<tr>
						<th>用户ID</th>
						<th>用户名称</th>
						<th>用户邮箱</th>
						<th>注册时间</th>
						<th>操作</th>
					</tr>
					<%
request.setCharacterEncoding("UTF-8");
List<Person> list=null;
HashMap<String,String> tm=new HashMap();
if(strContent==null||strContent==""||strContent.equals("null")){
	totalRows=persondao.getRows(tm);
	spage.setTotalRows(totalRows); 
	currentPage=spage.confirmPage(flag);
	list=persondao.findAll(spage);
}else{
	tm.put(strItem,strContent);
	totalRows=persondao.getRows(tm);
	spage.setTotalRows(totalRows);
	currentPage=spage.confirmPage(flag);
	list=persondao.queryByLike(tm,spage);
	//list=notedao.findAll(spage);
}
//每次刷新页面时都应当重新获取表中的记录数
//因为翻页过程中表中的数据可能随时会发生变化



for(Person n:list){%>
					<tr>
						<td><%=n.getId() %></td>
						<td><%=n.getH_nc() %></td>
						<td><%=n.getEmail() %></td>
						<td><%=n.getDatetime() %></td>
						<td><submit>
							<a href="AdeleteServlet?id=<%=n.getId()%>">删除该会员</a></submit></td>
					</tr>
					<% 
}
%>
				</table>
				<%} %>
			</form>
			<div id="foot">
				<a
					href="Arunuser.jsp?flag=<%=SplitPage.FIRSTPAGE %>&item=<%=strItem%>&content=<%=strContent%>">首页</a>
				<a
					href="Arunuser.jsp?flag=<%=SplitPage.PREVIOUSEPAGE %>&item=<%=strItem%>&content=<%=strContent%>">上一页</a>
				<a
					href="Arunuser.jsp?flag=<%=SplitPage.NEXTPAGE %>&item=<%=strItem%>&content=<%=strContent%>">下一页</a>
				<a
					href="Arunuser.jsp?flag=<%=SplitPage.LASTPAGE %>&item=<%=strItem%>&content=<%=strContent%>">尾页</a>
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