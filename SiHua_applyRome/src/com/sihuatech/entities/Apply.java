package com.sihuatech.entities;


public class Apply {

	private Integer id;
	private String startTime;
	private String endTime;
	private Relation relation;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public Relation getRelation() {
		return relation;
	}
	public void setRelation(Relation relation) {
		this.relation = relation;
	}
	@Override
	public String toString() {
		return "Apply [id=" + id + ", startTime=" + startTime + ", endTime="
				+ endTime + ", relation=" + relation + "]";
	}
	
}
