<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改个人头像</title>
</head>
<body>
<%
String id=(String)session.getAttribute("id");
String name=(String)session.getAttribute("me");
%>
<center>
<form action="UpdateImageServlet" method="post" enctype="multipart/form-data">
<table><h2>
<tr>
<td colspan="2"><h1>修改头像</h1></td>
</tr>
<tr>
<td>
用户名：<%=name %>
</td>
</tr>
<tr>
<td>
<div align="center">
上传头像图片:<input type="file" name="file1" size="30">
</div>
</td>
</tr>
<tr>
<td>
<font color=red>注意:头像文件大小不得超过10K</font>
</td>
</tr>
<tr>
<td colspan="2"><input type="hidden" name="id" value="<%=id%>">
<div align="center">
<input type="submit" name="提交">
</div>
</td>
</tr>
</h2>
</table>
</form>
</center>
</body>
</html>