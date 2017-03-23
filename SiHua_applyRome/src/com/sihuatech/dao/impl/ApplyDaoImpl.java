package com.sihuatech.dao.impl;

import java.util.List;

import org.hibernate.criterion.Example;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.sihuatech.daos.ApplyDao;
import com.sihuatech.daos.BaseDaoImpl;
import com.sihuatech.entities.Apply;
import com.sihuatech.entities.Employee;
import com.sihuatech.entities.Relation;
import com.sihuatech.entities.Room;

@Repository(value="applyDaoImpl")
public class ApplyDaoImpl extends BaseDaoImpl<Apply> implements ApplyDao{

	/*
	//会议室保存操作
	@Override
	public boolean saveRoom(Employee employee, Room room, Apply apply) {
		//1.使用用户名查出该Employee对象.
		//2.使用会议室number查出Room对象.
		//3.使用e_id,和r_id执行save()relation操作.
		//4.使用startTime以及endTime和re_id执行save()操作.
		Employee newEmployee = (Employee) getSession().createCriteria(employee.getClass()).add(Example.create(employee)).uniqueResult();
		
		Room newRoom = (Room) getSession().createCriteria(room.getClass()).add(Example.create(room)).uniqueResult();
		
		Relation relation = new Relation();
		relation.setEmployee(newEmployee);
		relation.setRoom(newRoom);
		getSession().save(relation);
		
		apply.setRelation(relation);
		
		System.out.println(apply.toString());
		boolean flag = insertEntity(apply);
		return flag;
	}
	*/
	//根据Emloyee查询Employee对象
	public Employee findByEmployee(Employee employee){
		return (Employee) getSession().createCriteria(employee.getClass()).add(Example.create(employee)).uniqueResult();
	}
	
	//根据Room查询Room对象
	public Room findByRoom(Room room){
		return (Room) getSession().createCriteria(room.getClass()).add(Example.create(room)).uniqueResult();
	}
	
	//根据relation查找Relation对象的List集合。
	@SuppressWarnings("unchecked")
	public List<Relation> findByRelation(Relation relation){
		return getSession().createCriteria(relation.getClass()).add(Example.create(relation)).list();
	}
	
	//根据room的id查找Relation对象的集合。
	@SuppressWarnings("unchecked")
	public List<Relation> findRelationByRoom(Relation relation){
		return getSession().createCriteria(relation.getClass()).add(Restrictions.eq("room", relation.getRoom())).list();
	}
	
	//根据relation的id查询Apply对象
	public Apply findApplyByRelation(Apply apply){
		return (Apply) getSession().createCriteria(apply.getClass()).add(Restrictions.eq("relation", apply.getRelation())).uniqueResult();
	}
	
	
	//关系映射保存
	public Relation saveRelation(Employee employee, Room room){
		Relation relation = new Relation();
		relation.setEmployee(employee);
		relation.setRoom(room);
		getSession().save(relation);
		return relation;
	}

}
