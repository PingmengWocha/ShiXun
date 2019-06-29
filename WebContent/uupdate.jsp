<%@ page language="java" contentType="text/html; UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户信息修改页面</title>
</head>
<script type="text/javascript">
$(function(){
	$("#sex1").click(function(){
		$("#sex0").attr('checked','');
		$("sex1").attr('checked','true');
	});
	$("#sex0").click(function(){
		$("#sex1").attr('checked','');
		$("#sex0").attr('checked','true');
	})
});
function check_admin(form){
	if(form.age.value=="")
	{
		alert("请输入年龄!");
		form.pd.focus();
		return false;
	}
	if (form.ptp.value=="")
	{
		alert("请输入忘记密码问题!");
		form.verify.focus();
		return false;
	}	
	if (form.ptpa.value=="")
	{
		alert("请输入忘记密码问题答案!");
		form.verify.focus();
		return false;
	}	
	if (form.ptpa.psd=="")
	{
		alert("请输入密码!");
		form.verify.focus();
		return false;
	}	
}
</script>
<body>
<center>
<form action="uupdateServlet" method="post">
	
	性别:<input type="radio" name="sex" id="sex1" checked="checked" value="1"/>男
	<input name="sex" type="radio" id="sex0" value="0"/>女
	</br>
	
	年&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp龄:<input type="text" name="age">
	</br>
	
	忘记密码问题:<input type="text" name="ptp"></span>
	</br>
	
	问题答案:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="text" name="ptpa">
	</br>
	
	密&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp码:<input type="text" name="psd">
	</br>
	<input type="submit" value="保存" id="sub" onclick="return check_admin(form)">
	</form>
</center>
</body>
</html>