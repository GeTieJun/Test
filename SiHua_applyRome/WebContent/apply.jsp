<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/jquery.js"></script>
<title>applyRoom</title>
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
    font-family: ;
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
			var roomNum = $("#roomNum").val();
			var startTime = $("#startTime").val();
			var endTime = $("#endTime").val();
			
			$.ajax({
				type: "post",
				url: "saveRoomAction.action",
				data: "roomNum="+roomNum+"&startTime="+startTime+"&endTime="+endTime,
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
			<span id="title_Span">会议室申请</span>
		</div>
		<div id="from_Div">
			<form>
				会议室编号:<input id="roomNum" type="text" name="number" value=${sessionScope.roomNum }>&nbsp;&nbsp;&nbsp;
				&nbsp;申请人:<input type="text" name="userName" value=${sessionScope.userName }><br><br>
				&nbsp;开始时间:<input id="startTime" type="datetime-local" name="apply.startDate" placeholder="2017-01-01 14:30:00"/>&nbsp;&nbsp;&nbsp;
				结束时间:<input id="endTime" type="datetime-local" name="apply.endDate" placeholder="2017-01-01 17:00:00"/><br><br>			
				&nbsp;联系方式:<input type="text" name="phone" value=${sessionScope.phoneNum }><br><br>
				<input id="button_style" type="button" value="申请"/>
			</form>
		</div>
	</div>
</body>
</html>