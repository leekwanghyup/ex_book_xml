package me.light.service;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class BoardControllerTest {
	
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc; 
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build(); 
	}
	
	
	@Test
	@Ignore
	public void testList() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
		.andReturn().getModelAndView().getModelMap(); 
	}
	
	@Test
	@Ignore
	public void testRegister() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
				.param("title", "제목 : 목 테스트")
				.param("content", "내용 : 목 테스트 ")
				.param("writer", "목테스터")
		).andReturn().getModelAndView().getView(); 
	}
	
	
	@Test
	@Ignore
	public void testGet() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/board/get")
				.param("bno", "21")
		)
		.andReturn().getModelAndView().getModelMap(); 
	}
	
	@Test
	@Ignore
	public void testModify() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
				.param("bno", "21")
				.param("title", "제목 : 목 테스트 수정")
				.param("content", "내용 : 목 테스트 수정")
				.param("writer", "목테스터")
		).andReturn().getModelAndView().getView(); 
	}
	
	@Test
	@Ignore
	public void testDelete() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "21")
		).andReturn().getModelAndView(); 
	}
	
}
