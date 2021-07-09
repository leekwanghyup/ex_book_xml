

## Mybatis 라이브러리 추가 
- mybatis 3.4.6
- mybatis-spring 1.3.2
- spring-jdbc
- spring-tx
``` xml
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.4.6</version>
</dependency>
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis-spring</artifactId>
    <version>1.3.2</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-jdbc</artifactId>
    <version>${org.springframework-version}</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-tx</artifactId>
    <version>${org.springframework-version}</version>
</dependency>
```

## SQLSessionFactory

- RootConfig 설정
```java
@Bean
public SqlSessionFactory sessionFactory() throws Exception{
    SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean(); 
    sqlSessionFactory.setDataSource(dataSource());
    return (SqlSessionFactory)sqlSessionFactory.getObject(); 
}
```
- root-context.xml
```xml
<beans 
xmlns:mybatis="http://mybatis.org/schema/mybatis-spring"
xsi:schemaLocation= "http://mybatis.org/schema/mybatis-spring http://mybatis.org/schema/mybatis-spring.xsd">

<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
    <property name="dataSource" ref="dataSource"/>
</bean>

<mybatis:scan base-package="me.light.mapper"/> <!--MapperScan-->
```

- 테스트 코드 : org.zerock.persistence
    - sqlSessionFactory, dataSource 주입받아야 함 
```java
@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
public class DataSourceTests {
	
	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private SqlSessionFactory sqlSessionFactory; 
	
	@Test
	public void dataSourceTest() {
		log.info(dataSource);
	
	}
	
	@Test
	public void sqlSessionFactoryTest() {
		try(SqlSession con = sqlSessionFactory.openSession()){
			log.info(con);
		} catch (Exception e) {
			e.getStackTrace(); 
		}
	}
}
```


## Mapper 인터페이스 

- mapper 생성 : 
```java
package org.zerock.mapper;
import org.apache.ibatis.annotations.Select;    

public interface TimeMapper {
	
	@Select("select sysdate from dual")
	public String getTime();
}
```
- mapper 설정
```java
@Configuration
@ComponentScan(basePackages = {"org.zerock.smaple"})
@MapperScan(basePackages = {"org.zerock.mapper"})
public class RootConfig { //...
}    
```

## Mapper 테스트 
```java
package org.zerock.persistence;

//...

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class TimeMapperTest {
	
	@Setter(onMethod_ = @Autowired )
	private TimeMapper timeMapper;
	
	@Test
	public void testGetTime() {
		log.info(timeMapper.getTime());
	}
}

```

## XML 매퍼와 같이 쓰기 
```java
public interface TimeMapper {
    //...
	public String getTime2(); 
}

```

scr/main/resources/org/zerock/mapper/TimeMapper.xml
- TimeMapper 인터페이스의 패키지와 같은 구조로 폴더를 만든다. 
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="org.zerock.mapper.TimeMapper">
	<select id="getTime2" resultType="string">
		select sysdate from dual
	</select>	
</mapper>
```

## log4jdbc-log4j2 설정 
```xml
<dependency>
    <groupId>org.bgee.log4jdbc-log4j2</groupId>
    <artifactId>log4jdbc-log4j2-jdbc4</artifactId>
    <version>1.16</version>
</dependency>
```

log4jdbc.log4j2.properties    
```
log4jdbc.spylogdelegator.name = net.sf.log4jdbc.log.slf4j.Slf4jSpyLogDelegator
```

```java
@Bean
public DataSource dataSource() {
    HikariConfig hikariConfig = new HikariConfig(); 
//		hikariConfig.setDriverClassName("oracle.jdbc.driver.OracleDriver");
//		hikariConfig.setJdbcUrl("jdbc:oracle:thin:@localhost:1521:xe");
    hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
    hikariConfig.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@localhost:1521:XE");
    hikariConfig.setUsername("book_ex");
    hikariConfig.setPassword("book_ex");
    HikariDataSource hikariDataSource = new HikariDataSource(hikariConfig);
    return hikariDataSource; 
}
```

## 로그 레벨 설정 

log4j.xml
```xml
<logger name="jdbc.audit">
    <level value="warn"/>
</logger>
    <logger name="jdbc.resultset">
    <level value="warn"/>
</logger>
    <logger name="jdbc.connection">
    <level value="warn"/>
</logger>
```


