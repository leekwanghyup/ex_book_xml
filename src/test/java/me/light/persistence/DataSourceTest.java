package me.light.persistence;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DataSourceTest {
	
	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private SqlSessionFactory sqlSessionFactory; 
	
	@Test
	public void testConnect() {
		try (Connection con = dataSource.getConnection()){
			log.info("커넥션 테스트 : " + con);
		} catch (Exception e) {
			Assert.fail(e.getMessage());
		}
	}
	
	@Test
	public void testMybatis() {
		try (SqlSession session = sqlSessionFactory.openSession(); 
				Connection con = session.getConnection();
			){
			 log.info("마이바티스 테스트 : " + session);
			 log.info(con);
		} catch (Exception e) {
			Assert.fail(e.getMessage());
		}
	}
}
