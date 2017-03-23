package com.sihuatech.daos;

import java.util.List;

public interface BaseDao<T> {

	//插入操作
	boolean insertEntity(T t);
	
	//修改操作
	boolean updateEntity(T t);
	
	//删除操作
	boolean deleteEntity(long id);
	
	//查找操作
	List<T> findAll();
	
	//通过id查找
	T findById(Integer id);
	
	//通过对象拿到所有的对象
	List<T> findByObject(T t);
		//通过对象拿到对象
	T findByObject2(T t);
}
