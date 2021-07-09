Chpater 16 Rest 방식으로 전환 

- REST : Representational State Transfer

- @RestController : 컨트롤러가 REST 방식을 처리하기 위한 것임을 명시
- @ResponseBody : 일반적인 JSP와 같은 뷰로 전달하는게 아니라 데이터 자체를 전달하기 위한 용도 
- @PathVariable : URL 경로에 있는 값을 파라미터로 추출
- @CrossOrigin : Ajax의 크로스 도메인 문제를 해결
- @RequestBody : JSON 데이터를 우너하는 타이븡로 바인딩 처리 

# @RestController

## 예제프로젝트 준비 
- board_ex00 복사 

- 의존라이브러리 추가 
    - jackson-databind 2.9.6 
    - jackson-dataformat 2.9.6 
    - gson 2.8.2 
        - 자바 인스턴스를 JSON 타입의 문자열로 변환 

```xml
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.9.6</version>
</dependency>
<dependency>
    <groupId>com.fasterxml.jackson.dataformat</groupId>
    <artifactId>jackson-dataformat-xml</artifactId>
    <version>2.9.6</version>
</dependency>
<dependency>
    <groupId>com.google.code.gson</groupId>
    <artifactId>gson</artifactId>
    <version>2.8.2</version>
</dependency>
```

## 단순 문자열 반환 
```java
@RestController
@RequestMapping("/sample")
public class SampleController {
	
	@GetMapping(value = "/getText", produces = "text/plain;charset=UTF-8")
	public String getText() {
		return "안녕하세요";
	}
	// produces : 메서드가 생산하는 MIME Type
}
```

## 객체의 반환
```java
@GetMapping(value = "/getSample", produces = { MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
public SampleVO getSample() {
    return new SampleVO(112, "스타", "로드");
}
// MediaType.APPLICATION_JSON_UTF8_VALUE : 스프링 5.2 부터 Deprecated되었다. 
// MediaType.APPLICATION_JSON_VALUE 사용 
// produces 속성은 생략가능 
```

## 컬렉션 타입의 객체 반환 
```java
@GetMapping("/getList")
public List<SampleVO> getList(){
    return IntStream.range(1, 10).mapToObj(i-> new SampleVO(i,i+"FirstName",i+"LastName"))
            .collect(Collectors.toList());
}
```

```java

```
## ResponseEntity 타입 
- 데이터를 요청한 쪽에서 정상적인 데이터인지 구분할 수 있는 방법을 제공할 수 있다. 
- 데이터와 함께 HTTP 헤더의 상태 메세지를 전달한다. 
```java
@GetMapping(value = "/check" , params = {"height","weight"})
public ResponseEntity<SampleVO> check(Double height, Double weight){
    SampleVO vo = new SampleVO(0, ""+height,""+weight); 
    ResponseEntity<SampleVO> result = null; 
    
    if(height<150) {
        result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
    } else {
        result = ResponseEntity.status(HttpStatus.OK).body(vo);
    }
    return result; 
}
```

# @RestController에서 파라미터 

## @PathVariable
```java
@GetMapping("/product/{cat}/{pid}")
public String[] getPat(@PathVariable String cat, @PathVariable Integer pid) {
    return new String[] {"category: " + cat, "productid : " + pid};
}
```
- 값을 얻을 때에는 int, double과 같은 기본자료형은 사용할 수 없다. 

## @RequestBody
```java
@Data
public class Ticket {
	private int tno; 
	private String owner; 
	private String grade; 
}
```

```java
@PostMapping("/ticket")
public Ticket converter(@RequestBody Ticket ticket) {
    return ticket; 
}
```
- 전달된 요청의 내용을 이용해서 해당 파라미터의 타입으로 변환을 요구한다. 

# REST 방식의 테스트

## Junit 기반 테스트 
테스트 코드 : SampleControllerTests

```java
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = {RootConfig.class, ServletConfig.class})
public class SampleControllerTests {
	
	@Autowired
	WebApplicationContext ctx;
	
	private MockMvc mockMvc; 
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build(); 
	}
	
	@Test
	public void testConverter() throws Exception {
		Ticket ticket = new Ticket(); 
		ticket.setTno(123);
		ticket.setOwner("Admin");
		ticket.setGrade("AAA");
		
		// java 객체를 josn 문자열로 변환 
		String jsonString = new Gson().toJson(ticket);
		
		mockMvc.perform(MockMvcRequestBuilders.post("/sample/ticket")
				.contentType(MediaType.APPLICATION_JSON)
				.content(jsonString)
				).andExpect(status().is(200));
	}
}

```

## 기타도구

# 다양한 전송방식 



