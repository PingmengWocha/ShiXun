<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>发布公告</title>
</head>
<style type="text/css">
*{
margin=0px;
padding=0;
}
html{
overflow:hidden;
}
#ninjia{
position:relative;
width=100%;
height=100%;
}
#ninjia.ninjia-image1{
postition:absoult;
background-size:cover;
transition:3s;
}
#biao{
width:100%;
height:10px;
overflow-x:hidden;
overflow-y:auto;
}
#login{
position:absolute;
top:180px;
left:400px;
}
p{
font-size:25px;
color=white;
margin-left:55px;
font-family:"微软雅黑";
}
.user{
position:absolute;
top:50px;
font-size:18px;
width:270px;
height:44px;
color=white;
background:rgba(45,45,45,0.15);
border-radius:6px;
border:1px solid rgba(255,255,255,15);
box-shadow:0 2px 3px 0 rgba(0,0,0,1)inset;
text-indent:10px;
}
.sub{
position:absolute;
top:170px;
font-size:18px;
font-family:"微软雅黑";
font-weight:20px;
color:#ffffff;
outline:none;
background:red;
height:44px;
width:270px;
box-shadow:0 15px 30px 0 rgba(255,255,255,.25) inset,0 2px 7px 0 rgba(0,0,0,.2);
border:0px;
border-radius:6px;
cursor:pointer;
opacity:1;
     }
.sub2{
position:absolute;
top:220px;
font-size:18px;
font-family:"微软雅黑";
font-weight:20px;
color:#ffffff;
outline:none;
background:red;
height:44px;
width:270px;
box-shadow:0 15px 30px 0 rgba(255,255,255,.25) inset,0 2px 7px 0 rgba(0,0,0,.2);
border:0px;
border-radius:6px;
cursor:pointer;
opacity:1;
     }

</style>
<script type="text/javascript">
//onSubmit="return check_admin(this);
function check_admin(form)
{
	if(form.notice.value=="")
	{
		alert("请输入公告内容!");
		form.name.focus();
		return false;
	}
}	
</script>
<body>
<div id="ninjia">
<div class="ninjia-image1">
<img src="images\6.jpg" width="100%" height="100%" alt="图片一"/>
</div>
</div>
<div id="biao">
	<form action="NoticeServlet" method="post" id="login">
	<input type="text" name="notice" class="user" placeholder="公告内容:"></br>
	<input type="hidden" name="a_id" value="<%=session.getAttribute("a_id") %>">
	<input type="submit" id="sub" class="sub" value="确认" onclick="return check_admin(form)">
	<input type="submit" id="sub2" class="sub2" value="取消">
</form>
</div>
</body>
</html>