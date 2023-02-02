<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register Check Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <style>
        table {
            border-collapse: collapse;
            width: 50%;
            border-top: 2px solid rgb(39, 39, 39);
        }
        button {
            background-color: rgb(89,117,196);
            color : white;
            width:100px;
            height:40px;
            font-size: 13px;
            border : none;
            border-radius: 5px;
            margin : 10px 0 20px 0;
        }
        th,
        td {
            width:300px;
            text-align: center;
            padding: 10px 12px;
            border-bottom: 1px solid #ddd;
        }
        td {
            color: rgb(53, 53, 53);
        }
        .id      { width:100px; text-align: center;  }
        .pwd   { width:50px; text-align: center;  }
        .name   { width:100px; text-align: center;  }
        .email  { width:150px; text-align: center;  }
        .birth { width:150px; text-align: center; }
        .sns { width:150px; text-align: center;  }
    </style>
</head>
<body>
<table>
    <h1>Register Check Page</h1>
    <br>
    <tr>
        <th class="id">id</th>
        <th class="pwd">pwd</th>
        <th class="name">name</th>
        <th class="email">email</th>
        <th class="birth">birth</th>
        <th class="sns">sns</th>
    </tr>
    <tr>
        <td class="id">${user.id}</td>
        <td class="pwd">${user.pwd}</td>
        <td class="name">${user.name}</td>
        <td class="email">${user.email}</td>
        <td class="birth"><fmt:formatDate pattern = "yyyy/MM/dd" value="${user.birth}"/></td>
        <td class="sns">${user.sns}</td>
    </tr>
</table>
<script>
    let msg = "${msg}";
    if(msg=="RST_OK")  alert("사용자 등록을 완룍했습니다.");
</script>
<br>
<form>
    <button type="button" id="backBtn" onclick="location.href='<c:url value="/login/login"/>'">확인</button>
</form>
</body>
</html>