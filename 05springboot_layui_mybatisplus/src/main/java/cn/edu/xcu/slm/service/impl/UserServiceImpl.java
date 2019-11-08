package cn.edu.xcu.slm.service.impl;

import cn.edu.xcu.slm.entity.User;
import cn.edu.xcu.slm.mapper.UserMapper;
import cn.edu.xcu.slm.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author nydegang
 * @since 2019-11-03
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

}
