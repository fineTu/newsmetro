package com.newsmetro.jobs;

import com.newsmetro.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

public class ClearNewUserJob {
	static Logger logger = LoggerFactory.getLogger(ClearNewUserJob.class.getName());
	@Autowired
	private UserService userService;
	public void execute(){
		userService.clearNewUser();
		logger.info("\n=========清除未激活账号===========");
	}
}
