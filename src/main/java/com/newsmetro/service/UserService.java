package com.newsmetro.service;

import com.newsmetro.dao.UserMapper;
import com.newsmetro.enumeration.UserStatus;
import com.newsmetro.po.User;
import com.newsmetro.pojo.UserForm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class UserService {
	static Logger logger = LoggerFactory.getLogger(UserService.class.getName());

    @Autowired
	private UserMapper userMapper;

	public User signIn(String email,String password){
		UserForm userForm = new UserForm();
		userForm.setEmail(email);
		userForm.setPassword(password);

		List<User> userList = userMapper.findUser(userForm);
		if(userList==null||userList.size()==0){
			return null;
		}
		return userList.get(0);
	}
	
	public User signUp(User user){
		Long count = userMapper.getUserCountByEmail(user.getEmail());
		if(!count.equals(0l)){
			return null;
		}
		userMapper.saveUser(user);
		user.setUserId(user.getId());
		userMapper.saveInfo(user);
		return user;
	}

	public User findUserByEmail(String email){
		UserForm userForm = new UserForm();
		userForm.setEmail(email);
		List<User> userList = userMapper.findUser(userForm);
		if(userList==null||userList.size()==0){
			return null;
		}
		return userList.get(0);
	}
	
	public boolean activeUser(String email,String code){
		UserForm userForm = new UserForm();
		userForm.setEmail(email);
		userForm.setCode(code);
        List<User> userList = userMapper.findUser(userForm);
        if(userList.size()!=0){
			User updateUser = new User();
			updateUser.setId(userList.get(0).getId());
			updateUser.setStatus(User.STATUS_REGULAR);
			userMapper.updateUser(updateUser);
			return true;
		}else{
			if(email!=null&&!email.equals("")){
				UserForm userForm1 = new UserForm();
				userForm1.setEmail(email);
				userForm1.setStatus(User.STATUS_NEW);
                List<User> newUserList = userMapper.findUser(userForm1);
                if(newUserList.size()!=0){
					User newUser = userList.get(0);
					userMapper.deleteById(newUser.getId());
				}
			}
			return false;
		}
	}
	
	public void clearNewUser(){
		long msPerDay = 1000*24*60*60;//一天的毫秒数   
		UserForm userForm = new UserForm();
		userForm.setStatus(User.STATUS_NEW);
		userForm.setEndTime(System.currentTimeMillis()-msPerDay);
        List<User> list = userMapper.findUser(userForm);
		List<Long> idList = new ArrayList<Long>();
		for(User u:list) {
			idList.add(u.getId());
		}
		if(list!=null&&list.size()>0){
            userMapper.deleteByIdList(idList);
		}
	}

	public void updateUser(User user){
		userMapper.updateUser(user);
	}

	public void updateInfo(User user){
		userMapper.updateInfo(user);
	}

	public User findById(Long id){
		return userMapper.findById(id);
	}
}
