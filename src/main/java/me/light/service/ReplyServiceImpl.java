package me.light.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import me.light.domain.Criteria;
import me.light.domain.ReplyVO;
import me.light.mapper.BoardMapper;
import me.light.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{

	@Setter(onMethod_ = @Autowired )
	private BoardMapper boardMapper; 
	
	@Autowired
	private ReplyMapper mapper;
	
	@Override
	public int regisetr(ReplyVO vo) {
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		return mapper.replyList(cri, bno);
	}
	
}
