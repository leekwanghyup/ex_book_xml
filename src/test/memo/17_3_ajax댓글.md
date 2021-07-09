board_ex9 프로젝트 복사 

## 이벤트 처리와 HTML 처리 

get.jsp
```jsp
<div class="row"> <!-- 댓글 목록 -->
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <span>댓글</span>
                
            </div>
            <div class="panel-body">
                <ul class="list-group chat">
                    <li class="list-group-item left clearfix " data-rno="12">
                        <div>
                            <div class="header">
                                <strong class="primary-font">user00</strong>        
                                <small class="pull-right text-muted">2020-10-10</small>
                            </div>
                            <p>Good Job</p>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<script src="/resources/js/get.js"></script>
<script>var bnoValue = "${board.bno}";</script>

```

get.js
```js
$(function() {
    
	var replyUL = $(".chat");
	
	showList(1);
	function showList(page){
		
	    replyService.getList(
	        {bno : bnoValue, page : page || 1},
	        function(list){
	            
	            var str = ""; 
	            
	            if(list == null || list.lenght == 0){
	                replyUL.html(""); 
	                alert('?'); 
	                return; 
	            }
	            
	            for(var i=0, len = list.length || 0 ; i<len; i++){
  					str+=`
				    <li class='list-group-item left clearfix' data-rno=${list[i].rno}>
					    <div>
					        <div class='header'><strong class='primary-font'>${list[i].replyer}</strong>
					            <small class='pull-right text-muted'>${list[i].replyDate}</small><br>
					        </div><br>
					        <p>${list[i].reply}</p>
					    </div>
					</li>`;
  					
	            }
	            replyUL.html(str);
	    });
	}
}); 
```

## 시간 처리 

reply.js
```js
// 시간처리 
var displayTime = (timeValue) => {
    var today = new Date();
    var gap = today.getTime() - timeValue; 
    var dateObj = new Date(timeValue);
    var str = ""; 
    
    if(gap<(1000*60*60*24)){ // 24시간이 지나면 
        var hh = dateObj.getHours(); 
        var mi = dateObj.getMinutes(); 
        var ss = dateObj.getSeconds(); 
        return [
            (hh > 9 ? '':'0') + hh, ':',
            (mi > 9 ? '':'0') + mi, ':',
            (ss > 9 ? '':'0') + ss
        ].join(''); 
    } else{
        var yy = dateObj.getFullYear(); 
        var mm = dateObj.getMonth() + 1; 
        var dd = dateObj.getDate(); 
        return [
            yy, '/', 
            (mm > 9 ? '':'0') + mm, '/',
            (dd > 9 ? '':'0') + dd
        ].join('');
    }
} 

```
- replyService 함수 내에 작성, 따라서 반드시 return 처리해야함 

- ajax에서 데이터를 가져와 html을 만들어주는 부분 수정 
get.js
```js
<small class='pull-right text-muted'>${replyService.displayTime(list[i].replyDate)}</small><br>
```

## 새로운 댓글 처리 

- 댓글 쓰기 모달창
get.jsp
```jsp
<div class="modal fade" id="addReplyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">새로운 댓글 쓰기 </h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>작성자 </label>
					<input type="text" class="form-control" name="replyer" placeholder="작성자">
				</div>
				<div class="form-group">
					<label>댓글</label>
					<input type="text" class="form-control" name="reply" placeholder="내용을 입력하세요.">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="modalModBtn" class="btn btn-warning">수정</button>
				<button type="button" id="modalRemoveBtn" class="btn btn-danger">삭제</button>
				<button type="button" id="modalRegisterBtn" class="btn btn-primary">등록</button>
				<button type="button" id="modalCloseBtn" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
```

get.js
```js
var modal = $(".modal");
var modalInputReply = modal.find("input[name='reply']");
var modalInputReplyer = modal.find("input[name='replyer']");
var modalInputReplyDate = modal.find("input[name='replyDate']");

var modalModBtn = $("#modalModBtn") 
var modalRemoveBtn = $("#modalRemoveBtn") 
var modalRegisterBtn = $("#modalRegisterBtn")

$("#addReplyBtn").on("click",function(){
    modal.find("input").val("");
    modalInputReplyDate.closest("div").hide(); // ???
    modal.find("button[id !='modalCloseBtn']").hide();
    modalRegisterBtn.show();
    modal.modal("show");
});
```


- 댓글 추가 이벤트 처리 
get.js
```js
// 댓글 쓰기 등록 처리 
modalRegisterBtn.on("click",function(){
    var reply = {
            reply : modalInputReply.val(),
            replyer : modalInputReplyer.val(),
            bno : bnoValue
    }; 
    replyService.add(reply, function(result) {
        alert(result)
        
        modal.find("input").val(""); // 등록한 내용으로 다시 등록할 수 없도록 입력항목을 모두 비운다.  
        modal.modal("hide"); 
        showList(1); // 목록 갱신
    }); 
})
```

## 특정 댓글의 클릭 이벤트 
- Ajax를 통해서 li 태그들이 만들어지면 이후에 이벤트 등록을 해야한다. 
- 따라서 일반적인 방식이 아닌 '이벤트 위임'의 형태로 작성해야 한다. 
- 이미 존재하는 요소에 이벤트를 걸어주고 나중에 이벤트의 대상을 변경해주는 병삭이다. 

- 수정/삭제 버튼 추가 
```js
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
```

- 이벤트 처리 

```js
//특정댓글 클릭 이벤트 처리 
$(".chat").on("click","a",function(e){ // <a> 태그에 이벤트 위임
    e.preventDefault();
    var rno = $(this).data("rno");
    
    replyService.get(rno, function(reply){
        modalInputReply.val(reply.reply); 
        modalInputReplyer.val(reply.replyer);
        modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
        .attr("readonly", "readonly");  
        modal.data("rno", reply.rno);
        
        modal.find("button[id != 'modalCloseBtn']").hide();
        
        $("#myModalLabel").html("댓글 수정/삭제");
        modalModBtn.show(); 
        modalRemoveBtn.show(); 
        
        modal.modal("show");
    })
})
```

## 댓글/삭제 이벤트 처리 
```js
// 댓글 수정 이벤트 처리 
modalModBtn.on("click", function(){
    
    var reply = {
            rno : modal.data("rno"),
            reply : modalInputReply.val()
    };
    
    replyService.update(reply, function(result){
        modal.modal("hide");
        showList(1);
    });
}); 

// 댓글 삭제 이벤트 처리 
modalRemoveBtn.on("click",function(){
    var rno = modal.data("rno"); 
    replyService.remove(rno, function(){
        modal.modal("hide"); 
        showList(1);
    }); 
});
```