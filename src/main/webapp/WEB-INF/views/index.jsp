<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'logout'}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Portfolio</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <style>
        #wrap {
            min-height: 80vh;
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
<div style="text-align:center">
    <h1>This is FirstPage</h1>
    <br>
    <h1>This is FirstPage</h1>
    <br>
    <h1>This is FirstPage</h1>
    <br>
</div>
<div id='wrap'>
    <footer>
        <nav>
            <a href='https://blog.naver.com/fjdp10' target='_blank'>Blog</a> |
            <a href='https://github.com/Arthur-Winni/My_Portfolio' target='_blank'>Github</a>
        </nav>
        <p>
            <span>저자 : 김하랑</span><br/>
            <span>이메일 : fjdp10@naver.com</span><br/>
            <span>Copyright 2023. fjdp10</span>
        </p>
    </footer>
</div>
</body>
</html>