package me.light.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import me.light.domain.BoardVO;
import me.light.mapper.MainMapper;

@Service
public class MainServiceImpl implements MainService{

	@Autowired
	private MainMapper mapper;
	
	@Override
	public List<BoardVO> getListWith(String category) {
		return mapper.getListWithMain(category);
	}

}
