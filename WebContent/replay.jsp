<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="sh.dao.impl.ReplyDaoSQLServerImpl"%>
<%@ page import="sh.dao.replyDao" %>
<%@ page import="sh.factory.DAOFactory" %>    
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sh.vo.Reply" %>
<%@ page import="sh.util.SplitPage" %> 
<%@ page import="sh.vo.Pinglun" %> 
<%@ page import="java.util.HashMap"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>回复页面</title>
<%
	replyDao replydao=new ReplyDaoSQLServerImpl();
%>
</head>
<link rel="stylesheet" href="css/pinglun.css">
<script src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
//onSubmit="return check_admin(this);
function check_admin(form)
{
	if(form.content.value=="")
	{
		alert("回复不能为空哦!");
		form.content.focus();
		return false;
	}
}	
function goPage(){
	var v=document.getElementById("selectPage").value;
	alert("我们将去页面replay.jsp?flag="+v);
	document.open("replay.jsp?flag="+v,"_self","");
}
</script>
<%
	String flag=request.getParameter("flag");
int totalRows=0;
int currentPage=1;
%>
<body>
<div id="wrap">
		<center>
		<br>
			<img src="<%=session.getAttribute("image")%>">
			<br />
			<font class=title>著海学习平台的留言板</font> <a href="show.jsp">返回</a>
			<hr>
			<br>
		<form method="post" action="replay.jsp">
			<jsp:useBean id="dao8" class="sh.dao.impl.ReplyDaoSQLServerImpl"></jsp:useBean>
			<%
				if(session.getAttribute("me")!=null){
			%>
			<%
				request.setCharacterEncoding("UTF-8");
				List<Pinglun>list=null;
				int id;
				id=Integer.parseInt(session.getAttribute("p_id").toString());
				list=replydao.show(id);
				//System.out.println(id);
				
				for(Pinglun n:list){
			%>
			 <div lang="en-US" class="gitment-container gitment-comments-container">
       		 <ul class="gitment-comments-list">
             <li class="gitment-comment">
                <a class="gitment-comment-avatar">
                    <!--<img class="gitment-comment-avatar-img" src="">  -->
                </a>
                <div class="gitment-comment-main">
                    <div class="gitment-comment-header">
                        <a class="gitment-comment-name">
                            <%=n.getH_nc()%>
                        </a>
                        <span><%=n.getCreate_time()%></span>

                    </div>
                    <div class="gitment-comment-body gitment-markdown"><p><%=n.getP_content()%></p></div>
                   
                    </div>
                </li>
        </ul>
    </div>
			<%
				}
			%>
			
			</form>
			<hr>
    <div class="test">
	<form action="replay.jsp?flag=first" method="post">
			<jsp:useBean id="spage" class="sh.util.SplitPage" scope="session"></jsp:useBean>
			<jsp:useBean id="dao7" class="sh.dao.impl.ReplyDaoSQLServerImpl" scope="session"></jsp:useBean>
			<%
			request.setCharacterEncoding("UTF-8");
			List<Reply> list1=null;
			int p_id;
			p_id=Integer.parseInt(session.getAttribute("p_id").toString());
			totalRows=replydao.getRows(p_id);
			//System.out.println(totalRows);
			spage.setTotalRows(totalRows);
			currentPage=spage.confirmPage(flag);
			list1=replydao.findAll(spage,p_id);
			//System.out.println(spage);
			for(Reply m:list1){
			%>
        <div lang="en-US" class="gitment-container gitment-comments-container">
        <ul class="gitment-comments-list">
            <li class="gitment-comment">
                <a class="gitment-comment-avatar">
                    <!--<img class="gitment-comment-avatar-img" src="">  -->
                </a>
                <div class="gitment-comment-main">
                    <div class="gitment-comment-header">
                        <a class="gitment-comment-name">
                            <%=m.getH_nc() %>
                        </a>
                        <span><%=m.getCreate_time() %></span>

                    </div>
                    <div class="gitment-comment-body gitment-markdown"><p><%=m.getR_content()%></p></div>
                    
                   <!-- <button id="btn2" class="gitment-editor-submit btn-reply" title="Login to Comment">回复</button>   --> 
                     <input type="hidden" name="m_id" value="<%=session.getAttribute("m_id") %>"> 
                    </div>
                </li>
        </ul>
    </div>
    
    		<% }%>
    <div id="foot">
    			<a href="replay.jsp?flag=<%=SplitPage.FIRSTPAGE%>">首页</a>
    			<a href="replay.jsp?flag=<%=SplitPage.PREVIOUSEPAGE%>">上一页</a>
    			<a href="replay.jsp?flag=<%=SplitPage.NEXTPAGE%>">下一页</a>
    			<a href="replay.jsp?flag=<%=SplitPage.LASTPAGE%>">尾页</a>
    		</div>
    		<select id="selectPage" name="selectPage" onchange="JavaScript:goPage();">
    			<%
for(int i=1;i<=spage.getTotalPages();++i){
%>
				<option value="<%=i %>"
					<%=(spage.getCurrentPage()==i)?"selected='selected'":"" %>><%=i %>/<%=spage.getTotalPages() %></option>
				<% } %>
    		</select>
    		<% }%>
    		</form>
    <form action="ReplyServlet" method="post">
    <div lang="en-US" class="gitment-container gitment-editor-container">
        <div class="gitment-editor-main">
            <div class="gitment-editor-header">
                <nav class="gitment-editor-tabs">
                    <p class="gitment-editor-tab gitment-selected"><%=session.getAttribute("me") %></p>
                </nav>
            </div>
            <div class="gitment-editor-body">
                <div class="gitment-editor-write-field">
                    <textarea placeholder="你想说些什么" title="Login to Comment" name="content"></textarea>
                </div>
                <div class="gitment-editor-preview-field gitment-hidden">
                    <div class="gitment-editor-preview gitment-markdown"></div>
                </div>
            </div>
        </div>
        <div class="gitment-editor-footer">
            <button class="gitment-editor-submit" title="Login to Comment" onclick=" return check_admin(form)">评论</button>
            <input type="hidden" name="author" value="<%=session.getAttribute("me") %>"> 
    	    <input type="hidden" name="p_id" value="<%=session.getAttribute("p_id") %>"> 
        </div>
    </div>
    </form>
    </div>
    </div>
	</center>
</body>
</html>