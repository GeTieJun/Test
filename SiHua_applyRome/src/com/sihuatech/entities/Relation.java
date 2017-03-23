package com.sihuatech.entities;

public class Relation {
	
	private Integer id;
	private Room room;
	private Employee employee;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Room getRoom() {
		return room;
	}
	public void setRoom(Room room) {
		this.room = room;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	@Override
	public String toString() {
		return "Relation [id=" + id + ", room=" + room + ", employee="
				+ employee + "]";
	}
	
	
}
