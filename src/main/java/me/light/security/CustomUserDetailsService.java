package me.light.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.extern.log4j.Log4j;
import me.light.domain.MemberVO;
import me.light.mapper.MemberMapper;
import me.light.security.domian.CustomUser;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		log.warn("Load User By UserName : " + userName);
		MemberVO vo = memberMapper.read(userName);
		log.warn("quired by Member mapper : " + vo);
		return vo == null ? null : new CustomUser(vo);
	}
}
