## 의존라이브러리
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

## 댓글 처리를 위한 영속 영역 

```sql
drop table tbl_reply;
create table tbl_reply(
    rno number(10,0), 
    bno number(10,0) not null, 
    reply varchar2(1000) not null, 
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
);

create sequence seq_reply; 
alter table tbl_reply add constraint pk_reply primary key(rno);

alter table tbl_reply add constraint fk_reply_board 
foreign key (bno) references tbl_board(bno);

```

## ReplyVO
```java
@Data
public class ReplyVO {
	private Long rno; 
	private Long bno; 
	
	private String reply; 
	private String replyer; 
	private Date replyDate;
	private Date updateDate; 
}
```


## 등록 

ReplyMapper 인터페이스 
```java
public interface ReplyMapper {
	int insert(ReplyVO vo); 
}
```

ReplyMapper.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="org.zerock.mapper.ReplyMapper">

	<insert id="insert">
		insert into tbl_reply(rno, bno, reply, replyer)
		values (seq_reply.nextval, #{bno},#{reply},#{replyer})
	</insert>
	
</mapper>
```

테스트 코드 
```java
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class ReplyMapperTests {
	
	@Autowired
	private ReplyMapper mapper; 
	
	@Test
	public void testcreate() {
		ReplyVO vo  = new ReplyVO(); 
		vo.setBno(4097L);
		vo.setReply("reply test");
		vo.setReplyer("user00");
		
		mapper.insert(vo);
	}
}
```

## 조회 
ReplyMapper 인터페이스 
```java
ReplyVO read(Long rno);
```

```xml
<select id="read" resultType="org.zerock.domain.ReplyVO">
    select * from tbl_reply where rno = #{rno}
</select>
```

테스트 코드 
```java
@Test
public void testRead() {
    ReplyVO vo = mapper.read(1L);
    log.info(vo.getReply());
}
```

## 삭제 
```java
int delete(Long rno);
```

```xml
<delete id="delete">
    delete from tbl_reply where rno = #{rno}
</delete>

```

테스트 코드 
```java
@Test
	@Ignore
	public void testDelete() {
		int count = mapper.delete(1L);
		log.info(count);
	}
```

## 수정
```java
int update(ReplyVO reply);
```

```xml
<update id="update">
    update 
        tbl_reply 
    set
        reply = #{reply},
        updateDate = sysdate
    where
        rno = #{rno}
</update>
```

테스트 코드 
```java
@Test
public void testUpdate() {
    ReplyVO vo = mapper.read(2L);
    vo.setReply("Update Reply");
    int count = mapper.update(vo);
    log.info(count);
}
```

## @Param 어노테이션과 댓글목록 

ReplyMapper 인터페이스
```java
List<ReplyVO> getListWithPaging(
				@Param("cri") Criteria cri, @Param("bno") Long bno );
```

```xml
<select id="getListWithPaging" resultType="org.zerock.domain.ReplyVO">
    select 
        rno, bno, reply, replyer, replyDate, updateDate
    from 
        tbl_reply
    where 
        bno = #{bno}
    order by rno asc
</select>
```

테스트 코드 
```java
@Test
public void testList() {
    Criteria cri = new Criteria();
    List<ReplyVO> replies = mapper.getListWithPaging(4097L, cri);
    replies.forEach(e -> log.info(e.getReply()));
}
```

## 서비스 영역과 컨트롤러 처리 

### ReplyService 인터페이스 
```java
public interface ReplyService {
	
	int regisetr(ReplyVO vo); 
	
	ReplyVO get(Long rno); 
	
	int modify(ReplyVO vo); 
	
	int remove(Long rno); 
	
	List<ReplyVO> getList(Criteria cri, Long bno); 
}
```

### ReplyServiceImpl
```java
@Service
public class ReplyServiceImpl implements ReplyService{

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper; 
	
	@Override
	public int regisetr(ReplyVO vo) {
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		return mapper.getListWithPaging(cri, bno); 
	}
}
```

### ReplyController

```java
@RestController
@RequestMapping("/replies")
public class ReplyController {
    
	@Autowired
	private ReplyService service;

    // 등록 
    @PostMapping(value = "/new", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = { MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
        int insertCount = service.register(vo);
        return insertCount == 1  
                ?  new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); // 500 에러 
    }

    // 목록
    @GetMapping(value = "/pages/{bno}/{page}", 
		produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<ReplyVO>> getList(
			@PathVariable("page") int page,  @PathVariable("bno") Long bno){
		Criteria cri = new Criteria(page, 10); 
		return new ResponseEntity<>(service.getList(cri, bno),HttpStatus.OK);
		// 요청 :  http://localhost:8181/replies/pages/4097/1 
	}

	//조회  
	@GetMapping(value = "/{rno}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		return new ResponseEntity<ReplyVO>(service.get(rno), HttpStatus.OK); 
	}
	
	//삭제 
	@DeleteMapping(value = "/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		if(service.remove(rno) != 1) {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<String>("succes",HttpStatus.OK); 
	}
	
	//수정
	@RequestMapping(value="/{rno}", method = {RequestMethod.PUT, RequestMethod.PATCH}, 
			consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE ) 
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno){
		vo.setRno(rno);
		if(service.modify(vo) != 1) {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR); 
		}
		return new ResponseEntity<String>("success", HttpStatus.OK); 
	}
}

```
## 포스트맨으로 테스트 




