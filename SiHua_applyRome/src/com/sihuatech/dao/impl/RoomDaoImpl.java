package com.sihuatech.dao.impl;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.sihuatech.daos.BaseDaoImpl;
import com.sihuatech.daos.RoomDao;
import com.sihuatech.entities.Apply;
import com.sihuatech.entities.Relation;
import com.sihuatech.entities.Room;

@Repository(value="roomDaoImpl")
public class RoomDaoImpl extends BaseDaoImpl<Room> implements RoomDao{

	//根据room会议室编号查找出对应的employee对应的用户名
	public List<Relation> findByRoom (Room room){
		Room room2 = findByObject2(room);
		Relation relation = new Relation();
		relation.setRoom(room2);
		return findByRelation(relation);
	}
	
	//根据Relation查找出Relation对象list集合
	@SuppressWarnings("unchecked")
	public List<Relation> findByRelation(Relation relation){
		return getSession().createCriteria(relation.getClass()).add(Restrictions.eq("room", relation.getRoom())).list();
	}
	
	//根据Apply查找出Apply对象
	public Apply findByApply(Apply apply){
		return (Apply) getSession().createCriteria(apply.getClass()).add(Restrictions.eq("relation", apply.getRelation())).uniqueResult();
	}
	
	//查找所有会议室
	public List<Room> findAllRoom(Room room){
		return findByObject(room);
	}
	
	//根据会议室编号查找会议室信息
	public Room findRoomInfoByNum(String number){
		Room room = new Room();
		room.setNumber(number);
		return findByObject2(room);
	}
	
	//根据room更新room对象
	public boolean updateRoomInfoByObj(Room room){
		return updateEntity(room);
	}
}
