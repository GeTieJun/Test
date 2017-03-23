package com.sihuatech.services;

import java.util.Date;
import java.util.List;

import com.sihuatech.entities.Apply;
import com.sihuatech.entities.Employee;

public interface EmployeeService {

	//员工登录
	boolean findEmployee(Employee employee);
	
	//修改密码
	boolean updatePassword(Employee employee);
	
	//根据employee查找employee对象
	Employee findByObject2(Employee employee);
	
	//根据员工名称查找出该员工所对应申请的会议室编号以及申请的时间
	List<Object> findEmployeeAllInfo(Employee employee);
	
	//根据List<Relation>集合根据Apply会议室事件查找出对应的Apply
	Apply findByTime(String name, String number, String startTime, String endTime);
	
	//更新Apply时间
	boolean updateApplyTime(String name, String number, String oldStartTime, String oldEndTime, String newStartTime, String newEndTime);
	
	//将String转化为Date型
	Date strChangeDate(String time);
	
	//用户取消申请会议室
	boolean deleteApplyRoom(String name, String number, String oldStartTime, String oldEndTime, String newStartTime, String newEndTime);
	
	//根据员工职位查找出职位相同的员工
	List<Employee> findAllEmployeeByPosition(Employee employee);
	
	//根据employee的number更新employee
	boolean updateEmployeeByNum(String number, String name, String phoneNum);
	
	//根据员工的number删除employee
	boolean deleteEmployeeByNum(String number);
	
	//添加员工
	boolean addEmployee(Employee employee);
}
