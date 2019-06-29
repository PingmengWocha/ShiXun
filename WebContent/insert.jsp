<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>发表留言</title>
<link rel="stylesheet" href="css/reg.css">
</head>
<script type="text/javascript">
//onSubmit="return check_admin(this);
function check_admin(form)
{
	if(form.title.value=="")
	{
		alert("标题不能为空!");
		form.title.focus();
		return false;
	}
	if(form.content.value=="")
	{
		alert("内容不能为空!");
		form.content.focus();
		return false;
	}
}
</script>
<body>
<center><br><br/><br/>
  <font class=ti>著海学习平台的留言板</font><a href="list_notes.jsp">返回</a><br>
  <hr>
  <%
  if(session.getAttribute("me")!=null){
  %>
  <form action="insertServlet" method="post">
 <table>
 
  <tr>
   <td colspan="2">添加新留言</td>
  </tr>
  
  <tr>
   <td>标题：</td>
   <td><input type="text" name="title"></td>
  </tr>
  
  <tr>
   <td>内容：</td>
   <td><textarea name="content" cols="30" rows="6"></textarea></td>
  </tr>
  
  <tr>
   <td><input type="hidden" name="author" value=<%=session.getAttribute("me") %>></td>
  </tr>
  
  <tr>
   <td colspan="2">
    <input type="submit" value="添加">
    <input type="reset" value="重置">
   </td>
  </tr>
</table>
</form>
  <%
  } else{
	  response.setHeader("refresh", "5;URL=qlogin.html");
	  %>
	  你还未登录，请先登录！！！<br>
	  5秒后自动跳转到登录窗口！！！<br>
	  如果没有跳转，请按<a href="qlogin.html">这里</a>
	  
 <%  }%>

</body>
</html>