<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/jquery.js"></script>
<title>addEmployeeAdmin</title>
<style type="text/css">
body{
	margin:0px;
	position: relative;
}
#first_Div{
	background-color: rgba(255, 165, 0, 0.58);
    width: 52%;
	position: relative;
    left: 28%;
    margin-top: 8%;
	height: 237px;
}
#from_Div{
	position: relative;
    margin-top: 5%;
}
#title_Div{
	background-color: rgba(30, 233, 186, 0.64);
    height: 38px;
}
#button_style{
    position: relative;
    left: 88%;
	width: 48px;
    height: 25px;
    font-size: 15px;
    font-family: 微软雅黑;
    font-weight: 600;
}
#title_Span{
	display: block;
	position: relative;
	font-family: 微软雅黑;
	font-size: 18px;
	font-weight: 600;
	top: 10%;
    left: 2%;
}	
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#button_style").click(function(){
			var number = $("#number").val();
			var name = $("#name").val();
			var phoneNum = $("#phoneNum").val();
			var password = $("#password").val();
			addEmployee(number, name, phoneNum, password);
		});
		
	});
	
	
	//添加员工
	function addEmployee(number, name, phoneNum, password){
		$.ajax({
			type: "post",
			url: "addEmployeeAction.action",
			data: "number="+number+"&name="+name+"&phoneNum="+phoneNum+"&password="+password,
			success: function(json){
				alert(json.message);
			}
		});
	}
</script>
</head>
<body>
	<div id="first_Div">
		<div id="title_Div">
			<span id="title_Span">添加员工</span>
		</div>
		<div id="from_Div">
			<form>
				&nbsp;员工编号:<input id="number" type="text" name="number" placeholder="001(不可重复)"/>&nbsp;&nbsp;
				&nbsp;员工姓名:<input id="name" type="text" name="name" placeholder="张三"/><br></br>
				&nbsp;联系方式:<input id="phoneNum" type="text" name="phoneNum" placeholder="18829345930"/>&nbsp;&nbsp;&nbsp;
				初始密码:<input id="password" type="text" name="password" value="123456"/><br><br>			
				<input id="button_style" type="submit" value="添加"/>
			</form>
		</div>
	</div>
</body>
</html>
