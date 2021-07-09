package me.light.maper;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import me.light.domain.Criteria;
import me.light.domain.ReplyVO;
import me.light.mapper.ReplyMapper;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ReplyMapperTest {
	
	@Autowired
	private ReplyMapper mapper; 
	
	@Test
	@Ignore
	public void testInsert() {
		ReplyVO vo = new ReplyVO(); 
		vo.setBno(8184L);
		vo.setReply("두번 째 댓글 테스트 입니다.");
		vo.setReplyer("댓글테스트");
		mapper.insert(vo);
	}
	
	@Test
	@Ignore
	public void testRead() {
		ReplyVO vo = mapper.read(1L);
		log.info(vo);
	}
	
	@Test
	@Ignore
	public void testList() {
		List<ReplyVO> list = mapper.replyList(new Criteria(), 8184L);
		list.forEach(e-> log.info(e));
	}
	
	@Test
	@Ignore
	public void testUpdate() {
		ReplyVO vo = mapper.read(1L);
		vo.setReply("댓글수정테스트입니다.");
		mapper.insert(vo);
	}
	
	@Test
	@Ignore
	public void tsetDelete() {
		int result = mapper.delete(1L);
		log.info(result);
	}
}
