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
import com.sihuatech.entities.Employee;
import com.sihuatech.services.EmployeeService;

@Controller
@ParentPackage(value = "struts-commom")
@Scope(value = "prototype")
public class EmployeeAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Resource(name = "employeeService")
	private EmployeeService employeeService;
	private Employee employee;
	private String message;
	private List<Object> objs;
	private List<Employee> employees;

	public List<Employee> getEmployees() {
		return employees;
	}

	public void setEmployees(List<Employee> employees) {
		this.employees = employees;
	}

	public List<Object> getObjs() {
		return objs;
	}

	public void setObjs(List<Object> objs) {
		this.objs = objs;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	// 用户登录,员工登录返回employee,管理员登录返回admin,登录失败返回login
	@Action(value = "loginAction", results = {
			@Result(name = "employee", location = "/employeePage.jsp"),
			@Result(name = "admin", location = "/adminPage.jsp"),
			@Result(name = "login", location = "/login.jsp") })
	public String loginAction() {
		boolean flag = employeeService.findEmployee(employee);
		if (flag) {
			ActionContext.getContext().getSession()
					.put("userName", employee.getName());
			ActionContext.getContext().getSession()
					.put("position", employee.getPosition());
			Employee newEmployee = new Employee();
			newEmployee = employeeService.findByObject2(employee);
			ActionContext.getContext().getSession()
					.put("phoneNum", newEmployee.getPhoneNum());
			if ("staff".equals(employee.getPosition()))
				return "employee";
			else
				return "admin";
		}
		return "login";
	}

	// 修改密码,成功返回本页,提示修改成功,不成功还是本页,提示修改失败
	@Action(value = "updatePasswordAction", results = {
			@Result(name = "success", type = "json"),
			@Result(name = "failure", type = "json") })
	public String updatePasswordAction() {
		String newPassword = ServletActionContext.getRequest().getParameter(
				"newPassword");
		Employee employee = new Employee();
		employee.setName((String) ActionContext.getContext().getSession()
				.get("userName"));
		Employee newEmployee = employeeService.findByObject2(employee);
		newEmployee.setPassword(newPassword);
		boolean flag = employeeService.updatePassword(newEmployee);
		if (flag) {
			message = "密码修改成功!";
			return "success";
		}
		message = "密码修改失败!";
		return "failure";
	}

	// 根据员工名称查找出该员工所对应申请的会议室编号以及申请的时间
	@Action(value = "findEmployeeAllInfoAction", results = {
			@Result(name = "success", type = "json"),
			@Result(name = "failure", location = "/appointmentInfo.jsp") })
	public String findEmployeeAllInfoAction() {
		String userName = (String) ActionContext.getContext().getSession()
				.get("userName");
		Employee employee = new Employee();
		employee.setName(userName);
		objs = employeeService.findEmployeeAllInfo(employee);
		if (0 == objs.size())
			return "failure";
		return "success";
	}

	// 员工更新自己的会议室申请时间
	@Action(value = "updateApplyDateAction", results = {
			@Result(name = "success", type = "json"),
			@Result(name = "failure", type = "json") })
	public String updateApplyDateAction() {
		message = "申请时间修改成功!";
		// 通过前台传接收的数据
		String name = (String) ActionContext.getContext().getSession()
				.get("userName");
		String number = ServletActionContext.getRequest()
				.getParameter("number");
		String oldStartTime = ServletActionContext.getRequest()
				.getParameter("oldStartTime");
		String oldEndTime = ServletActionContext.getRequest().getParameter(
				"oldEndTime");
		String newStartTime = ServletActionContext.getRequest()
				.getParameter("newStartTime");
		String newEndTime = ServletActionContext.getRequest().getParameter(
				"newEndTime");
		//用户更新自己申请会议室时间
		if (employeeService.updateApplyTime(name, number, oldStartTime,
				oldEndTime, newStartTime, newEndTime))
			return "success";
		message = "申请时间修改失败";
		return "failure";
	}
	
	//用户取消预约会议室
	@Action(value="deleteApplyRoom", results={
			@Result(name="success", type="json"),
			@Result(name="failure", type="json")
	})
	
	public String deleteApplyRoom(){
		message="预约信息成功取消!";
		// 通过前台传接收的数据
		String name = (String) ActionContext.getContext().getSession()
				.get("userName");
		String number = ServletActionContext.getRequest()
				.getParameter("number");
		String oldStartTime = ServletActionContext.getRequest()
				.getParameter("oldStartTime");
		String oldEndTime = ServletActionContext.getRequest().getParameter(
				"oldEndTime");
		String newStartTime = ServletActionContext.getRequest()
				.getParameter("newStartTime");
		String newEndTime = ServletActionContext.getRequest().getParameter(
				"newEndTime");
		if(employeeService.deleteApplyRoom(name, number, oldStartTime, oldEndTime, newStartTime, newEndTime))
			return "success";
		message="预约信息取消失败!";
		return "failure";
	}
	
	//查找所有的员工信息
	@Action(value="findAllEmployeeAction", results={
			@Result(name="success", type="json"),
			@Result(name="failure", type="json")
	})
	public String findAllEmployeeAction(){
		Employee employee = new Employee();
		employee.setPosition("staff");
		employees = employeeService.findAllEmployeeByPosition(employee);
		if(0 != employees.size())
			return "success";
		return "failure";
	}
	
	//根据employee的number更新其employee对象
	@Action(value="changeEmployeeByNumAction", results={
			@Result(name="success", type="json"),
			@Result(name="failure", type="json")
	})
	public String changeEmployeeByNumAction(){
		message = "员工信息更新成功!";
		String number = ServletActionContext.getRequest().getParameter("number");
		String name = ServletActionContext.getRequest().getParameter("name");
		String phoneNum = ServletActionContext.getRequest().getParameter("phoneNum");
		if(employeeService.updateEmployeeByNum(number, name, phoneNum))
			return "success";
		message = "员工信息修改失败!";
		return "failure";
	}
	
	//根据员工number删除employee
	@Action(value="deleteEmployeeByNumAction", results={
			@Result(name="success", type="json"),
			@Result(name="failure", type="json")
	})
	
	public String deleteEmployeeByNumAction(){
		message = "员工删除成功!";
		String number = ServletActionContext.getRequest().getParameter("number");
		if(employeeService.deleteEmployeeByNum(number))
			return "success";
		message = "用户信息删除失败!";
		return "failure";
	}
	
	@Action(value="addEmployeeAction", results={
			@Result(name="success", type="json"),
			@Result(name="failure", type="json")
	})
	
	public String addEmployeeAction(){
		message = "员工添加成功!";
		String number = ServletActionContext.getRequest().getParameter("number");
		String name = ServletActionContext.getRequest().getParameter("name");
		String password = ServletActionContext.getRequest().getParameter("password");
		String phoneNum = ServletActionContext.getRequest().getParameter("phoneNum");
		Employee employee = new Employee(number, name, password, phoneNum, "staff");
		if(employeeService.addEmployee(employee))
			return "success";
		message = "员工添加失败!";
		return "failure";
	}
}
