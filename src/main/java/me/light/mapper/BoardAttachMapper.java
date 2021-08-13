package me.light.mapper;

import java.util.List;

import me.light.domain.BoardAttachVO;

public interface BoardAttachMapper {
	public void insert(BoardAttachVO vo);
	public void delete(String uuid); 
	public List<BoardAttachVO> findByBno(Long bno); 
}
