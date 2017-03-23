<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>employeeInfoAdmin</title>
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
#div_Button{
	height: 80px;
}
#input_Button{
	width: 80px;
    height: 30px;
    font-family: 微软雅黑;
    font-weight: 500;
    position: relative;
    left: 80%;
    margin-top: 3%;
}	
</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		//当刷新页面时响应请求，得到所有员工的信息
		$.ajax({
			type: "post",
			url: "findAllEmployeeAction.action",
			success: function(json){
				var first_table = $("<table width='100%' border='0' cellspacing='0' cellpadding='0'></table>");
				var big_tr = $("<tr></tr>");
				var big_td = $("<td height='40'></td>");
				var table = $("<table width='100%' border='0' cellpadding='4' cellspacing='1' bgcolor='#464646' class='newfont03'></table>");
				var title_tr = $("<tr></tr>");
				var title_td = $("<td height='20' colspan='8' align='center' bgcolor='#EEEEEE'>员工信息管理表</td>");
				var title_tr_Info = $("<tr></tr>");
				var title_td_num = $("<td width='4%' bgcolor='#EEEEEE'>员工编号</td>");
				var title_td_name = $("<td width='13%' height='20' bgcolor='#EEEEEE'>姓名</td>");
				var title_td_phoneNum = $("<td width='10%' bgcolor='#EEEEEE'>联系方式</td>");
				var title_change_but = $("<td width='7%' bgcolor='#EEEEEE'>修改/确认</td>");
				var title_delete_but = $("<td width='8%' bgcolor='#EEEEEE'>删除</td>");
				title_tr.append(title_td); 
				title_tr_Info.append(title_td_num).append(title_td_name).append(title_td_phoneNum)
				.append(title_change_but).append(title_delete_but);
				table.append(title_tr).append(title_tr_Info);
				big_td.append(table);
				big_tr.append(big_td);
				first_table.append(big_tr);
				$.each(json.employees, function(i,obj){
					var tr = $("<tr></tr>");
					var td_num = $("<td class='table_number' bgcolor='#FFFFFF'>"+obj.number+"</td>");
					var td_name = $("<td height='20' bgcolor='#FFFFFF'><input class='table_employeeName' type='text' name='userName' value='"+obj.name+"' readonly='readonly'/></td>");
					var td_phoneNum = $("<td bgcolor='#FFFFFF'><input class='table_phoneNum' type='text' name='phoneNum' value='"+obj.phoneNum+"' readonly='readonly'/></td>");
					var td_change_but = $("<td bgcolor='#FFFFFF'><input class='changeButton' type='button' value='修改'/></td>");
					var td_delete_but = $("<td bgcolor='#FFFFFF'><input class='cancalAppointment' type='button' value='删除'/></td>");
					tr.append(td_num).append(td_name).append(td_phoneNum).append(td_change_but).append(td_delete_but);
					table.append(tr);
				});
				$("#table_Div").append(first_table);
			}
		});
		
		
		$(".changeButton").live("click", function(){
			if($(this).val() == "修改"){
				$(this).val("确认");
				$(this).parent().parent().children().children(".table_employeeName").attr("readonly",false);
				$(this).parent().parent().children().children(".table_employeeName").css("background-color","rgba(180, 255, 0, 0.29)");
				$(this).parent().parent().children().children(".table_phoneNum").attr("readonly",false);
				$(this).parent().parent().children().children(".table_phoneNum").css("background-color","rgba(180, 255, 0, 0.29)");
			}
			else{
				$(this).val("修改");
				var number = $(this).parent().parent().children(".table_number").text();
				var name = $(this).parent().parent().children().children(".table_employeeName").val();
				var phoneNum = $(this).parent().parent().children().children(".table_phoneNum").val();
				changeEmployeeInfo(number, name, phoneNum);
				$(this).parent().parent().children().children(".table_employeeName").attr("readonly",true);
				$(this).parent().parent().children().children(".table_employeeName").css("background-color","rgba(0,0,0,0)");
				$(this).parent().parent().children().children(".table_phoneNum").attr("readonly",true);
				$(this).parent().parent().children().children(".table_phoneNum").css("background-color","rgba(0,0,0,0)");
			}
		});
				

		$(".cancalAppointment").live("click", function(){
			var number = $(this).parent().parent().children(".table_number").text();
			deleteEmployeeByNum(number);
			$(this).parent().parent().remove();
		});
		
	});
	
	//根据员工编号更改员工信息事件
	function changeEmployeeInfo(number, name, phoneNum){
		$.ajax({
			type: "post",
			url: "changeEmployeeByNumAction.action",
			data: "number="+number+"&name="+name+"&phoneNum="+phoneNum,
			success: function(json){
				alert(json.message);
			}
		});
	}
	
	//根据员工好删除员工
	function deleteEmployeeByNum(number){
		$.ajax({
			type: "post",
			url: "deleteEmployeeByNumAction.action",
			data: "number="+number,
			success: function(json){
				alert(json.message);
			}
		});
	}
</script>
</head>
<body>
	<div id="first_Div">
		<div id="div_Button">
			<a href="addEmployeeAdmin.jsp"><input id="input_Button" type="button" value="添加员工"/></a>
			<hr/>
		</div>
		<div id="table_Div">
		<!--  
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="40"><table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#464646" class="newfont03">
				  <tr>
                    <td height="20" colspan="8" align="center" bgcolor="#EEEEEE">员工信息管理表</td>
                  </tr>
                  <tr>
				    <td width="4%" bgcolor="#EEEEEE">编号</td>
                    <td width="13%" height="20" bgcolor="#EEEEEE">姓名</td>
                    <td width="10%" bgcolor="#EEEEEE">联系方式</td>
                    <td width="7%" bgcolor="#EEEEEE">修改/确认</td>
                    <td width="8%" bgcolor="#EEEEEE">删除</td>   
                  </tr>
                  <tr>
				    <td bgcolor="#FFFFFF"><input class="table_Number" type="text" name="number" value="001" readonly="readonly"/></td>
                    <td height="20" bgcolor="#FFFFFF"><input class="table_EmployeeName" type="text" name="employeeName" value="GeTieJun" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="table_PhoneNum" type="text" name="phoneNum" value="18829345930" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="修改"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancalAppointment" type="button" value="删除"/></td>
                  </tr>
                 <tr>
				    <td bgcolor="#FFFFFF"><input class="table_Number" type="text" name="number" value="002" readonly="readonly"/></td>
                    <td height="20" bgcolor="#FFFFFF"><input class="table_EmployeeName" type="text" name="employeeName" value="GeTieJun" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="table_PhoneNum" type="text" name="phoneNum" value="18829345930" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="修改"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancalAppointment" type="button" value="删除"/></td>
                  </tr>
                  <tr>
				    <td bgcolor="#FFFFFF"><input class="table_Number" type="text" name="number" value="003" readonly="readonly"/></td>
                    <td height="20" bgcolor="#FFFFFF"><input class="table_EmployeeName" type="text" name="employeeName" value="GeTieJun" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="table_PhoneNum" type="text" name="phoneNum" value="18829345930" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="修改"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancalAppointment" type="button" value="删除"/></td>
                  </tr>
                  <tr>
				    <td bgcolor="#FFFFFF"><input class="table_Number" type="text" name="number" value="004" readonly="readonly"/></td>
                    <td height="20" bgcolor="#FFFFFF"><input class="table_EmployeeName" type="text" name="employeeName" value="GeTieJun" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="table_PhoneNum" type="text" name="phoneNum" value="18829345930" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="修改"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancalAppointment" type="button" value="删除"/></td>
                  </tr>
                  <tr>
				    <td bgcolor="#FFFFFF"><input class="table_Number" type="text" name="number" value="005" readonly="readonly"/></td>
                    <td height="20" bgcolor="#FFFFFF"><input class="table_EmployeeName" type="text" name="employeeName" value="GeTieJun" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="table_PhoneNum" type="text" name="phoneNum" value="18829345930" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="修改"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancalAppointment" type="button" value="删除"/></td>
                  </tr>
				  <tr>
				    <td bgcolor="#FFFFFF"><input class="table_Number" type="text" name="number" value="006" readonly="readonly"/></td>
                    <td height="20" bgcolor="#FFFFFF"><input class="table_EmployeeName" type="text" name="employeeName" value="GeTieJun" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="table_PhoneNum" type="text" name="phoneNum" value="18829345930" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="修改"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancalAppointment" type="button" value="删除"/></td>
                  </tr>
				  <tr>
				    <td bgcolor="#FFFFFF"><input class="table_Number" type="text" name="number" value="007" readonly="readonly"/></td>
                    <td height="20" bgcolor="#FFFFFF"><input class="table_EmployeeName" type="text" name="employeeName" value="GeTieJun" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="table_PhoneNum" type="text" name="phoneNum" value="18829345930" readonly="readonly"/></td>
                    <td bgcolor="#FFFFFF"><input class="changeButton" type="button" value="修改"/></td>
                    <td bgcolor="#FFFFFF"><input class="cancalAppointment" type="button" value="删除"/></td>
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
                <td width="50%">共 <span class="right-text09">1</span>页 | 第 <span class="right-text09">1</span> 页</td>
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