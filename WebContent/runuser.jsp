<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="sh.dao.infohyDao" %>
<%@page import="sh.dao.impl.InfohyDaoSQLServerImpl"%> 
<%@page import="sh.factory.DAOFactory" %>
<%@page import="java.io.PrintWriter" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="sh.vo.Infohy" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户信息</title>
<%
	infohyDao infohydao=new InfohyDaoSQLServerImpl();
%>
<!-- <script src="js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		//.s是span框的class值
		$(".s").dblclick(function() {
			var td = $(this);
			var txt = td.text();
			var input = $("<input type='text' value='"+txt+"'/>");
			td.html(input);
			input.click(function() {
				return false;
			})
			//获取焦点
			input.trigger("focus");
			//文本框失去焦点后提交内容，重新变为文本 
			input.blur(function() {
				var newtxt = $(this).val();
				if (newtxt != "") {
					td.html(newtxt);
					//获取好友的ID
					var id = $(".s").attr("id");
					//获取修改后的名字
					var s = document.getElementById(id);
					var name = s.innerHTML;
					$.ajax({
						type : "POST",
						url : "UpdateSer",
						data : "id=" + id + "&name=" + name
					})
				} else {
					$(this).html(txt);
					td.html(txt);
				}
			})
		});
  
</script> -->
</head>
<body>
<div id="wrap">
<center>
<br>
<a href="userinfor.jsp"><img src="<%=session.getAttribute("image")%>" alt="修改头像"></a>
<br /> <a href="view.jsp">首页</a>
<font class=title>用户信息</font> <a href="login.html">退出登录</a>
<hr>
<br>
<form method="post" action="runuser.jsp">
<jsp:useBean id="dao" class="sh.dao.impl.InfohyDaoSQLServerImpl" scope="session"></jsp:useBean>
<% if(session.getAttribute("me")!=null){ %>
<% 
	request.setCharacterEncoding("UTF-8");
	List<Infohy>list=null;
	int id;
	id=Integer.parseInt(session.getAttribute("id").toString());
	list=infohydao.queryById(id);
	
	for(Infohy n:list){%>
	<form>
	<% if(n.getSex()==1){%>
		性别:<input type="radio" name="sex" checked="checked">男
		 	 <input type="radio" name="sex">女
	</br>
	<% }else{%>
		性别:<input type="radio" name="sex">男
		 	 <input type="radio" name="sex" checked="checked">女
	</br>	 	 
	<% }%>
	
	年&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp龄:<input type="text" name="age" placeholder="<%=n.getAge() %>">
	</br>
	
	忘记密码问题:<input type="text" name="ptp" placeholder="<%=n.getPtppassword() %>">
	</br>
	
	问题答案:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="text" name="ptpa" placeholder="<%=n.getPtpanswer() %>">
	</br>
	
	密&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp码:<input type="text" name="psd" placeholder="<%=n.getH_password() %>">
	</br>
	<input type="hidden" name="id" value="<%=session.getAttribute("id") %>" /></br>
	<input type="button" value="修改" onclick = "window.location.href='uupdate.jsp'">
	</form>
	<%} %>
	<%} else{response.setHeader("refresh","2,URL=login.html");
	}%>


</form>
</center>
</div>

</body>
</html>