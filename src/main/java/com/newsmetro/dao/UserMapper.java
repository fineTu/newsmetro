package com.newsmetro.dao;

import com.newsmetro.enumeration.UserStatus;
import com.newsmetro.po.User;
import com.newsmetro.pojo.UserForm;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * Created by lifeng.gao on 2014/10/8.
 */


public interface UserMapper {
    List<User> findUser(UserForm userForm);

    Long getUserCountByEmail(@Param("email") String email);

//    User getUserByEmail(@Param("email") String email);

//    List<User> getUserByEmailAndCode(@Param("email") String email,@Param("code") String code);
//
//    List<User> getUserByEmailAndStatus(@Param("email") String email,@Param("status") Integer status);
//
//    List<Long> getUserByStatusAndCreateTime(
//            @Param("status") Integer status,@Param("startTime") Long createTime,@Param("endTime") Long endTime);
//
//    User getUserByEmailAndPassword(@Param("email") String email,@Param("password") String password);

    void deleteByIdList(@Param("idList") List<Long> idList);

    void deleteById(@Param("id") Long id);

    Long saveUser(@Param("user") User user);

    Long saveInfo(@Param("user") User user);

    void updateUser(@Param("user") User user);

    void updateInfo(@Param("user") User user);

    User findById(Long id);
}
