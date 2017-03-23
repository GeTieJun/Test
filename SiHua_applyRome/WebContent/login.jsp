<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/login.css" />
<title>LOGIN</title>
</head>
<body>
	<div id ="login_TopDiv">
		<div id="pictureDiv"><img alt=""src="images/logo.jpg"></div>
	</div>
	<div id = "login_FirstDiv"><img alt=""src="images/login_picture1.png" style="height: 300px; width:860px">
		<div id = "login_FormDiv">
			<div id = "login_FormScnDiv">
				<span id="login_FromSpan">用户登录/LOGIN</span><hr/>
			</div>
			<form id= "login_FormId" action="loginAction.action" method="post">
				<div id= "fromDiv" class="fromFort">
				&nbsp;用户名：<input type="text" name="employee.name" placeholder="输入用户名"></input><br/><br/>
				&nbsp;密&nbsp;码：<input type="password" name="employee.password" placeholder="输入用户密码"></input><br/></br>
				密码确认：<input type="password" name="rePassword" placeholder="密码确认"></input><br/></br>
				&nbsp;&nbsp;&nbsp;<input type="radio" name="employee.position" value="staff" checked="checked">员工&nbsp;&nbsp;
				<input type="radio" name="employee.position" value="admin">管理员<br/></br>
				&nbsp;&nbsp;&nbsp;<input id="submitId" class="buttonClass" type="submit" name="submit" value="登录">&nbsp;&nbsp;&nbsp;&nbsp;
				<input id="resetId" type="reset" class="buttonClass" value="重置">
				</div>
			</form>
		</div>
	</div>
</body>
</html>