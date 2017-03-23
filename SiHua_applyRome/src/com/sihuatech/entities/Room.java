package com.sihuatech.entities;

public class Room {
	private Integer id;
	private String number;
	private Integer capacity;
	private String projector;

	public Room(String number, Integer capacity, String projector) {
		super();
		this.number = number;
		this.capacity = capacity;
		this.projector = projector;
	}
	public Room() {
		super();
		// TODO Auto-generated constructor stub
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
	public Integer getCapacity() {
		return capacity;
	}
	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}
	public String getProjector() {
		return projector;
	}
	public void setProjector(String projector) {
		this.projector = projector;
	}
	@Override
	public String toString() {
		return "Room [id=" + id + ", number=" + number + ", capacity="
				+ capacity + ", projector=" + projector + "]";
	}
}
