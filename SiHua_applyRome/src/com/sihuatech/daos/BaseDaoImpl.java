package com.sihuatech.daos;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Example;

public class BaseDaoImpl<T> implements BaseDao<T>{
	
	private Class<T> clazz;
	
	@SuppressWarnings("unchecked")
	public BaseDaoImpl() {
		//拿到泛型参数,通过泛型进行增删改查的操作
		Type t = this.getClass().getGenericSuperclass();
		if (!(t instanceof ParameterizedType)) {
			clazz = (Class<T>) Object.class;
		}
		ParameterizedType pt = (ParameterizedType) t;
		Type[] type = pt.getActualTypeArguments();
		if (type == null) {
			clazz = (Class<T>) Object.class;
		}
		clazz =  (Class<T>) type[0];
	}
	
	    @Resource(name="sessionFactory")
	    private SessionFactory sessionFactory;
		public Session getSession(){
			return this.sessionFactory.getCurrentSession();
		}

	//插入一个对象
	@Override
	public boolean insertEntity(T t) {
		boolean flag = true;
		try{
			getSession().save(t);
		}catch (Exception e) {
           flag=false;
		}
		return flag;
	}

	//更新一个对象
	@Override
	public boolean updateEntity(T t) {
		boolean flag = true;
		try{
			getSession().update(t);
		}catch (Exception e) {
           flag=false;
		}
		return flag;
	}

	//根据id删除对象
	@SuppressWarnings("unchecked")
	@Override
	public boolean deleteEntity(long id) {
		boolean flag = true;
		try{
		T t = (T) getSession().get(clazz, id);
		getSession().delete(t);
		}catch (Exception e) {
               flag=false;
			}
			return flag;
	}

	//根据对象删除
	public boolean deleteObj(T t){
		boolean flag = true;
		try{
			getSession().delete(t);
		}catch (Exception e) {
               flag=false;
			}
			return flag;
	}
	//拿到所有查询的东西
	@SuppressWarnings("unchecked")
	@Override
	public List<T> findAll() {
		List<T> list = getSession().createQuery("from "+clazz.getSimpleName()).list();
		return list;
	}

	//根据id查找
	@SuppressWarnings("unchecked")
	@Override
	public T findById(Integer id) {
		T t = (T) getSession().get(clazz, id);
		return t;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findByObject(T t) {
		return getSession().createCriteria(t.getClass()).add(Example.create(t)).list();
	}

	//根据对象查找返回对象
	@SuppressWarnings("unchecked")
	@Override
	public T findByObject2(T t) {
		return (T) getSession().createCriteria(t.getClass()).add(Example.create(t)).uniqueResult();
	}
}
