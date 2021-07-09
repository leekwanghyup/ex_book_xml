package me.light.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import me.light.domain.Criteria;
import me.light.domain.ReplyVO;

public interface ReplyMapper {
	
	int insert(ReplyVO vo);
	
	ReplyVO read(Long rno);
	
	List<ReplyVO> replyList(@Param("cri") Criteria cri, @Param("bno") Long bno);
	
	int update(ReplyVO reply);
	
	int delete(Long rno);
}
