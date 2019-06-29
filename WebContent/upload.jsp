<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>著海学习平台的资源上传</title>
</head>
<body>
<form action="UploadServlet" method="post" enctype="multipart/form-data">
    <input type="file" name="vedio" value="上传文本"/><br/>
    <input type="submit" value="确定上传"/>
    <input type="button" value="取消" onclick="window.location.href='download.jsp'"/>
</form>
</body>
</html>