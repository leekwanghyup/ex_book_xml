## @Controller @RequestMapping
```java
package org.zerock.controller;

@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {
	
	@RequestMapping("")
	public void basic() {
		// /WEB-INF/views/sample폴더에 있는 모든 jsp 파일에 매핑된다. 
		log.info("basic...");
	}
}
```

## @ReqeustMapping의 변화 
```java
@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {
	
    @RequestMapping(value = "/basic", method = RequestMethod.GET)
	public void basicGet() {
		log.info("basic...get");
	}
	
	
    @RequestMapping(value = "/basic", method = RequestMethod.POST)
	public void basicPost() {
		log.info("basic...post");
	}
}
```

## Controller 파라미터 수집 
SampleDTO 
```java
package org.zerock.domain;

@Data
public class SampleDTO {
	private String name; 
	private int age; 
}
```

```java
@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {
    @GetMapping("/ex01")
    public String ex01(SampleDTO dto) {
        log.info("" + dto);
        return "ex01"; 
    }
}
```
- http://localhost:8181/sample/ex01?name=lee&age=10 요청


## 파라미터 수집과 변환 

SampleController
```java
@GetMapping("/ex02")
public String ex02(@RequestParam("name") String n, @RequestParam("age") int a) {
    log.info("name : " + n);
    log.info("age : " + a);
    return "ex02"; 
}
```
- @RequestParam을 생략할 수 있다. 
- http://localhost:8181/sample/ex02?name=lee&age=10 요청

## 리스트 배열 처리 
```java
@GetMapping("/ex02List")
public String ex02List(@RequestParam ArrayList<String> ids) {
    log.info("ids : " + ids);
    return "ex02List";
}
```
- http://localhost:8181/sample/ex02List?ids=111&ids=222&ids=333
- @RequestParam을 생략할 수 없다. 


## ModelAndView 
```java
@GetMapping("/modelAndView")
public ModelAndView modelAndView() {
    ModelAndView mav = new ModelAndView(); 
    mav.setViewName("modelAndViwe"); // modelAndView.jsp 
    mav.addObject("name","leekwanghyup"); // request에 담긴다. 
    return mav; 
}
```

## @RequestParam
```java
// 파라미터가 String(객체)인 경우 파라미터를 전달하지 않아도 오류가 나지 않는다. 즉 null 허용 
@GetMapping("/name")
public String getNaem(String name) {
    log.info(name);
    return "name"; 
```

```java
// 파라미터가 int(기본형)인 경우 파라미터를 전달하지 않으면 오류가 난다. null 을 허용하지 않는다. 
@GetMapping("/age")
public String getAge( int age) {
    log.info(age);
    return "name"; 
}

// 이를 방지하기 위해서 다음과 같이 기본값을 세팅하자 


```

## @InitBinder

```java
@Data
public class TodoDTO {
	private String title; 
	private Date dueDate; 
}

```

```java
@GetMapping("/ex03")
public String ex03(TodoDTO todo) {
    log.info("todo : "+ todo);
    return "ex03";
}
```
- 요청 :  http://localhost:8181/sample/ex03?title=myToDo&dueDate=2021-3-12 
- dueDate 변수의 타입이 Date이므로 문제가 발생한다. 

- 다음 처럼 @InitBinder를 지정하면 문제가 해결된다. 
```java
@InitBinder
public void initBinder(WebDataBinder binder) {
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
```

## @DateTimeFormat
- 위에서 @InitBinder로 지정한 메서드를 삭제한다. 
```java
@Data
public class TodoDTO {
	private String title; 
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dueDate; 

}
```

## Model 데이터 전달자 
```java
	@GetMapping("/ex04")
	public String ex04(SampleDTO dto, int page) {
		log.info(dto);
		log.info(page);
		return "/sample/ex04";
	}
```

```jsp
	SampleDTO : ${sampleDTO}<br>
	Page : ${page}<br>
```
- http://localhost:8181/sample/ex04?name=lee&age=22&page=10
- sampleDTO만 전달된다. 
- 파라미터값을 jsp 받으려면 다음처럼 해야한다. ${param.page}

- 다음과 같이  모델객체에 담아서 보낼수 있다. 
```java
@GetMapping("/ex04")
public String ex04(SampleDTO dto, @ModelAttribute("page") int page) {
    log.info(dto);
    log.info(page);
    return "/sample/ex04";
}
```
- 기본 자료형에 @ModelAttribute를 적용할 경우에는 반드시 value속성을 지정해야한다. 
- 파라미터로 전달된 데이터를 다시 화면에서 사용해야 할 경우 유용하다. 

## RedirectAttributes

- 파라미터에로 선언해서 사용한다. 
- addFalshAttribute(이름, 값)메서드를 이용해서 한 번만 사용하고 다음에는 사용되지 않는다. 


# Controller의 리턴타입 
    String : jsp파일의 경로와 파일이름 
    vodi : 호출하는 URL과 동일한 이름의 jsp파일
    DTO : JSON 타입의 데이터 
    ResponseEntity : Http 헤더 정보 
    Model, MdoelAndView : 데이터와 뷰 같이 지어 

## void 타입 
```java
	@GetMapping("/ex05")
	public void ex05() {
		log.info("/ex05....");
	}
```
- /WEB-INF/views/sample/ex05.jsp 파일에 매핑된다. 

## String 타입 
생략 ...


## 객체 타입 

- jackson-databind 2.9.4 라이브러리 추가 
```xml
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.9.4</version>
</dependency>

```

SampleController 
```java
@GetMapping("/ex06")
@ResponseBody
public SampleDTO ex06() {
    log.info("ex06");
    SampleDTO dto = new SampleDTO(); 
    dto.setAge(10);
    dto.setName("홍길동");
    return dto; 
}
```
- 브라우저에 JSON 타입으로 객체를 변환해서 전달한다. 
- MIME 타입 : application/json 
- jackson-databind 라이브러리가 포함되지 않으면 converter를 찾을 수 없다는 에러메세지를 볼 수 있다. (500에러)

## ResponseEntity 타입 
```java
@GetMapping("/ex07")
public ResponseEntity<String> ex07(){
    log.info("ex07 ...");
    String msg = "{\"name\" : \"홍길동\"}";
    HttpHeaders header = new HttpHeaders(); 
    header.add("Content-Type", "application/json;charset=UTF-8");
    return new ResponseEntity<String>(msg,header,HttpStatus.OK);
}
```

## 파일 업로드 처리 
Servelt 2.5 기준 

```xml
<dependency>
    <groupId>commons-fileupload</groupId>
    <artifactId>commons-fileupload</artifactId>
    <version>1.3.3</version>
</dependency>
```

ServletConfig
```java
@Bean(name = "multipartResolver")
public CommonsMultipartResolver getResolver() throws IOException {
    CommonsMultipartResolver resolver = new CommonsMultipartResolver(); 
    resolver.setMaxUploadSize(1024*1024*10); // 10MB 한번의 Reqeust로 전달 될 수 있는 파일의 킥 
    resolver.setMaxUploadSizePerFile(1024*1024*2); // 2MB 파일 하나의 최대 크기 
    resolver.setMaxInMemorySize(1024*1024); //1MB 메모리상에서 유지하는 최대 크기 
    resolver.setUploadTempDir(new FileSystemResource("/Users/ieunji/Temp/upload")); 
    resolver.setDefaultEncoding("UTF-8");
    return resolver; 
}
```
- bean의 id값을 반드시 multipartResolver 지정해야 한다. 

```java
@Log4j
@Controller
@RequestMapping("/sample")
public class FileUploadController {
	
	@GetMapping("/exUpload")
	public String fileUploadEx() {
		log.info("file Upload---");
		return "/sample/exUpload";
	}
		
	@PostMapping("/exUploadPost")
	public void exUploadPost(ArrayList<MultipartFile> files) {
		
		files.forEach(file ->{
			log.info("--------------------------------");
			log.info("name : " + file.getOriginalFilename());
			log.info("size :  " + file.getSize());
		});
	}
}
```

```jsp
<form action="/sample/exUploadPost" method="post" enctype="multipart/form-data">
	<div>
		<input type="file" name="files">
	</div>
	<div>
		<input type="file" name="files">
	</div>
	<div>
		<input type="file" name="files">
	</div>
	<div>
		<input type="file" name="files">
	</div>
	<div>
		<input type="file" name="files">
	</div>

	<div>
		<input type="submit" value="제출">
	</div>	
</form>
	
	
</body>
</html>
```
- 주의 : enctype="multipart/form-data" 

## Controller의 Exception 처리 

- 패키지 생성 : org.zerock.exception
```java
@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	
	@ExceptionHandler(Exception.class)
	public String exception(Exception ex, Model model) {
		log.error("Exception : " + ex.getMessage());
		model.addAttribute("exception", ex);
		log.error(model);
		return "error_page";
	}
}
```

- @ExceptionHandler(Exception.class) 
    - 메서드가 ()안에 들어가는 예외 타입을 처리하도록 한다. 
    - 구체적인 예외를 지정할 수 있다.
    - 예외가 발생하면 리턴값에 해당하는 뷰 페이지로 이동한다. 

- @ControllerAdvice :
    - 해당 객체가 스프링 컨트롤러에서 발생하는 예외를 처리하는 존재임을 명시한다. 


error_page
```jsp
<h4>${exception.getMessage() }</h4>

<ul>
<c:forEach items="${exception.getStackTrace()}" var="stack">
    <li>${stack}</li>
</c:forEach>
    
</ul>
```

## 404 에러페이지 

WebConfig
```java
@Override
protected void customizeRegistration(Dynamic registration) {
    registration.setInitParameter("throwExceptionIfNoHandlerFound", "true");
}
```

CommonExceptionAdvice
```java
@ExceptionHandler(NoHandlerFoundException.class)
@ResponseStatus(HttpStatus.NOT_FOUND)
public String handler404(NoHandlerFoundException ex) {
    return "custom404";
}
```

custom404.jsp
```jsp
예외처리 페이지 
```

## 더미데이터 생성 
```sql
create sequence seq_board; 

create table tbl_board(
	bno number(10,0),
	title varchar2(200) not null,
    content varchar2(2000) not null,
    wirter varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

alter table tbl_board add CONSTRAINT pk_board PRIMARY KEY (bno);

SELECT * FROM tbl_board;

-- 더미데이터 추가 
insert into tbl_board (bno,title,content,writer) 
VALUES (seq_board.nextval, '테스트 제목', '테스트 내용','user00');

-- seq_board.nextval : 정수값을 1부터 자동 생성한다. 

commit;  -- 반드시 수동 처리 해야한다. 
```








