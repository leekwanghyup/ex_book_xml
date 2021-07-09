
스프링 프로젝트 생성 : ex01 
패키지 : org.zerock.controller

## pom.xml 수정 

스프링 버전 : 5.0.7
자바 버전 : 1.8 
매이븐 컴파일러 : 3.5.1 
log4j : 1.2.17
    - scope 속성을 삭제한다. 

junit : 4.12

```xml
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>3.1.0</version>
    <scope>provided</scope>
</dependency>

<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-test</artifactId>
    <version>${org.springframework-version}</version>
</dependency>

<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.18</version>
    <scope>provided</scope>
</dependency>

<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-war-plugin</artifactId>
    <version>3.2.0</version>
    <configuration>
        <failOnMissingWebXml>false</failOnMissingWebXml>
    </configuration>
</plugin>

```

## 스프링 설정 파일 
- /WEB-INF/spring 폴더 삭제 
- web.xml 삭제 

패키지 : org.zerock.config

RootConfig : root-context.xml 대체 
```java
@Configuration
public class RootConfig {

}
```

servlet-context.xml


ServletConfig : servlet-context.xml 대체 
```java
@EnableWebMvc
@ComponentScan(basePackages = {"org.zerock"})
public class ServletConfig implements WebMvcConfigurer{
	
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver(); 
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		registry.viewResolver(viewResolver);
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**")
		.addResourceLocations("/resources/");
	}
}
```

WebConfig : web.xml 대체 
```java
public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class<?>[] {RootConfig.class};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class<?>[] {ServletConfig.class};
	}

	@Override
	protected String[] getServletMappings() {
		return new String[]{"/"};
	}
}

```
web.xml
```xml
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
	version="3.1">

	<!-- 생략  -->
</web-app>
```

## 톰캣 Context Path 수정 