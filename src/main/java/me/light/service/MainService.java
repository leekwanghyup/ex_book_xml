package me.light.service;

import java.util.List;

import me.light.domain.BoardVO;

public interface MainService {
	
	List<BoardVO> getListWith(String category);
}
