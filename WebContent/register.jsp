<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="/ShiXun/">
<meta charset="UTF-8">
<title>会员注册页面</title>
</head>
<link rel="stylesheet" href="css/common.css">
<script type="text/javascript">
function check_admin(form)
{
	if(form.name.value=="")
	{
		alert("请输入用户账号!");
		form.name.focus();
		return false;
	}
	if(form.pd.value=="")
	{
		alert("请输入用户密码!");
		form.pd.focus();
		return false;
	}
	if (form.pd2.value!=form.pd.value)
	{
		alert("两次输入的密码不一致!");
		form.pd2.focus();
		return false;
	}
	if(form.el.value==""){
		alert("请输入邮箱");
		form.el.focus();
		return false;
	}
	if(form.img.value==""){
		alert("请选择一个头像");
		form.img.focus();
		return false;
	}
	
}
function setImg(obj){
	var imageSrc=document.getElementById("imageSelect").value;
	document.getElementById("pic").src=imageSrc;
	
}
function checkH_nc(){
	//1.创建一个异步请求对象
	var xmlHttp = new XMLHttpRequest();
	//2.设置异步请求对象工作状态监听
	xmlHttp.onreadystatechange = function(){
		if(xmlHttp.readyState == 4){
			//从异步请求对象身上得到服务器端返回的响应数据
			var data = xmlHttp.responseText;
			//局部刷新效果
			if(data >= 1){
				document.getElementById("myFont").innerText = "部门名称已经存在";
			}else{
				document.getElementById("myFont").innerText = "部门名称可以使用";
			}
			
		}
	};
	//3.初始化异步请求对象
	var param = document.getElementById("h_nc").value;
	xmlHttp.open("get","dept/check.do?h_nc"+param,true);
	
	//通知异步请求对象发送请求
	xmlHttp.send();
}
</script>
<body>
<div id="ninjia">
<div class="ninjia-image1">
<img src="images\6.jpg" width="100%" height="100%" alt="图片一"/>
</div>
<center>
<form  action="register" method="post" id="login">
  <p>注册页面</p>
  <input type="text" id="h_nc" name="name" class="user" placeholder="用户名:" onblur="checkH_nc()">
  <font id="myFont" color="red">*</font>
  <br>
   头&nbsp&nbsp&nbsp&nbsp像:&nbsp&nbsp&nbsp 
   <img id="pic" src="images\face\Image1.jpg" /><br>
   请选择头像:
   <select id="imageSelect" onchange="setImg(this)" name="image">
   <option value="images\face\Image1.jpg">头像一</option>
   <option value="images\face\Image2.jpg">头像二</option>
   <option value="images\face\Image3.jpg">头像三</option>
   <option value="images\face\Image4.jpg">头像四</option>
   <option value="images\face\Image5.jpg">头像五</option>
   </select><br>
   <input type="password" name="pd" class="user pwd" placeholder="密码:"><br>
   <input type="password" name="pd2" class="user pwd" placeholder="确认密码:"><br>
   <input type="email" name="el" class="user" placeholder="电子邮箱:"><br>
  <input type="submit" value="提交" onclick="return check_admin(form)">
  <input type="submit" value="重置" onclick="this.form.reset()">
  <a href="login.html">点此登录</a>
</form>
</center>
</div>
</body>
</html>