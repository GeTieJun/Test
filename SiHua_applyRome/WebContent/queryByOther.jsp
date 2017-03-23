<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/queryByOther.css" />
<script type="text/javascript" src="js/jquery.js"></script>
<title>QueryByOther</title>
<script type="text/javascript">
	$(document).ready(function(){

		//点击查询按钮响应事件
		$("#query_Button").click(function(){
			buttonQuery();			
		});
		
		//点击查看预约信息响应信息
		$(".roomAppointmentInfo").live("click", function(){
			var roomNum = $(this).parent().parent().children(".roomNum").text();
			appointmentRoomInfo(roomNum);
		});
	});
	
	
	//点击查询按钮的时候响应事件
	function buttonQuery(){
		$("#first_table").remove();
		var number = $("#number_input").val();
		var capacity = $("#capacity_input").val();
		var projector = $("#projector_input").val();
		$.ajax({
			type: "post",
			url: "findByRoomAction.action",
			data: "number="+number+"&capacity="+capacity+"&projector="+projector,
			success: function(json){
				var first_table = $("<table id='first_table' width='100%' border='0' cellspacing='0' cellpadding='0'></table>");
				var big_tr = $("<tr></tr>");
				var big_td = $("<td height='40'></td>");
				var table = $("<table width='100%' border='0' cellpadding='4' cellspacing='1' bgcolor='#464646' class='newfont03'></table>");
				var title_tr = $("<tr></tr>");
				var title_td = $("<td height='20' colspan='8' align='center' bgcolor='#EEEEEE'>查询信息</td>");
				var title_tr_Info = $("<tr  align='center'></tr>");
				var title_td_num = $("<td width='4%' bgcolor='#EEEEEE'>会议室编号</td>");
				var title_td_capacity = $("<td width='13%' height='20' bgcolor='#EEEEEE'>会议室容纳人数</td>");
				var title_td_projector = $("<td width='10%' bgcolor='#EEEEEE'>投影设备</td>");
				var title_appoInfo_but = $("<td width='7%' bgcolor='#EEEEEE'>查看预约信息</td>");
				var title_appointment_but = $("<td width='8%' bgcolor='#EEEEEE'>是否预约</td>");
				title_tr.append(title_td); 
				title_tr_Info.append(title_td_num).append(title_td_capacity).append(title_td_projector)
				.append(title_appoInfo_but).append(title_appointment_but);
				table.append(title_tr).append(title_tr_Info);
				big_td.append(table);
				big_tr.append(big_td);
				first_table.append(big_tr);
				$.each(json.roomList, function(i, obj){
					var tr = $("<tr align='center'></tr>");
					var td_num = $("<td class='roomNum' bgcolor='#FFFFFF'>"+obj.number+"</td>");
					var td_capacity = $("<td height='20' bgcolor='#FFFFFF'>"+obj.capacity+"人</td>");
					var td_projector = $("<td bgcolor='#FFFFFF'>"+obj.projector+"</td>");
					var td_appoInfo_but = $("<td bgcolor='#FFFFFF'><a class='roomAppointmentInfo'><input id='appointmentInfo' type='button' value='查看预约信息'/></a></td>");
					var td_appoint_but = $("<td bgcolor='#FFFFFF'><a href='clickApplyButtonAction.action?roomNum="+obj.number+"'><input type='button' value='预约'/></a></td>");
					tr.append(td_num).append(td_capacity).append(td_projector).append(td_appoInfo_but).append(td_appoint_but);
					table.append(tr);
				});
				$("#table_Div").append(first_table);
			}
		});
	}
	
	//点击查看预约信息触发ajax事件
	function appointmentRoomInfo(roomNum){
		$("#first_table").remove();
		$.ajax({
			type: "post",
			url: "findRoomAppointInfoAction.action",
			data: "roomNum="+roomNum,
			success: function(json){
				var first_table = $("<table id='first_table' width='100%' border='0' cellspacing='0' cellpadding='0'></table>");
				var big_tr = $("<tr></tr>");
				var big_td = $("<td height='40'></td>");
				var table = $("<table width='100%' border='0' cellpadding='4' cellspacing='1' bgcolor='#464646' class='newfont03'></table>");
				var title_tr = $("<tr></tr>");
				var title_td = $("<td height='20' colspan='8' align='center' bgcolor='#EEEEEE'>"+roomNum+"会议室信息</td>");
				var title_tr_Info = $("<tr align='center'></tr>");
				var title_td_num = $("<td width='4%' bgcolor='#EEEEEE'>会议室编号</td>");
				var title_td_startTime = $("<td width='13%' height='20' bgcolor='#EEEEEE'>开始时间</td>");
				var title_td_endTime = $("<td width='10%' bgcolor='#EEEEEE'>结束时间</td>");
				var title_td_applier = $("<td width='7%' bgcolor='#EEEEEE'>申请人</td>");
				var title_td_phoneNum = $("<td width='8%' bgcolor='#EEEEEE'>联系方式</td>");
				title_tr.append(title_td); 
				title_tr_Info.append(title_td_num).append(title_td_startTime).append(title_td_endTime)
				.append(title_td_applier).append(title_td_phoneNum);
				table.append(title_tr).append(title_tr_Info);
				big_td.append(table);
				big_tr.append(big_td);
				first_table.append(big_tr);
				$.each(json.objs, function(i, obj){
					var tr = $("<tr align='center'></tr>");
					var td_num = $("<td class='roomNum' bgcolor='#FFFFFF'>"+obj.relation.room.number+"</td>");
					var td_startTime = $("<td height='20' bgcolor='#FFFFFF'>"+obj.startTime+"</td>");
					var td_endTime = $("<td bgcolor='#FFFFFF'>"+obj.endTime+"</td>");
					var td_employeeName = $("<td bgcolor='#FFFFFF'>"+obj.relation.employee.name+"</td>");
					var td_employeePhoNum = $("<td bgcolor='#FFFFFF'>"+obj.relation.employee.phoneNum+"</td>");
					tr.append(td_num).append(td_startTime).append(td_endTime).append(td_employeeName).append(td_employeePhoNum);
					table.append(tr);
				});
				$("#table_Div").append(first_table);
			}
		});
	}
</script>
</head>
<body>
	<div id="first_Div">
		<div id="query_Div">
			<form>
				<br/>
				<input class="input_style" id="capacity_input" type="text" name="capacity" placeholder="根据人数查询(例如:50)"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input class="input_style" id="projector_input" type="text" name="projecter" placeholder="根据投影设备查询(例如:有)"/><br/><br/>
				<input class="input_style" id="number_input" type="text" name="number" placeholder="根据编号查询(例如:1101)"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input class="input_style" type="text" name="personNum" placeholder="根据现在状态查询(例如:关)"/><br/>
				<input id="query_Button" type="button" value="查询"/>
			</form>
		</div>
		<hr/>
		<div id="table_Div">
		<!--  
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="40"><table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#464646" class="newfont03">
				  <tr>
                    <td height="20" colspan="8" align="center" bgcolor="#EEEEEE">查询信息</td>
                  </tr>
                  <tr>
				    <td width="4%" align="center" bgcolor="#EEEEEE">编号</td>
                    <td width="13%" height="20" align="center" bgcolor="#EEEEEE">会议室容纳人数</td>
                    <td width="10%" align="center" bgcolor="#EEEEEE">投影设备</td>
                    <td width="7%" align="center" bgcolor="#EEEEEE">今日预约人数</td>
                    <td width="8%" align="center" bgcolor="#EEEEEE">当前状态</td>
                    <td width="7%" align="center" bgcolor="#EEEEEE">查看预约信息</td>
                    <td width="6%" align="center" bgcolor="#EEEEEE">是否预约</td>    
                  </tr>
                  <tr align="center">
				    <td bgcolor="#FFFFFF">001</td>
                    <td height="20" bgcolor="#FFFFFF">60人</td>
                    <td bgcolor="#FFFFFF">有</td>
                    <td bgcolor="#FFFFFF">3人</td>
                    <td bgcolor="#FFFFFF">使用</td>
                    <td bgcolor="#FFFFFF"><a href="applyRoomInfo.jsp"><input type="button" value="查看预约信息"/></a></td>
                    <td bgcolor="#FFFFFF"><a href="apply.jsp"><input type="button" value="预约"/></a></td>
                  </tr>
                 <tr align="center">
				    <td bgcolor="#FFFFFF">002</td>
                    <td height="20" bgcolor="#FFFFFF">60人</td>
                    <td bgcolor="#FFFFFF">有</td>
                    <td bgcolor="#FFFFFF">3人</td>
                    <td bgcolor="#FFFFFF">使用</td>
                    <td bgcolor="#FFFFFF"><a href="applyRoomInfo.html"><input type="button" value="查看预约信息"/></a></td>
                    <td bgcolor="#FFFFFF"><a href="apply.html"><input type="button" value="预约"/></a></td>
                  </tr>
                  <tr align="center">
				    <td bgcolor="#FFFFFF">003</td>
                    <td height="20" bgcolor="#FFFFFF">60人</td>
                    <td bgcolor="#FFFFFF">有</td>
                    <td bgcolor="#FFFFFF">3人</td>
                    <td bgcolor="#FFFFFF">使用</td>
                    <td bgcolor="#FFFFFF"><a href="applyRoomInfo.html"><input type="button" value="查看预约信息"/></a></td>
                    <td bgcolor="#FFFFFF"><a href="apply.html"><input type="button" value="预约"/></a></td>
                  </tr>
                  <tr align="center">
				    <td bgcolor="#FFFFFF">004</td>
                    <td height="20" bgcolor="#FFFFFF">60人</td>
                    <td bgcolor="#FFFFFF">有</td>
                    <td bgcolor="#FFFFFF">3人</td>
                    <td bgcolor="#FFFFFF">使用</td>
                    <td bgcolor="#FFFFFF"><a href="applyRoomInfo.html"><input type="button" value="查看预约信息"/></a></td>
                    <td bgcolor="#FFFFFF"><a href="apply.html"><input type="button" value="预约"/></a></td>
                  </tr>
                  <tr align="center">
				    <td bgcolor="#FFFFFF">005</td>
                    <td height="20" bgcolor="#FFFFFF">60人</td>
                    <td bgcolor="#FFFFFF">有</td>
                    <td bgcolor="#FFFFFF">3人</td>
                    <td bgcolor="#FFFFFF">使用</td>
                    <td bgcolor="#FFFFFF"><a href="applyRoomInfo.html"><input type="button" value="查看预约信息"/></a></td>
                    <td bgcolor="#FFFFFF"><a href="apply.html"><input type="button" value="预约"/></a></td>
                  </tr>
				  <tr align="center">
				    <td bgcolor="#FFFFFF">006</td>
                    <td height="20" bgcolor="#FFFFFF">60人</td>
                    <td bgcolor="#FFFFFF">有</td>
                    <td bgcolor="#FFFFFF">3人</td>
                    <td bgcolor="#FFFFFF">使用</td>
                    <td bgcolor="#FFFFFF"><a href="applyRoomInfo.html"><input type="button" value="查看预约信息"/></a></td>
                    <td bgcolor="#FFFFFF"><a href="apply.html"><input type="button" value="预约"/></a></td>
                  </tr>
				  <tr align="center">
				    <td bgcolor="#FFFFFF">007</td>
                    <td height="20" bgcolor="#FFFFFF">60人</td>
                    <td bgcolor="#FFFFFF">有</td>
                    <td bgcolor="#FFFFFF">3人</td>
                    <td bgcolor="#FFFFFF">使用</td>
                    <td bgcolor="#FFFFFF"><a href="applyRoomInfo.html"><input type="button" value="查看预约信息"/></a></td>
                    <td bgcolor="#FFFFFF"><a href="apply.html"><input type="button" value="预约"/></a></td>
                  </tr>
				  
                </table></td>
              </tr>
            </table>  -->
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