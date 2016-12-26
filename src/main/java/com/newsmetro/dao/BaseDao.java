package com.newsmetro.dao;

import java.io.Serializable;
import java.util.List;

public interface BaseDao<T> {
	
	void save(T entity);
	
	void update(Object entity);
	
	void delete(Object entity);
	
	T get(Serializable id);
	
	List<T> loadAll();
	
	List find(String hql);
	
	List find(String hql, Object... params);
	
}
