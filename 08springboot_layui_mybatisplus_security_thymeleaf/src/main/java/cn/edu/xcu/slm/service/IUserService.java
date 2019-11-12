package cn.edu.xcu.slm.service;

import cn.edu.xcu.slm.entity.User;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author nydegang
 * @since 2019-11-03
 */
public interface IUserService extends IService<User>,UserDetailsService {

}
