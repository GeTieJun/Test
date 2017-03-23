package com.sihuatech.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sihuatech.dao.impl.EmployeeDaoImpl;
import com.sihuatech.entities.Apply;
import com.sihuatech.entities.Employee;
import com.sihuatech.entities.Relation;
import com.sihuatech.services.EmployeeService;

@Service(value="employeeService")
@Transactional
public class EmployeeServiceImpl implements EmployeeService{

	@Resource(name="employeeDaoImpl")
	private EmployeeDaoImpl employeeDaoImpl;
	
	//员工登录
	@Override
	public boolean findEmployee(Employee employee) {
		List<Employee> list = employeeDaoImpl.findByObject(employee);
		if(1 != list.size())
			return false;
		return true;
	}

	//修改密码
	@Override
	public boolean updatePassword(Employee employee) {
		return employeeDaoImpl.updateEntity(employee);
	}
	
	//根据对象查找对象
	@Override
	public Employee findByObject2(Employee employee) {
		return employeeDaoImpl.findByObject2(employee);
	}

	//根据员工名称查找出该员工所对应申请的会议室编号以及申请的时间
	@Override
	public List<Object> findEmployeeAllInfo(Employee employee) {
		//1.根据employee的name查找出employee对象
		//2.根据employee对象查找出relation对应的list集合
		List<Relation> relations = employeeDaoImpl.findByEmployee(employee);
		List<Apply> applys = new ArrayList<Apply>();
		List<Object> objs = new ArrayList<Object>();
		for (int i = 0; i < relations.size(); i++) {
			Apply apply = new Apply();
			apply.setRelation(relations.get(i));
			//3.根据relation对象对应的apply查找出其对应的Apply对象
			Apply apply2 = employeeDaoImpl.findByApply(apply);
			//4.将查找出来的apply对象放入list对象中
			applys.add(apply2);
		}
		//5.将查找出来的relation对象集合以及apply对象添加到新的list集合中
		objs.addAll(applys);
		return objs;
	}

	//根据List<Relation>集合根据Apply会议室事件查找出对应的Apply
	@Override
	public Apply findByTime(String name, String number, String oldStartTime, String oldEndTime) {
		List<Relation> relations = employeeDaoImpl.findByNameAndNumber(name, number);
		for (int i = 0; i < relations.size(); i++) {
			Apply apply = new Apply();
			apply.setRelation(relations.get(i));
			Apply apply2 = employeeDaoImpl.findByApply(apply);
			if((apply2.getStartTime().equals(oldStartTime)) 
					&& (apply2.getEndTime().equals(oldEndTime)))
				return apply2;
		}
		return null;
	}
	
	//更新Apply时间
	public boolean updateApplyTime(String name, String number, String oldStartTime, String oldEndTime, String newStartTime, String newEndTime){
		Apply apply = findByTime(name, number, oldStartTime, oldEndTime);
		apply.setStartTime(newStartTime);
		apply.setEndTime(newEndTime);
		return employeeDaoImpl.updateApply(apply);
	}

	//用户取消会议室申请
	@Override
	public boolean deleteApplyRoom(String name, String number,
			String oldStartTime, String oldEndTime, String newStartTime,
			String newEndTime) {
		Apply apply = findByTime(name, number, oldStartTime, oldEndTime);
		Relation relation = apply.getRelation();
		return employeeDaoImpl.deleteApply(apply) && employeeDaoImpl.deleteRelation(relation);
			
	}

	//将String转化为Date型
	public Date strChangeDate(String time){
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.CHINA);
		Date date = null;
		try {
			date = format.parse(time);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return date;
	}
	
	//根据员工职位查找出职位相同的员工
	@Override
	public List<Employee> findAllEmployeeByPosition(Employee employee) {
		return employeeDaoImpl.findAllEmployeeByPosition(employee);
	}

	//根据employee的number更新employee
	@Override
	public boolean updateEmployeeByNum(String number, String name, String phoneNum) {
		Employee employee = new Employee();
		employee.setNumber(number);
		Employee employee2 = employeeDaoImpl.findByObject2(employee);
		employee2.setName(name);
		employee2.setPhoneNum(phoneNum);
		return employeeDaoImpl.updateEntity(employee2);
	}

	//根据员工的number删除employee
	@Override
	public boolean deleteEmployeeByNum(String number) {
		Employee employee = new Employee();
		employee.setNumber(number);
		Employee employee2 = employeeDaoImpl.findByObject2(employee);
		return employeeDaoImpl.deleteObj(employee2);
	}

	//添加员工
	@Override
	public boolean addEmployee(Employee employee) {
		return employeeDaoImpl.addEmployee(employee);
	}

}
