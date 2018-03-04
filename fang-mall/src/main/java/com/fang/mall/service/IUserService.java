package com.fang.mall.service;

import com.fang.mall.common.ServerResponse;

/**
 * Description：用户服务相关接口
 * Author: caixiangning
 * Date: Created in 3/4/18 22:28
 * Email: 375577020@qq.com
 */
public interface IUserService {
    ServerResponse login(String username, String password);
}
