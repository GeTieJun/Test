<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AppointmentInfo</title>
<script type="text/javascript" src="js/jquery.js"></script>
<style type="text/css">
body{
	margin: 0px;
}
.newfont03 {
	font-family: "????";
	font-size: 12px;
	color: #000000;
	text-decoration: none;
	text-align: center;
}
.input_style{
	width: 200px;
    height: 20px;
}
.right-font08 {
	font-family: "????";
	font-size: 12px;
	color: #555555;
	text-decoration: none;
}
.right-text09 {
	font-family: Tahoma;
	font-size: 11px;
	font-weight: bold;
	color: #F26521;
	text-decoration: none;
}
.right-button06 {
	font-family: "????";
	font-size: 12px;
	color: #174B73;
	height: 20px;
	width: 24px;
	background-image: url(images/button08.gif);
	border-top-width: 0px;
	border-right-width: 0px;
	border-bottom-width: 0px;
	border-left-width: 0px;
}
.right-textfield03 {
	font-family: Tahoma;
	font-size: 11px;
	color: #555555;
	text-decoration: none;
	height: 14px;
}
a.right-font08:hover {
	font-family: "????";
	font-size: 12px;
	color: #FF0000;
	text-decoration: underline;
}	
</style>
<script type="text/javascript">
	$(document).ready(function(){
		var oldStartTime = null;
		var oldEndTime = null;
		var newStartTime = null;
		var newEndTime = null;
		var number = null;
		//页面刷新时由前台向后台发送的请求
		$.ajax({
			type: "post",
			url: "findEmployeeAllInfoAction.action",
			success: function(json){
				var first_table = $("<table width='100%' border='0' cellspacing='0' cellpadding='0'></table>");
				var big_tr = $("<tr></tr>");
				var big_td = $("<td height='40'></td>");
				var table = $("<table width='100%' border='0' cellpadding='4' cellspacing='1' bgcolor='#464646' class='newfont03'></table>");
				var title_tr = $("<tr></tr>");
				var title_td = $("<td height='20' colspan='8' align='center' bgcolor='#EEEEEE'>个人预约信息表</td>");
				var title_tr_Info = $("<tr></tr>");
				var title_td_num = $("<td width='4%' bgcolor='#EEEEEE'>会议室编号</td>");
				var title_td_startTime = $("<td width='13%' height='20' bgcolor='#EEEEEE'>开始时间</td>");
				var title_td_endTime = $("<td width='10%' bgcolor='#EEEEEE'>结束时间</td>");
				var title_change_but = $("<td width='7%' bgcolor='#EEEEEE'>变更/确认</td>");
				var title_cancel_but = $("<td width='8%' bgcolor='#EEEEEE'>取消预约</td>");
				title_tr.append(title_td); 
				title_tr_Info.append(title_td_num).append(title_td_startTime).append(title_td_endTime)
				.append(title_change_but).append(title_cancel_but);
				table.append(title_tr).append(title_tr_Info);
				big_td.append(table);
				big_tr.append(big_td);
				first_table.append(big_tr);
				$.each(json.objs, function(i,obj){
					var tr = $("<tr></tr>");
					var td_num = $("<td class='roomNum' bgcolor='#FFFFFF'>"+obj.relation.room.number+"</td>");
					var td_startTime = $("<td height='20' bgcolor='#FFFFFF'><input class='startTime' type='text' name='startTime' value='"+obj.startTime+"' readonly='readonly'/></td>");
					var td_endTime = $("<td bgcolor='#FFFFFF'><input class='endTime' type='text' name='endTime' value='"+obj.endTime+"' readonly='readonly'/></td>");
					var td_change_but = $("<td bgcolor='#FFFFFF'><input class='changeButton' type='button' value='变更'/></td>");
					var td_cancel_but = $("<td bgcolor='#FFFFFF'><input class='cancelAppointment' type='button' value='取消预约'/></td>");
					tr.append(td_num).append(td_startTime).append(td_endTime).append(td_change_but).append(td_cancel_but);
					table.append(tr);
				});
				$("#table_Div").append(first_table);
			}
		});
		
		//点击按钮"取消"或者"确认"时响应事件
		$(".changeButton").live("click", function(){
			if($(this).val() == "变更"){
				oldStartTime = $(this).parent().parent().children().children(".startTime").val();
				oldEndTime = $(this).parent().parent().children().children(".endTime").val();
				number=$(this).parent().parent().children(".roomNum").text();
				$(this).val("确认");
				$(this).parent().parent().children().children(".startTime").attr("readonly",false);
				$(this).parent().parent().children().children(".startTime").css("background-color","rgba(180, 255, 0, 0.29)");
				//$(this).parent().parent().children().children(".startTime").attr("type","datetime-local");
				$(this).parent().parent().children().children(".endTime").attr("readonly",false);
				$(this).parent().parent().children().children(".endTime").css("background-color","rgba(180, 255, 0, 0.29)");
				//$(this).parent().parent().children().children(".endTime").attr("type","datetime-local");
			}
			else{
				newStartTime = $(this).parent().parent().children().children(".startTime").val();
				newEndTime = $(this).parent().parent().children().children(".endTime").val();
				$(this).val("变更");
				$(this).parent().parent().children().children(".startTime").attr("readonly",true);
				$(this).parent().parent().children().children(".startTime").css("background-color","rgba(0, 0, 0, 0)");
				$(this).parent().parent().children().children(".endTime").attr("readonly",true);
				$(this).parent().parent().children().children(".endTime").css("background-color","rgba(0, 0, 0, 0)");
				updateTime(oldStartTime, oldEndTime, newStartTime, newEndTime,number);
			}
		});
	
		//点击取消按钮触发事件
		$(".cancelAppointment").live("click", function(){ 
			oldStartTime = $(this).parent().parent().children().children(".startTime").val();
			oldEndTime = $(this).parent().parent().children().children(".endTime").val();
			number=$(this).parent().parent().children(".roomNum").text();
			newStartTime = $(this).parent().parent().children().children(".startTime").val();
			newEndTime = $(this).parent().parent().children().children(".endTime").val();
			deleteAppointmentInfo(oldStartTime, oldEndTime, newStartTime, newEndTime, number);
			$(this).parent().parent().remove();  //将改行从table中移除
		});
	});	
	
	//当点击(更改/确认)时响应请求
	function updateTime(oldStartTime, oldEndTime, newStartTime, newEndTime,number){
		$.ajax({
			type: "post",
			url: "updateApplyDateAction.action",
			data: "oldStartTime="+oldStartTime+"&oldEndTime="+oldEndTime+"&newStartTime="+newStartTime+"&newEndTime="+newEndTime+"&number="+number,
			success: function(json){
				alert(json.message);
			}
		});
	}
	
	//当点击取消预约响应事件
	function deleteAppointmentInfo(oldStartTime, oldEndTime, newStartTime, newEndTime,number){
		$.ajax({
			type: "post",
			url: "deleteApplyRoom.action",
			data: "oldStartTime="+oldStartTime+"&oldEndTime="+oldEndTime+"&newStartTime="+newStartTime+"&newEndTime="+newEndTime+"&number="+number,
			success: function(json){
				alert(json.message);
			}
		});
	}
</script>
</head>
<body>
	<div id="first_Div">
		<div id="table_Div">
		   <!--  
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="40"><table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#464646" class="newfont03">
				  <tr>
                    <td height="20" colspan="8" align="center" bgcolor="#EEEEEE">个人预约信息表</td>
                  </tr>
                  <tr>
				    <td width="4%" bgcolor="#EEEEEE">编号</td>
                    <td width="13%" height="20" bgcolor="#EEEEEE">开始时间</td>
                    <td width="10%" bgcolor="#EEEEEE">结束时间</td>
                    <td width="7%" bgcolor="#EEEEEE">变更/确认</td>
                    <td width="8%" bgcolor="#EEEEEE">取消预约</td>   
                  </tr>
                  <tr>
				    <td bgcolor="#FFFFFF">001</td>
                    <td height="20" bgcolor="#FFFFFF"><input class="startTime" type="text" name="startTime" value="2017-01-01 13:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="endTime" type="text" name="endTime" value="2017-01-01 15:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="变更"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancelAppointment" type="button" value="取消预约"/></td>
                  </tr>
                 <tr>
				    <td bgcolor="#FFFFFF">002</td>
					<td height="20" bgcolor="#FFFFFF"><input class="startTime" type="text" name="startTime" value="2017-02-01 13:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="endTime" type="text" name="endTime" value="2017-02-01 15:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="变更"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancelAppointment" type="button" value="取消预约"/></td>
                  </tr>
                  <tr>
				    <td bgcolor="#FFFFFF">003</td>
					<td height="20" bgcolor="#FFFFFF"><input class="startTime" type="text" name="startTime" value="2017-03-01 13:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input type="text" class="endTime" name="endTime" value="2017-03-01 15:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="变更"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancelAppointment" type="button" value="取消预约"/></td>
                  </tr>
                  <tr>
				    <td bgcolor="#FFFFFF">004</td>
					<td height="20" bgcolor="#FFFFFF"><input class="startTime" type="text" name="startTime" value="2017-04-01 13:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="endTime" type="text" name="endTime" value="2017-04-01 15:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="变更"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancelAppointment" type="button" value="取消预约"/></td>
                  </tr>
                  <tr>
				    <td bgcolor="#FFFFFF">005</td>
					<td height="20" bgcolor="#FFFFFF"><input class="startTime"type="text" name="startTime" value="2017-05-01 13:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="endTime" type="text" name="endTime" value="2017-05-01 15:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="变更"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancelAppointment" type="button" value="取消预约"/></td>
                  </tr>
				  <tr>
				    <td bgcolor="#FFFFFF">006</td>
					<td height="20" bgcolor="#FFFFFF"><input class="startTime"type="text" name="startTime" value="2017-06-01 13:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="endTime"type="text" name="endTime" value="2017-06-01 15:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="变更"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancelAppointment" type="button" value="取消预约"/></td>
                  </tr>
				  <tr>
				    <td bgcolor="#FFFFFF">007</td>
					<td height="20" bgcolor="#FFFFFF"><input class="startTime"type="text" name="startTime" value="2017-06-01 13:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="endTime"type="text" name="endTime" value="2017-06-01 15:00:00" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="变更"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancelAppointment" type="button" value="取消预约"/></td>
                  </tr>
				  
                </table></td>
              </tr>
            </table>-->
      
		</div>
		<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
         <tr>
          <td height="6"><img src="images/spacer.gif" width="1" height="1" /></td>
        </tr>
        <tr>
          <td height="33"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="right-font08">
              <tr>
                <td width="50%">共 <span class="right-text09">1</span> 页 | 第 <span class="right-text09">1</span> 页</td>
                <td width="49%" align="right">[<a href="#" class="right-font08">首页</a> | <a href="#" class="right-font08">上一页</a> | <a href="#" class="right-font08">下一页</a> | <a href="#" class="right-font08">末页</a>] 转至：</td>
                <td width="1%"><table width="20" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="1%"><input name="textfield3" type="text" class="right-textfield03" size="1"/></td>
                      <td width="87%"><input name="Submit23222" type="submit" class="right-button06" value=" " />
                      </td>
                    </tr>
                </table></td>
              </tr>
          </table></td>
        </tr>
      </table>
	</div>
</body>
</html>