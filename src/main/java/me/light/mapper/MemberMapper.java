package me.light.mapper;

import me.light.domain.MemberVO;

public interface MemberMapper {
	MemberVO read(String userid);
}
