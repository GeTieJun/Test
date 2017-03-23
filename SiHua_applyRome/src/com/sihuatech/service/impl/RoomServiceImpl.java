package com.sihuatech.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sihuatech.dao.impl.RoomDaoImpl;
import com.sihuatech.entities.Apply;
import com.sihuatech.entities.Relation;
import com.sihuatech.entities.Room;
import com.sihuatech.services.RoomService;

@Service(value="roomService")
@Transactional
public class RoomServiceImpl implements RoomService{

	@Resource(name="roomDaoImpl")
	private RoomDaoImpl roomDaoImpl;

	//显示会议室所有信息
	@Override
	public List<Room> findAllRoomInfo() {
		return roomDaoImpl.findAll();
	}

	//根据roon对象查找出符合条件的room
	@Override
	public List<Room> findByRoom(Room room) {
		// TODO Auto-generated method stub
		return roomDaoImpl.findByObject(room);
	}
	
	//根据room不同的属性返回其对应的room对象
	public Room roomObject(String number, String strCapacity, String projector){
		Room room = new Room();
		if(!(number.equals("")))
			room.setNumber(number);
		if(!(strCapacity.equals(""))){
			Integer capacity = Integer.parseInt(strCapacity);
			room.setCapacity(capacity);
		}
		if(!(projector.equals("")))
			room.setProjector(projector);
		return room;
	}

	
	//根据room(会议室编号)查找出对应的申请员工，联系方式，以及申请时间
	@Override
	public List<Object> findRoomNumInfo(Room room) {
		List<Relation> relations = roomDaoImpl.findByRoom(room);
		List<Apply> applys = new ArrayList<Apply>();
		List<Object> objs = new ArrayList<Object>();
		for (int i = 0; i < relations.size(); i++) {
			Apply apply = new Apply();
			apply.setRelation(relations.get(i));
			//3.根据relation对象对应的apply查找出其对应的Apply对象
			Apply apply2 = roomDaoImpl.findByApply(apply);
			//4.将查找出来的apply对象放入list对象中
			applys.add(apply2);
		}
		//5.将查找出来的relation对象集合以及apply对象添加到新的list集合中
		objs.addAll(applys);
		return objs;
	}

	//查找所有的会议室
	@Override
	public List<Room> findAllRoom(Room room) {
		return roomDaoImpl.findAllRoom(room);
	}

	//更新会议室信息
	@Override
	public boolean updateRoomInfoByNum(String number, String capacity, String projector) {
		Room room = roomDaoImpl.findRoomInfoByNum(number);
		room.setCapacity(Integer.parseInt(capacity));
		room.setProjector(projector);
		return roomDaoImpl.updateRoomInfoByObj(room);
	}

	//删除会议室
	@Override
	public boolean deleteRoomInfo(String number) {
		Room room = roomDaoImpl.findRoomInfoByNum(number);
		System.out.println(room.toString());
		return roomDaoImpl.deleteObj(room);
	}

	//添加会议室
	@Override
	public boolean addRoomInfo(String number, String capacity, String projector) {
		return roomDaoImpl.insertEntity(new Room(number, Integer.parseInt(capacity), projector));
	}
	
	
	
}
