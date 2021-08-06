package me.light.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class MemberTests {
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private DataSource ds;
	
	@Test
	public void insertTestMember() {
		String sql = "insert into tbl_member(userid, userpw, username) values(?,?,?)";
		Connection con = null; 
		PreparedStatement pstmt = null; 
		
		try {
			con = ds.getConnection(); 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "muller");
			pstmt.setString(2, passwordEncoder.encode("1234"));
			pstmt.setString(3, "뮐러");
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null ) { 
				try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			}
			if(con!=null ) {
				try {con.close();} catch (SQLException e) {e.printStackTrace();}
			}
			
		}
	}
	
	@Test
	@Ignore
	public void testInsertAuth() {
		String sql = "insert into tbl_member_auth(userid, auth) values(?,?)";
		Connection con = null; 
		PreparedStatement pstmt = null; 
		
		try {
			con = ds.getConnection(); 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "muller");
			pstmt.setString(2, "ROLE_USER");
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null ) { 
				try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			}
			if(con!=null ) {
				try {con.close();} catch (SQLException e) {e.printStackTrace();}
			}
		}
		
	}
}
