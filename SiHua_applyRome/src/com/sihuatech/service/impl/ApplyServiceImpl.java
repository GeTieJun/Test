package com.sihuatech.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sihuatech.dao.impl.ApplyDaoImpl;
import com.sihuatech.entities.Apply;
import com.sihuatech.entities.Employee;
import com.sihuatech.entities.Relation;
import com.sihuatech.entities.Room;
import com.sihuatech.services.ApplyService;

@Service(value = "applyService")
@Transactional
public class ApplyServiceImpl implements ApplyService {

	@Resource(name = "applyDaoImpl")
	private ApplyDaoImpl applyDaoImpl;

	// 会议室保存操作
	@Override
	public boolean saveAppRome(Employee employee, Room room, Apply apply,
			String startTime, String endTime) {
		// 根据employee的name查找employee对象
		Employee newEmployee = applyDaoImpl.findByEmployee(employee);
		// 根据room的number查找room对象
		Room newRoom = applyDaoImpl.findByRoom(room);
		// 保存employee与room的关系表(Relation)
		Relation relation = applyDaoImpl.saveRelation(newEmployee, newRoom);
		// 根据Apply属性保存Apply
		apply.setRelation(relation);
		apply.setEndTime(endTime);
		apply.setStartTime(startTime);
		if (applyDaoImpl.insertEntity(apply))
			return true;
		return false;
	}

	// 验证输入的时间是否合理。
	@Override
	public boolean rightTime(Room room, String startTime, String endTime) {
		boolean flag = true;
		// 1.根据room的number找到room对象
		Room newRoom = applyDaoImpl.findByRoom(room);
		// 2.根据room对象查找relation，返回relation集合
		Relation relation = new Relation();
		relation.setRoom(newRoom);
		List<Relation> relations = applyDaoImpl.findRelationByRoom(relation);
		// 3.根据relation集合查找出Apply集合
		for (int i = 0; i < relations.size(); i++) {
			Apply apply = new Apply();
			apply.setRelation(relations.get(i));
			Apply apply2 = applyDaoImpl.findApplyByRelation(apply);
			flag = compareTime(endTime, startTime, apply2.getStartTime(),
					apply2.getEndTime());
			if (flag == false)
				return flag;
		}
		// 4.用输入的StartTime和查找出的Apply集合中时间作比较，
		// 如果StartTime时间点位于查找出的Apply集合中时间中，返回不可预约。
		return flag;
	}

	// 用输入的startTime和Apply对象中的开始时间和结束时间作比较，将String的数据转化为Date型，返回boolean型
	public boolean compareTime(String endTime, String startTime,
			String applyStrTime, String applyEndTime) {
		boolean flag = false;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date startTimeDate = null;
		Date endTimeDate = null;
		Date applyStartTimeDate = null;
		Date applyEndTimeDate = null;
		try {
			startTimeDate = format.parse(startTime);
			endTimeDate = format.parse(endTime);
			applyStartTimeDate = format.parse(applyStrTime);
			applyEndTimeDate = format.parse(applyEndTime);
			// 如果输入的开始时间大于结束时间直接返回false
			if (endTimeDate.getTime() < startTimeDate.getTime())
				return flag;
			// 输入的结束时间小于申请表中开始时间或者输入的开始时间大于申请表中结束的时间
			if (endTimeDate.getTime() < applyStartTimeDate.getTime()
					|| startTimeDate.getTime() > applyEndTimeDate.getTime())
				flag = true;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}

}
