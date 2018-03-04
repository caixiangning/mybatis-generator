package com.fang.mall.controller;

import com.fang.mall.common.ServerResponse;
import com.fang.mall.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * Description：用户相关控制器
 * Author: caixiangning
 * Date: Created in 3/4/18 22:13
 * Email: 375577020@qq.com
 */
@Controller
@RequestMapping("/user/")
public class UserController {

    @Autowired
    private IUserService userService;

    @RequestMapping(value="login", method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public ServerResponse login(String username, String password, HttpSession session){
        return userService.login(username,password);
    }

}
