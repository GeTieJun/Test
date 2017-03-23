<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RoomInfo</title>
<link rel="stylesheet" type="text/css" href="css/roomInfo.css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			type: "post",
			url: "allRoomInfoAction.action",
			success: function(json){
				var div = $("<div id = 'first_Div'></div>");
				var table = $("<table id='table_Room' cellpadding='10' cellspacing='15'></table>");
				var tr = null;
				$.each(json.roomList, function(i,obj){
					if((i % 6) == 0 ){
						tr = $("<tr></tr>");
						table.append(tr);
					}
					var td = $("<td></td>");
					var room_Div = $("<div class='all_Rome'></div>");
					var room_State_Div = $("<div class='room_State'></div>");
					var hr = $("<hr/>");
					var number_Span = $("<span class='roomNum'>编号:"+obj.number+"</span><br/>");
					var capacity_Span = $("<span>会议室容纳人数:"+obj.capacity+"</span><br/>");
					var projector_State = $("<span>投影仪状态:"+obj.projector+"</span><br/>");
					var button = $("<a href='clickApplyButtonAction.action?roomNum="+obj.number+"'><input class='applyButton' type='button' value='申请'/></a>");
					td.append(room_Div).append(room_State_Div).append(hr).append(number_Span)
					.append(capacity_Span).append(projector_State).append(button);
					tr.append(td);
				});
				div.append(table);
				var div_bottom = $("<div style='height:40px;'></div>");
				$("body").append(table).append(div_bottom);
			}
		});
		
	});
</script>
</head>
<body>
</body>
</html>