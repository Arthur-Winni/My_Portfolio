<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page session="true"%>
<c:set var="loginId" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'logout'}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Portfolio</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            border: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
        }
        .container {
            width : 50%;
            margin : auto;
        }
        .writing-header {
            position: relative;
            margin: 20px 0 0 0;
            padding-bottom: 10px;
            border-bottom: 1px solid #323232;
        }
        input {
            width: 100%;
            height: 35px;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            padding: 8px;
            background: #f8f8f8;
            outline-color: #e6e6e6;
        }
        textarea[name="content"] {
            width: 100%;
            background: #f8f8f8;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            resize: none;
            padding: 8px;
            outline-color: #e6e6e6;
        }
        .frm {
            width:100%;
        }
        #writeBtn, #writeNewBtn, #modifyBtn, #removeBtn, #listBtn {
            background-color: rgb(236, 236, 236);
            border: none;
            color: black;
            padding: 6px 12px;
            font-size: 14px;
            cursor: pointer;
            border-radius: 5px;
        }
        #writeBtn:hover, #writeNewBtn:hover, #modifyBtn:hover, #removeBtn:hover, #listBtn:hover {
            text-decoration: underline;
        }
        dl {
            border:  1px solid rgb(235,236,239);
            border-bottom : 0;
            position:relative;
        }

        dt {
            background-color: #f9f9fa;
            list-style-type: none;
            border-bottom : 1px solid rgb(235,236,239);
            padding : 18px 18px 0 18px;
        }
        #commentList {
            width : 50%;
            margin : auto;
        }
        span.comment {
            overflow-wrap: break-word;
            font-size: 12px;
        }
        .comment-bottom {
            font-size:9pt;
            color : rgb(97,97,97);
            padding: 8px 0 8px 0;
        }
        .comment-bottom > button {
            color : rgb(97,97,97);
            text-decoration: none;
            margin : 0 6px 0 0;
        }
        .comment-area {
            padding : 0 0 0 46px;
        }
        .commenter {
            font-size:12pt;
            font-weight:bold;
        }
        .commenter-writebox {
            padding : 15px 20px 20px 20px;
        }
        .comment-img {
            font-size:36px;
            position: absolute;
        }
        .up_date {
            margin : 0 8px 0 0;
        }
        #comment-writebox {
            background-color: white;
            border : 1px solid #e5e5e5;
            border-radius: 5px;
        }
        #comment-wb, #reply-wb, #modify-wb {
            display: block;
            width: 100%;
            min-height: 17px;
            padding: 0 20px;
            border: 0;
            outline: 0;
            font-size: 12px;
            resize: none;
            box-sizing: border-box;
            background: transparent;
            overflow-wrap: break-word;
            overflow-x: hidden;
            overflow-y: auto;
        }
        #comment-writebox-bottom {
            padding : 3px 10px 10px 10px;
            min-height : 35px;
        }
        #sendBtn, #modBtn, #wrtRepBtn, #canRepBtn, #canModBtn, .delBtn, .modBtn, .replyBtn {
            font-size:10pt;
            color : black;
            background-color: #eff0f2;
            text-decoration: none;
            padding : 5px 3px 5px 3px;
            border-radius: 5px;
            float : right;
            margin-left: 10px;
        }
        #sendBtn:hover, #modBtn:hover, #wrtRepBtn:hover, #canRepBtn:hover, #canModBtn:hover,.delBtn:hover, .modBtn:hover, .replyBtn:hover {
            text-decoration: underline;
        }
        #replyForm {
            background-color: white;
            border : 1px solid #e5e5e5;
            border-radius: 5px;
            margin : 10px;
            display: none;
        }
        #reply-writebox-bottom {
            padding : 3px 10px 10px 10px;
            min-height : 35px;
        }
        #modify-writebox {
            background-color: white;
            border : 1px solid #e5e5e5;
            border-radius: 5px;
            margin : 10px;
            display: none;
        }
        #modify-writebox-bottom {
            padding : 3px 10px 10px 10px;
            min-height : 35px;
        }
        #wrap {
            min-height: 40vh;
            position: relative;
            width: 100%;
        }
        section {
            padding-bottom: 105px;
        }
        footer {
            width: 100%;
            height: 90px;
            bottom: 0px;
            position: absolute;
            border-top: 1px solid #c4c4c4;
            padding-top: 15px;
            color: #808080;
            font-size: 11px;
        }
        footer a {
            display: inline-block;
            margin: 0 20px 10px 20px;
            color: #808080; font-size: 11px;
        }
        footer a:visited {
            color: #808080;
        }
        footer p {
            margin-top: 0; margin-bottom: 0;
        }
        footer p span {
            display: inline-block;
            margin-left: 20px;
        }
    </style>
</head>
<body>
<div id="menu">
    <ul>
        <li id="logo">Portfolio</li>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li><a href="<c:url value='/board/list'/>">Board</a></li>
        <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li><a href="<c:url value='/register/add'/>">Sign in</a></li>
        <li><a href=""><i class="fa fa-search"></i></a></li>
    </ul>
</div>
<script>
    let msg = "${msg}";
    if(msg=="WRT_ERR") alert("????????? ????????? ?????????????????????. ?????? ????????? ?????????.");
    if(msg=="MOD_ERR") alert("????????? ????????? ?????????????????????. ?????? ????????? ?????????.");
</script>
<div class="container">
    <h2 class="writing-header">????????? ${mode=="new" ? "?????????" : "??????"}</h2>
    <form id="form" class="frm" action="" method="post">
        <input type="hidden" name="bno" value="${boardDto.bno}">
        <input name="title" type="text" value="${boardDto.title}" placeholder="  ????????? ????????? ?????????." ${mode=="new" ? "" : "readonly='readonly'"}><br>
        <textarea name="content" rows="20" placeholder=" ????????? ????????? ?????????." ${mode=="new" ? "" : "readonly='readonly'"}>${boardDto.content}</textarea>
        <c:if test="${mode eq 'new'}">
            <button type="button" id="writeBtn" class="btn btn-write"><i class="fa fa-pencil"></i> ??????</button>
        </c:if>
        <c:if test="${mode ne 'new'}">
            <button type="button" id="writeNewBtn" class="btn btn-write"><i class="fa fa-pencil"></i> ?????????</button>
        </c:if>
        <c:if test="${boardDto.writer eq loginId}">
            <button type="button" id="modifyBtn" class="btn btn-modify"><i class="fa fa-edit"></i> ??????</button>
            <button type="button" id="removeBtn" class="btn btn-remove"><i class="fa fa-trash"></i> ??????</button>
        </c:if>
        <button type="button" id="listBtn" class="btn btn-list"><i class="fa fa-bars"></i> ??????</button>
    </form>
</div><br>
    <div id="commentList">
        <span id="listview"></span>
        <div id="comment-writebox">
            <div class="commenter commenter-writebox">${loginId}</div>
            <div class="comment-writebox-content">
                <textarea name="comment" id="comment-wb" cols="30" rows="3" placeholder="????????? ???????????????"></textarea>
            </div>
            <div id="comment-writebox-bottom">
                <div class="register-box">
                    <button id="sendBtn" class="btn" type="button">??????</button>
                </div>
            </div>
        </div>
    </div>
    <div id="replyForm">
        <div class="commenter commenter-writebox">${loginId}</div>
        <div class="reply-writebox-content">
            <textarea name="replyComment" id="reply-wb" cols="30" rows="3" placeholder="????????? ???????????????"></textarea>
        </div>
        <div id="reply-writebox-bottom">
            <div class="register-box">
                <button id="canRepBtn" class="btn" type="button">??????</button>
                <button id="wrtRepBtn" class="btn" type="button">??????</button>
            </div>
        </div>
    </div>
    <div id="modify-writebox">
        <h4>| ?????? ??????</h4>
        <div class="commenter commenter-writebox">${loginId}</div>
        <div class="modify-writebox-content">
            <textarea name="modify_comment" id="modify-wb" cols="30" rows="3"></textarea>
        </div>
        <div id="modify-writebox-bottom">
            <div class="register-box">
                <button id="canModBtn" class="btn" type="button">??????</button>
                <button id="modBtn" class="btn" type="button">??????</button>
            </div>
        </div>
    </div>
    <div id='wrap'>
        <footer>
            <nav>
                <a href='https://blog.naver.com/fjdp10' target='_blank'>Blog</a> |
                <a href='https://github.com/Arthur-Winni/My_Portfolio' target='_blank'>Github</a>
            </nav>
            <p>
                <span>?????? : ?????????</span><br/>
                <span>????????? : fjdp10@naver.com</span><br/>
                <span>Copyright 2023. fjdp10</span>
            </p>
        </footer>
    </div>
<script>
    let toHtml = function(comments) {
        let tmp = "<dl>";

        comments.forEach(function (comment) {
            tmp += '<dt class="comment-item" data-cno=' + comment.cno
            tmp += ' data-pcno=' + comment.pcno
            tmp += ' data-bno=' + comment.bno +'>'
            tmp += '<span class="comment-img"><i class="fa fa-user-circle" aria-hidden="true"></i></span>'
            tmp += '<div class="comment-area">'
            tmp += '<div class="commenter">' + comment.commenter + '</div>'
            if(comment.cno != comment.pcno)
                tmp += '???'
            tmp += '<span class="comment">' + comment.comment + '</span>'
            tmp += '<div class="comment-bottom">'
            tmp += '<span class="up_date">' + dateToString(comment.up_date) + '</span>'
            tmp += '<button class="delBtn">??????</button>'
            tmp += '<button class="modBtn">??????</button>'
            tmp += '<button class="replyBtn">????????????</button>'
            tmp += '</div>'
            tmp += '</div>'
            tmp += '</dt>'
        })

        return tmp + "</dl>";
    }
    let addZero = function(value=1){
        return value > 9 ? value : "0"+value;
    }

    let dateToString = function(ms=0) {
        let date = new Date(ms);

        let yyyy = date.getFullYear();
        let mm = addZero(date.getMonth() + 1);
        let dd = addZero(date.getDate());

        let HH = addZero(date.getHours());
        let MM = addZero(date.getMinutes());
        let ss = addZero(date.getSeconds());

        return yyyy+"."+mm+"."+dd+ " " + HH + ":" + MM + ":" + ss;
    }
    <c:if test="${empty boardDto.bno}">
        let bno = 0;
    </c:if>
    <c:if test="${not empty boardDto.bno}">
    let bno = ${boardDto.bno};
    </c:if>

    let showList = function(bno) {
        $.ajax({
            type:'GET',       // ?????? ????????? (?????? ?????? ??????????????? GET?????? ?????????)
            url: '/My_war_exploded/comments?bno=' + bno,  // ?????? URI
            success : function(result){
                $("#listview").html(toHtml(result));    // ??????????????? ????????? ???????????? ????????? ??????
            },
            error   : function(){ alert("error") } // ????????? ???????????? ???, ????????? ??????
        }); // $.ajax()
    }

    $(document).ready(function(){
        showList(bno);

        let formCheck = function() {
            let form = document.getElementById("form");
            if(form.title.value=="") {
                alert("????????? ????????? ?????????.");
                form.title.focus();
                return false;
            }
            if(form.content.value=="") {
                alert("????????? ????????? ?????????.");
                form.content.focus();
                return false;
            }
            return true;
        }
        $("#writeNewBtn").on("click", function(){
            location.href="<c:url value='/board/write'/>";
        });
        $("#writeBtn").on("click", function(){
            let form = $("#form");
            form.attr("action", "<c:url value='/board/write'/>");
            form.attr("method", "post");
            if(formCheck())
                form.submit();
        });
        $("#modifyBtn").on("click", function(){
            let form = $("#form");
            let isReadonly = $("input[name=title]").attr('readonly');
            // 1. ?????? ????????????, ?????? ????????? ??????
            if(isReadonly=='readonly') {
                $(".writing-header").html("????????? ??????");
                $("input[name=title]").attr('readonly', false);
                $("textarea").attr('readonly', false);
                $("#modifyBtn").html("<i class='fa fa-pencil'></i> ??????");
                return;
            }
            // 2. ?????? ????????????, ????????? ????????? ????????? ??????
            form.attr("action", "<c:url value='/board/modify${searchCondition.queryString}'/>");
            form.attr("method", "post");
            if(formCheck())
                form.submit();
        });
        $("#removeBtn").on("click", function(){
            if(!confirm("????????? ?????????????????????????")) return;
            let form = $("#form");
            form.attr("action", "<c:url value='/board/remove${searchCondition.queryString}'/>");
            form.attr("method", "post");
            form.submit();
        });
        $("#listBtn").on("click", function(){
            location.href="<c:url value='/board/list${searchCondition.queryString}'/>";
        });

        $("#wrtRepBtn").click(function(){
            let bno = $("#replyForm").parent().attr("data-bno");
            let comment = $("textarea[name=replyComment]").val();  //textarea ???????????? ????????? ?????? ???????????? ????????? ??????????????? ?????????.
            let pcno = $("#replyForm").parent().attr("data-pcno");

            if(comment.trim()==''){
                alert("????????? ??????????????????.");
                $("textarea[name=replyComment]").focus()
                return;
            }
            $.ajax({
                type:'POST',       // ?????? ?????????
                url: '/My_war_exploded/comments?bno=' +bno,  // ?????? URI <- ?????? ???????????? ???????????? PostMapping("/comments) ???????????? ??????????????? ?????????.
                headers : { "content-type": "application/json"}, // ?????? ??????
                data : JSON.stringify({pcno:pcno, comment:comment, bno:bno}),  // ?????? let comment ????????? json?????? ?????????????????? ????????? ???????????? ????????? ?????????.
                // ????????? ?????? ?????? ???????????? ????????? ?????? ?????? ???????????? ????????? PostMapping("/comments) ?????? ?????? ????????? bno??? comment?????? ?????????@RequestBody??? CommentDto??? Integer bno??? ?????? ?????? ??????.
                success : function(result){
                    alert(result);
                    showList(bno);
                },
                error   : function(){ alert("error") } // ????????? ???????????? ???, ????????? ??????
            }); // $.ajax()

            $("#replyForm").css("display", "none");
            $("textarea[name=replyComment]").val('')
            $("#replyForm").appendTo("body");
        });

        $("#canRepBtn").click(function(){
            $("#replyForm").css("display", "none");
        });
        $("#canModBtn").click(function(){
            $("#modify-writebox").css("display", "none");
        });

        $("#sendBtn").click(function(){
            let comment = $("textarea[name=comment]").val();  // textarea ???????????? ????????? ?????? ???????????? ????????? ??????????????? ?????????.

            if(comment.trim()==''){
                alert("????????? ??????????????????.");
                $("textarea[name=comment]").focus()
                return;
            }
            $.ajax({
                type:'POST',       // ?????? ?????????
                url: '/My_war_exploded/comments?bno=' +bno,  // ?????? URI <- ?????? ???????????? ???????????? PostMapping("/comments) ???????????? ??????????????? ?????????.
                headers : { "content-type": "application/json"}, // ?????? ??????
                data : JSON.stringify({bno:bno, comment:comment}),  // ?????? let comment ????????? json?????? ?????????????????? ????????? ???????????? ????????? ?????????.
                // ????????? ?????? ?????? ???????????? ????????? ?????? ?????? ???????????? ????????? PostMapping("/comments) ?????? ?????? ????????? bno??? comment?????? ?????????@RequestBody??? CommentDto??? Integer bno??? ?????? ?????? ??????.
                success : function(result){
                    alert(result);
                    showList(bno);
                    $("textarea[name=comment]").val('');
                },
                error   : function(){ alert("error") } // ????????? ???????????? ???, ????????? ??????
            }); // $.ajax()
        });

        $("#modBtn").click(function(){
            let cno = $("#modify-writebox").parent().attr("data-cno");
            let comment = $("textarea[name=modify_comment]").val();

            if(comment.trim()==''){
                alert("????????? ????????? ??????????????????.");
                $("textarea[name=modify_comment]").focus()
                return;
            }
            $.ajax({
                type:'PATCH',       // ?????? ?????????
                url: '/My_war_exploded/comments/' + cno,
                headers : { "content-type": "application/json"},
                data : JSON.stringify({cno:cno, comment:comment}),

                success : function(result){
                    alert(result);
                    showList(bno);
                },
                error   : function(){ alert("?????? ???????????? ????????? ??? ????????????.") }
            }); // $.ajax()
        });

        $("#commentList").on("click", ".delBtn", function (){  // ????????? ????????????????????? ???????????? ???????????? ??????. ???????????? ????????? ????????? ???????????? ??????????????? ??? ??????????????? ??? ????????? ???????????? send????????? ?????????
            // ???????????? function??? ????????? ?????? ?????? ????????????. ????????? #commentList(????????????)??? ???????????? ???????????? ????????? delBtn??? ??????????????? ???????????? ??? ???????????? ??????.
            // ??? ????????? ???????????? ???????????? ????????? ???????????? ?????? ????????????.
            let cno = $(this).parents('dt').attr('data-cno');
            let bno = $(this).parents('dt').attr('data-bno');

            $.ajax({
                type:'DELETE',
                url: '/My_war_exploded/comments/' + cno + '?bno=' + bno,
                success : function(result){
                    alert(result)
                    showList(bno);
                },
                error   : function(){ alert("???????????? ????????? ????????? ??? ????????????.") }
            }); // $.ajax()
        });

        $("#commentList").on("click", ".replyBtn", function (){
            // 1.replyForm??? ?????????
            $("#replyForm").appendTo($(this).parents('dt'));
            // 2. ????????? ????????? ?????? ????????????.
            $("#replyForm").css("display", "block");
            $("#modify-writebox").css("display", "none");
        });

        $("#commentList").on("click", ".modBtn", function () {
            let comment = $(this).parent().prev(".comment").text();
            $("textarea[name='modify_comment']").val(comment);

            $("#modify-writebox").appendTo($(this).parents('dt'));
            $("#modify-writebox").css("display", "block");
            $("#replyForm").css("display", "none");
        });
    });
</script>
</body>
</html>