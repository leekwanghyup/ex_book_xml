package me.light.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import me.light.domain.BoardVO;
import me.light.domain.Criteria;

public interface BoardMapper {

	List<BoardVO> getList(Criteria cri);
	
	void insert(BoardVO board); 
	
	void insertSelectKey(BoardVO board);
	
	BoardVO read(Long bno); 
	
	int update(BoardVO board);
	
	int delete(Long bno);
	
	int getTotal(Criteria cri); 
	
}
