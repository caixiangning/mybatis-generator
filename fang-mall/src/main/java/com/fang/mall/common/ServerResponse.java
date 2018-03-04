package com.fang.mall.common;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.type.WritableTypeId;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.sun.security.ntlm.Server;

import java.io.Serializable;

/**
 * Description：服务器接口响应类
 * Author: caixiangning
 * Date: Created in 3/4/18 22:32
 * Email: 375577020@qq.com
 */
// https://www.cnblogs.com/jian-xiao/p/6009435.html?utm_source=itdadao&utm_medium=referral
@JsonInclude(JsonInclude.Include.NON_NULL) // 序列化时忽略值为null的属性
//@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
public class ServerResponse<T> implements Serializable {

    // 响应状态码
    private int status;

    // 响应信息
    private String msg;

    // 响应数据
    private T data;

    private ServerResponse(int status) {
        this.status = status;
    }

    private ServerResponse(int status, T data) {
        this.status = status;
        this.data = data;
    }

    private ServerResponse(int status, String msg, T data) {
        this.status = status;
        this.msg = msg;
        this.data = data;
    }

    private ServerResponse(int status, String msg) {
        this.status = status;
        this.msg = msg;
    }


    public int getStatus() {
        return status;
    }

    public String getMsg() {
        return msg;
    }

    public T getData() {
        return data;
    }

    /**
     * 响应是否成功：status=0
     *（Jackson自动检测机制：所有被public修饰的字段->所有被public修饰的getter->所有被public修饰的setter）
     * @return
     */
    @JsonIgnore // 忽略public声明的getter和setter，这里是忽略isXXX这个getter
    public boolean isSuccess() {
        return this.status == ResponseCode.SUCCESS.getCode();
    }


    /**
     * 使用响应成功状态码(status=0)构建响应对象
     *
     * @param <T>
     * @return
     */
    public static <T> ServerResponse<T> createBySuccess() {
        return new ServerResponse<T>(ResponseCode.SUCCESS.getCode());
    }

    /**
     * 使用响应成功状态码(status=0)以及响应信息构建响应对象
     * (使用不同的方法名称来规避如果data也是String类型时传入参数会赋值给msg)
     *
     * @param successMsg
     * @param <T>
     * @return
     */
    public static <T> ServerResponse<T> createBySuccessMsg(String successMsg) {
        return new ServerResponse<T>(ResponseCode.SUCCESS.getCode(), successMsg);
    }

    /**
     * 使用响应成功状态码(status=0)以及响应数据构建响应对象
     *
     * @param data
     * @param <T>
     * @return
     */
    public static <T> ServerResponse<T> createBySuccess(T data) {
        return new ServerResponse<T>(ResponseCode.SUCCESS.getCode(), data);
    }

    /**
     * 使用响应成功状态码(status=0)以及响应信息、响应数据构建响应对象
     *
     * @param msg
     * @param data
     * @param <T>
     * @return
     */
    public static <T> ServerResponse<T> createBySuccess(String msg, T data) {
        return new ServerResponse<T>(ResponseCode.SUCCESS.getCode(), msg, data);
    }


    /**
     * 使用响应失败状态码(status=1)构建响应对象
     *
     * @param <T>
     * @return
     */
    public static <T> ServerResponse<T> createByError() {
        return new ServerResponse<T>(ResponseCode.ERROR.getCode());
    }

    /**
     * 使用响应失败状态码(status=1)和响应失败信息构建响应对象
     *
     * @param errorMsg
     * @param <T>
     * @return
     */
    public static <T> ServerResponse<T> createByErrorMsg(String errorMsg) {
        return new ServerResponse<T>(ResponseCode.ERROR.getCode(), errorMsg);
    }

    /**
     * 使用任意非成功响应状态码(status!=0)和响应信息构建响应对象
     *
     * @param errorCode
     * @param errorMsg
     * @param <T>
     * @return
     */
    public static <T> ServerResponse<T> createByErrorCodeMsg(int errorCode, String errorMsg) {
        return new ServerResponse<T>(errorCode, errorMsg);
    }

}
