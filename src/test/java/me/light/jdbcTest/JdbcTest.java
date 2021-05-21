package me.light.jdbcTest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Assert;
import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JdbcTest {
	
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String username = "exe_board";
		String password= "exe_board";
		try(Connection con = DriverManager.getConnection(url,username,password)){
			log.info(con);
		} catch (SQLException e) {
			Assert.fail(e.getMessage());
		}
	}
}
