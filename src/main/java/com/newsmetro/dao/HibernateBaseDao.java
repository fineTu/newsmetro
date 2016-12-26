package com.newsmetro.dao;

import java.io.Serializable;

public interface HibernateBaseDao<T> extends BaseDao{

	void persist(Object object);
	
	T merge(T entity);
	
	void saveOrUpdate(Object entity);
	
	T load(Serializable id);
	
	void refresh(Object entity);
	
	void flush();
}
