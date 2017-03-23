package com.sihuatech.entities;

public class Employee {

	private Integer id;
	private String number;
	private String name;
	private String password;
	private String phoneNum;
	private String position;
	
	public Employee(String number, String name, String password,
			String phoneNum, String position) {
		super();
		this.number = number;
		this.name = name;
		this.password = password;
		this.phoneNum = phoneNum;
		this.position = position;
	}
	
	
	public Employee() {
		super();
	}


	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	@Override
	public String toString() {
		return "Employee [id=" + id + ", number=" + number + ", name=" + name
				+ ", password=" + password + ", phoneNum=" + phoneNum
				+ ", position=" + position + "]";
	}
}
