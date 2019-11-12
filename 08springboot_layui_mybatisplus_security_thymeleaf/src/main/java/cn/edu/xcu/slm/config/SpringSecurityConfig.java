package cn.edu.xcu.slm.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import cn.edu.xcu.slm.service.IUserService;

@Configuration
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {
	@Autowired
	private IUserService iUserService;

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable().authorizeRequests().antMatchers("/user/tologin","/**/*.js","/**/*.css","/**/*.css.map").permitAll().antMatchers("/**").access("hasRole('ROLE_USER')").and().formLogin().loginPage("/user/tologin")
				.defaultSuccessUrl("/main").usernameParameter("name").passwordParameter("pwd").loginProcessingUrl("/login").and().logout().and();
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(iUserService);
		
	}
	@Bean
	public PasswordEncoder  createPasswordEncode() {
		return new BCryptPasswordEncoder();
	}
}
