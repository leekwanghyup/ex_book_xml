package me.light.service;

import java.util.List;

import me.light.domain.BoardVO;
import me.light.domain.Criteria;

public interface BoardService {
	
	void register(BoardVO board); 
	
	BoardVO get(Long bno);
	
	boolean modify(BoardVO board); 
	
	boolean remove(Long bno); 
	
	List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri); 
}
