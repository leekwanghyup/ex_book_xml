$(function(){
    

    let replyUL = $('.chat');
    showList(1);

    // 댓글 리스트 
    function showList(page){ 
        replyService.getList(
            {bno : bno, page : page || 1}, 
            function(list){
                let str = ""; 
                if(list == null || list.length == 0){
                    replyUL.html("");
                    console.log('등록된 댓글이 없습니다.');
                }

                for(let i=0, len = list.length || 0 ; i<len; i++){
                  str+=
                    `<li class="list-group-item" data-rno="${list[i].rno}">   
                        <div>
                            <img src="/resources/images/sc_icon.png"/>
                            <strong>${list[i].replyer}</strong>        
                            <span class="pull-right txt-muted">
                                ${replyService.displayTime(list[i].replyDate)}
                            </span>
                        </div>
                        <div class="py-2 reply${list[i].rno}">
                            <div class="content${list[i].rno}">${list[i].reply}</div>
                            <div class="py-2 update_delete">
                                <a href="#" class="updateForm getBtn pull-right" data-rno=${list[i].rno}> 수정</a> 
                                <a href="#" class="deleteReply getBtn pull-right" data-rno=${list[i].rno}> 삭제</a> 
                            </div>
                        </div>
                        
                    </li>`;
                }
                replyUL.html(str);
            } // second param
        ); // getList
    } // showList

    // 댓글 등록
    let replyWriteForm = $('.replyWriteForm');   
    $('#registerBtn').on('click',function(){
        const replyContent = replyWriteForm.find('textarea').val();
        const bno = $('#bno').val();
        let reply = {
            reply : replyContent, 
            replyer : replyer, 
            bno : bno    
        }
        replyService.add(reply, function(){
            replyWriteForm.find('textarea').val("");
            showList(1); 
        }); 
        
    }); 

    // 댓글 수정 이벤트 처리 
    $('.chat').on('click','.updateForm',function(e){
        e.preventDefault(); 
        $('.update_delete').hide();
        let rno = $(this).data('rno');
        let replyContent = $(".content"+rno).html();

        let replyForm = `
            <input type="text" class="updated" value="${replyContent}">
            <a href="#" class="updateReply">확인</a> 
            <a href="#" class="cancel">취소</a> 
        `; 

        // 취소버튼을 클릭했을때 
        let before = $(".reply"+rno).clone().html();
        $(".reply"+rno).html(replyForm);
        $('.cancel').on('click',function(e){
            e.preventDefault(); 
            $(".reply"+rno).html(before);
            $('.update_delete').show();
        }); 

        // 댓글 업데이트 이벤트 처리 
        $('.updateReply').on('click',function(e){
            e.preventDefault(); 
            let updated = $('.updated').val(); // 수정한 내용 
            let reply = {
                rno : rno, 
                reply : updated
            }
            replyService.update(reply,function(){
                showList(1);
            }); 
        }); 
    }); 

    // 댓글 삭제 처리 
    $('.chat').on('click','.deleteReply',function(e){
        e.preventDefault(); 
        let rno = $(this).data('rno');
        replyService.remove(rno,function(){
            alert(rno+'삭제!');
            showList(1);
        })
    }); 

})


