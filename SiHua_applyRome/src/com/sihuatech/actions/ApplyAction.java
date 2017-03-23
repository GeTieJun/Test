package com.sihuatech.actions;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.sihuatech.entities.Apply;
import com.sihuatech.entities.Employee;
import com.sihuatech.entities.Room;
import com.sihuatech.services.ApplyService;
@Controller
@ParentPackage(value="struts-commom")
@Scope(value="prototype")
public class ApplyAction extends ActionSupport{

	private static final long serialVersionUID = 1L;
	
	private String message;
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Resource(name="applyService")
	private ApplyService applyService;

	@Action(value="saveRoomAction", results={
		@Result(name="success", type="json"),
		@Result(name="failure", type="json")
	})
	
	public String saveRoomAction(){
		message = "会议室申请成功!";
		//从Session中得到用户名
		String userName = (String) ActionContext.getContext().getSession().get("userName");
		//从Ajax请求中获得roomNum参数
		String roomNum = ServletActionContext.getRequest().getParameter("roomNum");
		
		String startTime = ServletActionContext.getRequest().getParameter("startTime").replaceAll("T", " ");
		String endTime = ServletActionContext.getRequest().getParameter("endTime").replaceAll("T", " ");
		Employee employee = new Employee();
		Room room = new Room();
		Apply apply = new Apply();
		
		employee.setName(userName);
		
		room.setNumber(roomNum);
		
		if(!(applyService.rightTime(room, startTime, endTime))){
			message = "您输入的时间冲突";
			return "failure";
		}
		
		if(applyService.saveAppRome(employee, room, apply, startTime, endTime))
			return "success";
		message = "会议室申请失败!";
		return "failure";
	}

}
