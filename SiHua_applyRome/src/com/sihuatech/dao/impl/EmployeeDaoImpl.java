package com.sihuatech.dao.impl;

import java.util.List;

import org.hibernate.criterion.Example;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.sihuatech.daos.BaseDaoImpl;
import com.sihuatech.daos.EmployeeDao;
import com.sihuatech.entities.Apply;
import com.sihuatech.entities.Employee;
import com.sihuatech.entities.Relation;
import com.sihuatech.entities.Room;
@Repository(value="employeeDaoImpl")
public class EmployeeDaoImpl extends BaseDaoImpl<Employee> implements EmployeeDao{

	//根据employee姓名查出对应的employee对象申请的会议室编号
	public List<Relation> findByEmployee (Employee employee){ 
		Employee employee2 = findByObject2(employee);
		Relation relation = new Relation();
		relation.setEmployee(employee2);
		return findByRelation(relation);
	}
	
	//根据Relation查找出Relation对象list集合(使用idEQ)
	@SuppressWarnings("unchecked")
	public List<Relation> findByRelation(Relation relation){
		return getSession().createCriteria(relation.getClass()).add(Restrictions.eq("employee", relation.getEmployee())).list();
	}

	//根据Apply查找出Apply对象
	public Apply findByApply(Apply apply){
		return (Apply) getSession().createCriteria(apply.getClass()).add(Restrictions.eq("relation", apply.getRelation())).uniqueResult();
	}
	
	//根据Room查找出Room对象
	public Room findByRoom(Room room){
		return (Room) getSession().createCriteria(room.getClass()).add(Example.create(room)).uniqueResult();
	}
	
	//根据Relation查找出Relation对象
	@SuppressWarnings("unchecked")
	public List<Relation> findByRelationNotEQ(Relation relation){
		return getSession().createCriteria(relation.getClass()).add(Example.create(relation)).list();
	}
	
	//根据员工姓名以及会议室编号查出其对应的List<Relation>集合
	public List<Relation> findByNameAndNumber(String name, String number){
		Employee employee = new Employee();
		Room room = new Room();
		employee.setName(name);
		room.setNumber(number);
		Employee employee2 = findByObject2(employee);
		Room room2 = findByRoom(room);
		Relation relation = new Relation();
		relation.setEmployee(employee2);
		relation.setRoom(room2);
		return findByRelationNotEQ(relation);
	}
	
	//更新Apply对象
	public boolean updateApply(Apply apply){
		boolean flag = true;
		try{
			getSession().update(apply);
		}catch (Exception e) {
           flag=false;
		}
		return flag;
	}
	
	//删除Relation对象
	public boolean deleteRelation(Relation relation){
		boolean flag = true;
		try{
			getSession().delete(relation);
			}
		catch (Exception e) {
			flag=false;
		}
		return flag;
	}
	
	//删除Apply对象
	public boolean deleteApply(Apply apply){
		boolean flag = true;
		try{
			getSession().delete(apply);
			}
		catch (Exception e) {
			flag=false;
		}
		return flag;
	}

	//根据员工的职位查询职位相同的员工
	@SuppressWarnings("unchecked")
	@Override
	public List<Employee> findAllEmployeeByPosition(
			Employee employee) {
		return getSession().createCriteria(employee.getClass()).add(Restrictions.eq("position", employee.getPosition())).list();
	}

	//添加员工
	@Override
	public boolean addEmployee(Employee employee) {
		return insertEntity(employee);
	}
	
}
