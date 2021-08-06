
let replyService = (()=>{
    
    function add(data, callback,error){
        $.ajax({
            type: "post", 
            url : "/replies/new", 
            data : JSON.stringify(data), 
            contentType : "application/json;charset=utf-8", 
            success : function(result){
                if(callback) callback(result);
            }, 
            error : function(er){
                if(error) error(er); 
            }
        }); 
    }

    function getList(reply, callback, error){
        let bno = reply.bno; 
        let page = reply.page || 1; 

        $.getJSON("/replies/pages/" + bno + "/"+page,
            (data ) =>{
                if(callback) callback(data); 
        }).fail((xhr, status, err) => { if(error) error(err);})
    }

    function remove(rno, callback, error){
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

    function update(reply, callback, error){
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
        }); 
    }
    
    function get(rno, callback, error){
        $.get("/replies/" + rno ,  
            (result) => {
                if(callback) callback(result)
        }).fail((xhr, status, er)=>{
            if(error) error(er) 
        })
    }

    let displayTime = (time) => {
        let today = new Date(); 
        let gap = today.getTime() - time; 
        const ONE_DAY = 1000*60*60*24; 
        let dateObj = new Date(time);
        
        if(gap< ONE_DAY){
            const hh = dateObj.getHours(); 
            const mi = dateObj.getMinutes(); 
            const ss = dateObj.getSeconds(); 
            return [
                (hh > 9 ? '':'0') + hh, ':',
                (mi > 9 ? '':'0') + mi, ':',
                (ss > 9 ? '':'0') + ss
            ].join(''); 
        }
        if(gap>= ONE_DAY){
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

    // replyService 모듈 추가 

    return {
        add : add,
        getList : getList,
        remove : remove,  
        update : update, 
        get : get, 
        displayTime : displayTime,       
    }; 
})();

/* 테스트 코드 */ 





