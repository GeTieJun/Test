<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ChangePassword</title>
<script type="text/javascript" src="js/jquery.js"></script>
<style type="text/css">
	#first_Div{
		width: 600px;
		height: 300px;
		position: relative;
		left: 29%;
		top: 60px;
		border: 1px solid;
		background-color: rgba(255, 165, 0, 0.58);
	}
	#title_Div{
		width: 600px;
		height: 45px;
		background-color: rgba(30, 233, 186, 0.64);
	}
	body{
		position: relative;
		margin: 0px;
	}
	#title_Span{
		display: block;
		position: relative;
		left: 3%;
		top: 24%;
		font-family: 微软雅黑;
		font-size: 18px;
		font-weight: 600;
	}
	#from_Div{
		height: 177px;
		position: relative;
	}
	form{
		position: relative;
		margin-top: 9%;
		left: 6%;
	}
	#button{
		position: relative;
		left: 74%;
		margin-top: 1%;
		width: 48px;
		height: 25px;
		font-size: 15px;
		font-family: 微软雅黑;
		font-weight: 600;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		$("#button").click(function(){
			var password = $("#updatePassword").val();
			$.ajax({
				type: "post",
				url: "updatePasswordAction.action",
				data: "newPassword="+password,
				success: function(json){
					alert(json.message);
				}
			});
		});
	});

</script>
</head>
<body>
	<div id="first_Div">
		<div id="title_Div">
			<span id="title_Span">用户密码修改</span>
		</div>
		<div id="from_Div">
			<form method="post">
				用户名称:<input type="text" name="employee.name" value=${sessionScope.userName } readonly="readonly"/>&nbsp;&nbsp;&nbsp;
				职称:<input type="text" name="employee.position" value=${sessionScope.position } readonly="readonly"><br/><br/>
				&nbsp;&nbsp;密码:<input id="updatePassword" type="password" name="password"/>
				&nbsp;确认密码:<input type="password" name="repassword"/><br/><br/>
				<input id="button" type="submit" value="保存"/>
			</form>
		</div>
	</div>
</body>
</html>