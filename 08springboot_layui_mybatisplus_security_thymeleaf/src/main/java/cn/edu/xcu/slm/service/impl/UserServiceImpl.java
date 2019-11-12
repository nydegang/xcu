package cn.edu.xcu.slm.service.impl;

import java.util.HashSet;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.edu.xcu.slm.entity.Role;
import cn.edu.xcu.slm.entity.User;
import cn.edu.xcu.slm.mapper.UserMapper;
import cn.edu.xcu.slm.service.IUserService;

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

	@Override
	public UserDetails loadUserByUsername(String name) throws UsernameNotFoundException {
		User user = getBaseMapper().findUserByName(name);
		// 添加角色权限
		Set<GrantedAuthority> authorities = new HashSet<>();
		for (Role role : user.getRoles()) {
			authorities.add(new SimpleGrantedAuthority(role.getName()));
		}
		return new org.springframework.security.core.userdetails.User(name, user.getPwd(), authorities);
	}

}
