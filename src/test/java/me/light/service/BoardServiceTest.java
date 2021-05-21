package me.light.service;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import me.light.domain.BoardVO;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardServiceTest {
	
	@Autowired
	private BoardService boardService; 
	
	@Test
	@Ignore
	public void testGetList() {
		List<BoardVO> list =  boardService.getList(); 
		log.info("*********************");
		list.forEach(board ->{
			log.info("getList : " + board);
		});
		log.info("*********************");
	}
	
	@Test
	@Ignore
	public void testGet() {
		BoardVO board = boardService.get(3L);
		log.info("*********************");
		log.info(board);
		log.info("*********************");
	}
	
	@Test
	@Ignore
	public void testRegister() {
		BoardVO board = new BoardVO(); 
		board.setTitle("service test title ");
		board.setContent("service test content");
		board.setWriter("serviceUser");
		boardService.register(board);
	}
	
	@Test
	@Ignore
	public void testmodify() {
		BoardVO board = new BoardVO();
		board.setBno(5L);
		board.setTitle("service update title ");
		board.setContent("service update content");
		board.setWriter("serviceUpdate");
		boolean isUpdated = boardService.modify(board); 
		log.info("isUpdate : " + isUpdated);
	}
	
	@Test
	@Ignore
	public void testDelete() {
		boolean isRemoved = boardService.remove(5L); 
		log.info(isRemoved);
	}
}
