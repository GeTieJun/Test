package com.sihuatech.daos;

import java.util.List;

import com.sihuatech.entities.Employee;

public interface EmployeeDao {

	//使用职位查询所有相同职位的员工
	List<Employee> findAllEmployeeByPosition(Employee employee);
	
	//添加员工
	boolean addEmployee(Employee employee);
}
