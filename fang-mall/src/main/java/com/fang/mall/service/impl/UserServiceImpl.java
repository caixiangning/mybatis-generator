package com.fang.mall.service.impl;

import com.fang.mall.common.ServerResponse;
import com.fang.mall.dao.UserMapper;
import com.fang.mall.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Description：
 * Author: caixiangning
 * Date: Created in 3/4/18 22:30
 * Email: 375577020@qq.com
 */
@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public ServerResponse login(String username, String password) {
        int resultCount = userMapper.checkUserName(username);
        if(resultCount==0){
            return ServerResponse.createByErrorMsg("用户名不存在");
        }
        return null;
    }
}
