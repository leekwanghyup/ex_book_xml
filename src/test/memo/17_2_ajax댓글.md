ex8 프로젝트 복사

## 자바스크립트의 모듈화

/webapp/resources/js/reply.js 생성

get.jsp
```jsp
<script src="/resources/js/reply.js"></script>
```
- alert로 간단한 테스트 

## 모듈 구성하기

reply.js
```js
console.log("Reply module");

var replyService = (() => {
	return {name : "AAAA"}
})();
```

get.jsp
```js
$(function() {
	console.log(replyService);
}); 
```

## reply.js 등록처리 
reply.js
```js
console.log("Reply module");

var replyService = (() => {
	// insert  
	function add(reply, callback, error){
		$.ajax({
			type : "post",
			url : "/replies/new",
			data : JSON.stringify(reply),
			contentType : "application/json;charset=utf-8",
			success : function(result) {
				if(callback) callback(result);
			},
			error : function(er) {
				if(error) error(er); 
			}
		})
	}
	return {
		add : add,
	}; 
})(); 
```
### 테스트 
get.jsp
```js
// reply add test
var bnoValue = "${board.bno}";
replyService.add(
    {
        bno : bnoValue,
        reply : "JS TEST2",
        replyer : "tester2",
    },
    function(result) {
        alert("RESULT : " + result);
    }
);
```

## reply.js 목록 

reply.js
```js
var getList = (param, callback, error) =>{
		
    var bno = param.bno;
    var page = param.page || 1; 
    
    $.getJSON("/replies/pages/" + bno + "/" + page, 
        (data) => {
            if(callback) callback(data);
    }).fail((xhr, status, err) => {
        if(error) error(); 
    });
}
```


테스트 : get.jsp
```js
$(function() {
	
	console.log("===================");
	console.log("JS TEST");
	
	var bnoValue = "${board.bno}";
	
	replyService.getList({bno : bnoValue, page : 1}, function(list) {
		for (var i = 0; i < list.length; i++) {
			console.log(list[i])
		}
	}); 
	
});
```

## 댓글 삭제 

reply.js
```js
// delete
var remove = (rno, callback, error)=>{
    $.ajax({
        type : "delete",
        url : "/replies/" + rno ,
        success : (result, status, xhr) => {
            if(callback) callback(result)
        },
        error : (xhr, status, er) => {
            if(error) error(er); 
        }
    })
}
```

테스트 : get.jsp
```js
// 삭제 테스트
replyService.remove(3,(result) => {
    if(result === "success") alert('REMOVE')
}, (er) => {
    alert('ERROR')
})
```

## 댓글 수정 

reply.js
```js
 // update 
var update = (reply, callback, error)=>{
    $.ajax({
        type : "put",
        url : "/replies/" + reply.rno,
        data : JSON.stringify(reply),
        contentType : "application/json; charset=utf-8",
        success : (result, status, xhr)=>{
            if(callback) callback(result)
        },
        error : (xhr, status, er) => {
            if(error) error(er)
        }
    })
}
```

테스트 : get.jsp
```js
var bnoValue = "${board.bno}"; 
	 
replyService.update(
    {
        rno : 28,
        bno : bnoValue,
        reply : "Modify test"
    },
    function(result){
    alert('updated')
    }
)
```

## 댓글 조회 
```js
// get 
var get = (rno, callback, error)=>{
    $.get("/replies/" + rno ,  
        (result) => {
            if(callback) callback(result)
    }).fail((xhr, status, er)=>{
        if(error) error() 
    })
}
```

테스트 코드 : get.jsp
```js
var bnoValue = "${board.bno}"; 

    replyService.get(
        28,
        function(result) {
            console.log(result)
        }
    )

```