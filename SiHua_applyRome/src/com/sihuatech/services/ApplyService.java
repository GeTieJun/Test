package com.sihuatech.services;

import com.sihuatech.entities.Apply;
import com.sihuatech.entities.Employee;
import com.sihuatech.entities.Room;

public interface ApplyService {

	//会议室保存操作
	boolean saveAppRome(Employee employee, Room room, Apply apply, String startTime, String endTime);
	
	//保存前验证房间时间是否冲突
	boolean rightTime(Room room, String startTime, String endTime);
}
