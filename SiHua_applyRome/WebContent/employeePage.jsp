<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML><HEAD><TITLE>思华科技会议室申请</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8"><LINK 
href="css/style.css" type="text/css" rel=stylesheet>
<STYLE>
.main_left {
	TABLE-LAYOUT: auto; BACKGROUND: url(images/left_bg.gif);
}
.main_left_top {
	BACKGROUND: url(images/left_menu_bg.gif); PADDING-TOP: 5px
}
.main_left_title {
	PADDING-LEFT: 15px; FONT-WEIGHT: bold; FONT-SIZE: 14px; COLOR: #fff; TEXT-ALIGN: left
}
.left_iframe {
	BACKGROUND: none transparent scroll repeat 0% 0%; VISIBILITY: inherit; WIDTH: 180px; HEIGHT: 92%
}
.main_iframe {
	Z-INDEX: 1; VISIBILITY: inherit; WIDTH: 100%; HEIGHT: 92%
}
TABLE {
	FONT-SIZE: 12px; FONT-FAMILY: tahoma, 宋体, fantasy
}
TD {
	FONT-SIZE: 12px; FONT-FAMILY: tahoma, 宋体, fantasy
}
</STYLE>

<SCRIPT language=javaScript src="js/admin.js" type="text/javascript"></SCRIPT>
<SCRIPT language=javascript src="js\Admin(1).js"></SCRIPT>

<SCRIPT>
var status = 1;
var Menus = new DvMenuCls;
document.onclick=Menus.Clear;
function switchSysBar(){
     if (1 == window.status){
		  window.status = 0;
          switchPoint.innerHTML = '<img src="images/left.gif">';
          document.all("frmTitle").style.display="none";
     }
     else{
		  window.status = 1;
          switchPoint.innerHTML = '<img src="images/right.gif">';
          document.all("frmTitle").style.display="";
     }
}
</SCRIPT>

<META content="MSHTML 6.00.2900.5726" name=GENERATOR></HEAD>
<BODY style="MARGIN: 0px; height: 700px"><!--导航部分-->
<DIV class=top_table>
<DIV class=top_table_leftbg>
<DIV class=system_logo><IMG src="images/SiHauLogo.jpg"></DIV>
</DIV></DIV>
<TABLE style="BACKGROUND: #337abb" height="92%" cellSpacing=0 cellPadding=0 
width="100%" border=0>
  <TBODY>
  <TR>
    <TD class=main_left id=frmTitle vAlign=top align=middle name="fmTitle">
      <TABLE class=main_left_top cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR height=32>
          <TD vAlign=top></TD>
          <TD class=main_left_title id=leftmenu_title>功能选择</TD>
          <TD vAlign=top align=right></TD></TR></TBODY></TABLE>
          <iframe class=left_iframe id=frmleft name=frmleft 
      src="left/left.jsp" frameBorder=0 allowTransparency>
          </iframe>
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR height=32>
          <TD vAlign=top></TD>
          <TD vAlign=bottom align=middle></TD>
          <TD vAlign=top align=right></TD></TR></TBODY></TABLE></TD>
    <TD style="WIDTH: 10px" bgColor=#337abb>
      <TABLE height="100%" cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD style="HEIGHT: 100%" onclick=switchSysBar()><SPAN class=navPoint 
            id=switchPoint title=关闭/打开左栏><IMG 
            src="images/right.gif"></SPAN> 
        </TD></TR></TBODY></TABLE></TD>
    <TD vAlign=top width="100%" style="background-color: rgba(255, 255, 255, 1);">
      <TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed 
        border=0><TBODY>
        <TR height=32>
          <TD vAlign=top width=10 
          background="images/bg2.gif"><IMG alt="" 
            src="images/teble_top_left.gif"></TD>
          <TD width=28 
          background="images/bg2.gif"></TD>
          <TD background="images/bg2.gif"><SPAN 
            style="FLOAT: left;">思华科技会议室申请</SPAN><SPAN 
            id=dvbbsannounce 
            style="FONT-WEIGHT: bold; FLOAT: left; WIDTH: 300px; COLOR: #c00"></SPAN></TD>
          <TD style="COLOR: #135294; TEXT-ALIGN: right" 
          background="images/bg2.gif"><span>用户名:<span>&nbsp;${sessionScope.userName}</span></span>| <A 
            href="employeePage.jsp" target=_top>首页</A> 
            | <A href="changePassword.jsp" target=frmright >修改密码</A> | <A 
            href="javascript:AdminOut()" target=_top>退出</A> </TD>
          <TD vAlign=top align=right width=28 
          background="images/bg2.gif"><IMG alt="" 
            src="images/bg2.gif"></TD>
          <TD align=right width=16 background="images/bg2.gif" style="background-color: rgba(255, 255, 255, 1);"></TD></TR></TBODY></TABLE>
		  
		  <!-- 主题页面-->
		  
		  <iframe class=main_iframe id=frmright name=frmright 
      		src="roomInfo.jsp" frameBorder=0 scrolling=yes>
      	  </iframe>
      <TABLE style="BACKGROUND: #c4d8ed" cellSpacing=0 cellPadding=0 
      width="100%" border=0>
        <TBODY>
        <TR>
          <TD><IMG height=6 alt="" 
            src="images/teble_bottom_left.gif" 
            width=5></TD>
          <TD align=right><IMG height=6 alt="" 
            src="images/teble_bottom_right.gif" 
            width=5></TD>
          <TD align=right width=16 
  bgColor=#337abb></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<DIV id=dvbbsannounce_true style="DISPLAY: none"></DIV>
</BODY></HTML>