package com.sihuatech.services;

import java.util.List;

import com.sihuatech.entities.Room;

public interface RoomService {

	//显示会议室所有信息
	List<Room> findAllRoomInfo();
	
	//根据会议室条件查询会议室
	List<Room> findByRoom(Room room);
	
	//根据room不同的属性返回其对应的room对象
	Room roomObject(String number, String strCapacity, String projector);
	
	//根据room(会议室编号)查找出对应的申请员工，联系方式，以及申请时间
	List<Object> findRoomNumInfo(Room room);
	
	//查找所有会议室
	List<Room> findAllRoom(Room room);
	
	//更新会议室信息
	boolean updateRoomInfoByNum(String number, String capacity, String projector);
	
	//删除会议室
	boolean deleteRoomInfo(String number);
	
	//添加会议室
	boolean addRoomInfo(String number, String capacity, String projector);
}
