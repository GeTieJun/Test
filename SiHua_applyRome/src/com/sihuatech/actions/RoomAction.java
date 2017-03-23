package com.sihuatech.actions;

import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.sihuatech.entities.Room;
import com.sihuatech.services.RoomService;


@Controller
@ParentPackage(value="struts-commom")
@Scope(value="prototype")
public class RoomAction extends ActionSupport{

	private static final long serialVersionUID = 1L;
	@Resource(name="roomService")
	private RoomService roomService;
	private Room room;
	private	String message;
	private List<Room> roomList;
	private List<Object> objs;
	
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public List<Object> getObjs() {
		return objs;
	}
	public void setObjs(List<Object> objs) {
		this.objs = objs;
	}
	public List<Room> getRoomList() {
		return roomList;
	}
	public void setRoomList(List<Room> roomList) {
		this.roomList = roomList;
	}
	public Room getRoom() {
		return room;
	}
	public void setRoom(Room room) {
		this.room = room;
	}
	
	//显示所有房间信息
	@Action(value="allRoomInfoAction", results={
			@Result(name="success", type="json"),
			@Result(name="failure", type="json")
	})
	
	public String allRoomInfoAction(){
		roomList = roomService.findAllRoomInfo();
		if(0 != roomList.size())
			return "success";
		return "failure";
	}
	
	//点击申请按钮触发事件
	@Action(value="clickApplyButtonAction", results={
			@Result(name="success", location="/apply.jsp"),
	})
	
	public String clickApplyButtonAction(){
		String roomNum = ServletActionContext.getRequest().getParameter("roomNum");
		ActionContext.getContext().getSession().remove(roomNum);
		ActionContext.getContext().getSession().put("roomNum", roomNum);
		return "success";
	}
	
	//根据指定条件查询对应的会议室信息
	@Action(value="findByRoomAction", results={
			@Result(name="success", type="json"),
			@Result(name="failure", location="/queryByOther.jsp")
	})
	
	public String findByRoomAction(){
		String number = ServletActionContext.getRequest().getParameter("number");
		String strCapacity = ServletActionContext.getRequest().getParameter("capacity");
		String projector = ServletActionContext.getRequest().getParameter("projector");
		Room room = roomService.roomObject(number, strCapacity, projector);
		roomList = roomService.findByRoom(room);
		if(0 == roomList.size())
			return "failure";
		return "success";
	}
	
	//根据room(会议室编号)查找出其对应的申请人，联系方式以及申请时间
	@Action(value="findRoomAppointInfoAction", results={
			@Result(name="success", type="json"),
			@Result(name="failure", location="/queryByOther.jsp")
	})
	
	public String findRoomAppointInfoAction(){
		String number = ServletActionContext.getRequest().getParameter("roomNum");
		Room room = new Room();
		room.setNumber(number);
		objs = roomService.findRoomNumInfo(room);
		if(0 == objs.size())
			return "failure";
		return "success";
	}
	
	//查找所有的会议室
	@Action(value="findAllRoomAction", results={
			@Result(name="success", type="json")
	})
	public String findAllRoomAction(){
		Room room = new Room();
		roomList = roomService.findAllRoom(room);
		return "success";
	}
	
	//根据会议室编号更新会议室
	@Action(value="changeRoomByNumAction", results={
			@Result(name="success", type="json"),
			@Result(name="failure", type="json")
	})
	public String changeRoomByNumAction(){
		message = "会议室信息更新成功!";
		String number = ServletActionContext.getRequest().getParameter("number");
		String capacity = ServletActionContext.getRequest().getParameter("capacity");
		String projector = ServletActionContext.getRequest().getParameter("projector");
		if(roomService.updateRoomInfoByNum(number, capacity, projector))
			return "success";
		message = "会议室信息更新失败!";
		return "failure";
	}
	
	//根据会议室编号删除会议室
	@Action(value="deleteRoomByNumAction", results={
			@Result(name="success", type="json"),
			@Result(name="failure", type="json")
	})
	public String deleteRoomByNumAction(){
		message = "会议室信息删除成功!";
		String number = ServletActionContext.getRequest().getParameter("number");
		if(roomService.deleteRoomInfo(number))
			return "success";
		message = "会议室信息删除失败!";
		return "failure";
	}
	
	//添加会议室
	@Action(value="addRoomAction", results={
			@Result(name="success", type="json"),
			@Result(name="failure", type="json")
	})
	public String addRoomAction(){
		message = "添加会议室成功!";
		String number = ServletActionContext.getRequest().getParameter("number");
		String capacity = ServletActionContext.getRequest().getParameter("capacity");
		String projector = ServletActionContext.getRequest().getParameter("projector");
		if(roomService.addRoomInfo(number, capacity, projector))
			return "success";
		message = "添加会议室失败!";
		return "failure";
		
	}
}
