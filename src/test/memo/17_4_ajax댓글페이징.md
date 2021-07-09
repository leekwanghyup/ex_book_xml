## 데이터베이스 인덱스 설계 

- 인덱스 생성 
```sql
create index idx_reply on tbl_reply (bno desc, rno desc);
```

## 인덱스를 이용한 페이징 쿼리 
```
insert into tbl_reply(rno, bno, reply, replyer)
    values (seq_reply.nextval, #{bno},#{reply},#{replyer})
```

```sql
insert into tbl_reply (rno, bno, reply, replyer) 
(select seq_reply.nextval, bno, reply, replyer from tbl_reply);


```

- 예제 
```sql
select /*+ INDEX(tbl_reply idx_reply)*/
    rownum rn, bno, rno, reply, replyer, replyDate, updatedate
from 
    tbl_reply
where 
    bno = 4097
and rno > 0 
```

## 테스트 데이터 
get.jsp
```js
$(function(){ // 107개 데이터 삽입 
	var bnoValue = "${board.bno}";
	
	for (var i = 0; i < 107; i++) {
		replyService.add(
			    {
			        bno : bnoValue,
			        reply : "JS TEST Paging" + i,
			        replyer : "tester"+i,
			    },
			    function(result) {
			    }
			);		
	}
	replyService.showList(1); 
	
})
```

## ReplyMapper.xml
```xml
<select id="getListWithPaging" resultType="org.zerock.domain.ReplyVO">
	<![CDATA[
	select 
		rno, bno, reply, replyer, replyDate, updateDate
	from
	(
		select /*+ index(tbl_reply idx_reply ) */
			rownum rn, rno, bno, reply, replyer, replyDate, updateDate
		from 
			tbl_reply
		where 
			bno = #{bno}
		and 
			rno >0 
		and 
			rownum <= #{cri.pageNum} * #{cri.amount}
	) 
	where 
		rn > (#{cri.pageNum} - 1) * #{cri.amount}
	]]>
</select>
```

## ReplyMapperTest
```java
@Test
public void testList2() {
	Criteria cri = new Criteria(2, 10);
	List<ReplyVO> replies = mapper.getListWithPaging(cri, 4101L);
	replies.forEach(s-> log.info(s));
}
```

## 댓글 숫자 파악 

ReplyMapper 인터페이스 
```java
public int getCountByBno(Long bno);
```

ReplyMapper.xml
```xml
<select id="getCountByBno" resultType="int">
	<![CDATA[
		select count(bno) from tbl_reply where bno = #{bno}
	]]>
</select>
```

```java
@Test
public void testGetCountByBno() {
	int replyCount = mapper.getCountByBno(4101L);
	log.info("reply count : " + replyCount);
}
```

## ReplyServiceImpl에서 댓글과 댓글 수 처리 

- ReplyPageDTO
```java
@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {
	private int replyCnt; 
	private List<ReplyVO> list; 
}
```

- ReplyService 인터페이스 
```java
ReplyPageDTO getListPage(Criteria cri, Long bno);
```

- ReplyServiceImpl
```java
@Override
public ReplyPageDTO getListPage(Criteria cri, Long bno) {
	return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
}
```

## ReplyController 수정 

- ReplyController
```java
// select all 
@GetMapping(value = "/pages/{bno}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
public ResponseEntity<ReplyPageDTO> getList(@PathVariable int page, @PathVariable("bno") Long bno){
	Criteria cri = new Criteria(page,10); 
	return new ResponseEntity<ReplyPageDTO>(service.getListPage(cri, bno), HttpStatus.OK); 
}
```



# 댓글 페이지의 화면 처리 

reply.js
```js
var getList = (param, callback, error) =>{
		
	var bno = param.bno;
	var page = param.page || 1; 
	
	$.getJSON("/replies/pages/" + bno + "/" + page, 
		(data) => {
			if(callback) callback(data.replyCnt, data.list); // 수정 : 댓글을 가져오는 부분 
	}).fail((xhr, status, err) => {
		if(error) error(); 
	});
}
```

- 댓글 화면처리 
get.js
```js
function showList(page){
		
	replyService.getList(
		{bno : bnoValue, page : page || 1},
		function(replyCnt, list){ // 수정 
			
			var str = ""; 
			
			if(list == null || list.length == 0 ){
				return; // 수정 
			}
			
			for(var i=0, len = list.length || 0 ; i<len; i++){
				str+=`
				<li class='list-group-item left clearfix'>
					<div>
						<div class='header'><strong class='primary-font'>${list[i].replyer}</strong>
							<a href="#" data-rno=${list[i].rno} style="margin-left: 20px;"> 수정/삭제</a>
							<small class='pull-right text-muted'>${replyService.displayTime(list[i].replyDate)}</small><br>
						</div><br>
						<p>${list[i].reply}</p>
					</div>
				</li>`;
			}
			replyUL.html(str);
	});
}
```

get.jsp
```jsp
<div class="panel-footer"></div>
```

- 페이지이동 버튼 화면 처리 
get.js
```js
var pageNum = 1; 
var replyPageFooter = $(".panel-footer");

function showReplyPage(replyCnt){
	
	var endNum = Math.ceil(pageNum / 10.0) * 10; 
	var startNum = endNum - 9; 
	
	var prev = startNum !=1; 
	var next = false; 
	
	if(endNum * 10 >= replyCnt) {
		endNum = Math.ceil(replyCnt/10.0);
	} else{
		next = true; 
	}
	
	var str = "<ul class='pagination'> ";
	
	if(prev){
		str += `
			<li class="page-item">
				<a href=${(startNum-1)} class="page-link">이전</a>
			</li>`; 
	}
	
	for (var i = startNum; i <= endNum; i++) {
		var active = pageNum == i ? "active":""; 
		str += `
			<li class="page-item ${active}">
				<a href=${i} class="page-link">${i}</a>
			</li>`        
	}
	
	if(next){
		str += `
			<li class="page-item">
				<a href=${(endNum+1)} class="page-link">다음</a>
			</li>`; 
	}
	
	str += `</ul></div>`;
	
	replyPageFooter.html(str);
}
```

- showList()함수의 마지막부분에서 showReplyPage()함수를 호출한다. 
```js
function showList(replyCnt){
	
	replyService.getList(
	// ... 
		replyUL.html(str);
		showReplyPage(replyCnt); 
	}); //
}

```
- 페이지 번호를 클릭했을 때 새로운 목록 가져오기 
```js
// 버튼을 클릭하면 새로운 페이지로 이동 
replyPageFooter.on("click","li a", function(e) {
	e.preventDefault();
	pageNum =  $(this).attr("href"); 
	showList(pageNum);
})
```

- 수정과 삭제 시에도 현재 댓글이 포함된 페이지로 이동하도록 수정 
```js
modalRemoveBtn.on("click",function(){
	var rno = modal.data("rno"); 
	replyService.remove(rno, function(){
		modal.modal("hide"); 
		showList(pageNum); // !!!!
	}); 
});

// 댓글 수정 이벤트 처리 
modalModBtn.on("click", function(){
	var reply = {
			rno : modal.data("rno"),
			reply : modalInputReply.val()
	};
	
	replyService.update(reply, function(result){
		modal.modal("hide");
		showList(pageNum); // !!!!!
	});
}); 
```


