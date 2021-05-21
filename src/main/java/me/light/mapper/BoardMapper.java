package me.light.mapper;

import java.util.List;

import me.light.domain.BoardVO;

public interface BoardMapper {

	List<BoardVO> getList();
	
	void insert(BoardVO board); 
	
	void insertSelectKey(BoardVO board);
	
	BoardVO read(Long bno); 
	
	int update(BoardVO board);
	
	int delete(Long bno); 
}
