<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/jquery.js"></script>
<title>addRoomAdmin</title>
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
#button_Style{
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
		$("#button_Style").click(function(){
			var number = $("#number").val();
			var capacity = $("#capacity").val();
			var projector = $("#projector").val();
			addRome(number, capacity, projector);
		});
	});
	
	function addRome(number, capacity, projector){
		$.ajax({
			type: "post",
			url: "addRoomAction.action",
			data: "number="+number+"&capacity="+capacity+"&projector="+projector,
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
			<span id="title_Span">添加会议室</span>
		</div>
		<div id="from_Div">
			<form>
				&nbsp;会议室编号:<input id="number" type="text" name="number" placeholder="1101"/>&nbsp;&nbsp;
				&nbsp;容纳人数:<input id="capacity" type="text" name="capacity" placeholder="60"/></br></br>
				&nbsp;&nbsp;投影设备:<select id="projector" name="projector">
					<option value="有">有</option>
					<option value="无">无</option>
				</select><br/><br/>			
				<input id="button_Style" type="submit" value="添加"/>
			</form>
		</div>
	</div>
</body>
</html>
