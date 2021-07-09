package me.light.service;

import java.util.List;

import me.light.domain.Criteria;
import me.light.domain.ReplyVO;

public interface ReplyService {
	
	int regisetr(ReplyVO vo); 
	
	ReplyVO get(Long rno); 
	
	int modify(ReplyVO vo); 
	
	int remove(Long rno); 
	
	List<ReplyVO> getList(Criteria cri, Long bno); 
}
