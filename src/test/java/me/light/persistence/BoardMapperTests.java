package me.light.persistence;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import me.light.domain.BoardVO;
import me.light.mapper.BoardMapper;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardMapperTests {
	
	@Autowired
	private BoardMapper mapper;
	
	@Test
	@Ignore
	public void testGetList() {
		log.info("게시판목록 테스트 : " + mapper.getList());
	}
	
	@Test
	@Ignore
	public void insertTest() {
		BoardVO board = new BoardVO(); 
		board.setTitle("제목입니다00.");
		board.setContent("내용입니다00.");
		board.setWriter("작성자0");
		mapper.insert(board);
		log.info(mapper.getList());
	}
	
	@Test
	@Ignore
	public void insertBySelectKeyTest() {
		BoardVO board = new BoardVO(); 
		board.setTitle("제목입니다. SelectKey");
		board.setContent("내용입니다. SelectKey");
		board.setWriter("작성자_SelectKey");
		mapper.insert(board);
		log.info(mapper.getList());
	}
	
	@Test
	@Ignore
	public void readTest() {
		log.info(mapper.read(3L));
	}
	
	@Test
	@Ignore
	public void updateTest() {
		BoardVO board = mapper.read(4L);
		board.setTitle("제목 수정 테스트");
		board.setContent("내용수정 테스트");
		int result = mapper.update(board);
		log.info("업데이트 : " + result);
	}
	
	@Test
	public void delete() {
		int result = mapper.delete(4L);
		log.info("삭제 테스트 : " + result);
	}
}
