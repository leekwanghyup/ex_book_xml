package me.light.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import me.light.domain.BoardVO;

public interface MainMapper {
	
	List<BoardVO> getListWithMain(@Param("category") String category);
}
