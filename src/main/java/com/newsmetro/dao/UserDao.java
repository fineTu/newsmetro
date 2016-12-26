package com.newsmetro.dao;


import com.newsmetro.po.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDao{

}
//public class UserDao extends HibernateDaoSupport<User>{
//	public User signIn(String email,String password){
//		List<Object> list = this.find(
//				"from User u where u.email=? and u.password=?",
//				new Object[]{email,password});
//		if(list.size()>0){
//			return (User) list.get(0);
//		}
//		return null;
//	}
//	public int deleteByIdArray(Integer[] idArray){
//		String hql = "delete from User u where u.id in (:idArray)";
//		StringBuffer str = new StringBuffer();
//		for(Integer i:idArray){
//			str.append(i);
//			str.append(",");
//		}
//		if(str.length()>0){
//			str.deleteCharAt(str.lastIndexOf(","));
//		}
//		return getSession().createQuery(hql).setString("idArray", str.toString()).executeUpdate();
//	}
//}
