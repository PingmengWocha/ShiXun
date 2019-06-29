<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sh.dao.impl.NoteDaoSQLServerImpl"%>
<%@ page import="sh.dao.noteDao" %>
<%@ page import="sh.dao.impl.PinglunDaoSQLServerImpl"%>
<%@ page import="sh.dao.pinglunDao" %>
<%@ page import="sh.factory.DAOFactory" %>    
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sh.vo.Note" %>
<%@ page import="sh.util.SplitPage" %> 
<%@ page import="sh.vo.Pinglun" %> 
<%@ page import="java.util.HashMap"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>浏览留言</title>
<%
	noteDao notedao=new NoteDaoSQLServerImpl();
	pinglunDao pinglundao=new PinglunDaoSQLServerImpl();
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
		alert("评论不能为空哦!");
		form.content.focus();
		return false;
	}
}	
function goPage(){
	var v=document.getElementById("selectPage").value;
	alert("我们将去页面ashow.jsp?flag="+v);
	document.open("ashow.jsp?flag="+v,"_self","");
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
			<font class=title>著海学习平台的留言板</font> <a href="Alist_notes.jsp">返回</a>
			<hr>
			<br>
			<form method="post" action="show.jsp">
			<jsp:useBean id="daod" class="sh.dao.impl.NoteDaoSQLServerImpl"></jsp:useBean>
			<%
				if(session.getAttribute("me")!=null){
			%>
			<%
				request.setCharacterEncoding("UTF-8");
				List<Note>list=null;
				int id;
				id=Integer.parseInt(session.getAttribute("m_id").toString());
				list=notedao.show(id);
				//System.out.println(id);
				
				for(Note n:list){
			%>
			<form>
			<h3><%=n.getM_title()%></h3><br>
			<p><%=n.getH_nc()%></p>
			<p><%=n.getCreate_time()%></p><br>
			<p><%=n.getM_content()%></p>
			</form>
			<%
				}
			%>
			</form>
			<hr>
			
    	
    <div class="test">
	<form action="show.jsp?flag=first" method="post">
			<jsp:useBean id="spage" class="sh.util.SplitPage" scope="session"></jsp:useBean>
			<jsp:useBean id="daoc" class="sh.dao.impl.PinglunDaoSQLServerImpl" scope="session"></jsp:useBean>
			<%
			request.setCharacterEncoding("UTF-8");
			List<Pinglun> list1=null;
			int m_id;
			m_id=Integer.parseInt(session.getAttribute("m_id").toString());
			//System.out.println(m_id);
			totalRows=pinglundao.getRows(m_id);
			//System.out.println(totalRows);
			spage.setTotalRows(totalRows);
			currentPage=spage.confirmPage(flag);
			list1=pinglundao.findAll(spage,m_id);
			//System.out.println(spage);
			for(Pinglun m:list1){
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
                    <div class="gitment-comment-body gitment-markdown"><p><%=m.getP_content()%></p></div>
                    <!-- <submit class="gitment-editor-submit btn-reply"><a href="IdreplyServlet?id=<%=m.getP_id()%>">回复</a></submit> -->
                    <!-- <button id="btn2" class="gitment-editor-submit btn-reply" title="Login to Comment" onclick = "window.location.href = 'replay.jsp'">回复</button> -->
                     <input type="hidden" name="m_id" value="<%=session.getAttribute("m_id") %>"> 
                    </div>
                </li>
        </ul>
    </div>
    </form>
    		<% }%>
    <div id="foot">
    			<a href="ashow.jsp?flag=<%=SplitPage.FIRSTPAGE%>">首页</a>
    			<a href="ashow.jsp?flag=<%=SplitPage.PREVIOUSEPAGE%>">上一页</a>
    			<a href="ashow.jsp?flag=<%=SplitPage.NEXTPAGE%>">下一页</a>
    			<a href="ashow.jsp?flag=<%=SplitPage.LASTPAGE%>">尾页</a>
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
    </div>
    </div>
	</center>
</body>
</html>