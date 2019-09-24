<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/js/jquery.min.js"></script>
<html>
<head>
    <title>Title</title>
    <style>
        *{
            margin: 0px;
            padding: 0px;
        }
        body{
            background: url("/images/findBack3.jpg");
            background-repeat: no-repeat;
            background-size: 100% 100%;

        }
        #top{
            width: 100%;
            height: 125px;

        }
        #icon{
            width: 35px;
            height: 35px;
            background: url("/images/icon.png");
            position: absolute;
            left: 30px;
            top: 20px;
        }
        #text1{
            position: absolute;
            left: 80px;
            top:30px;
            font-family: 经典中圆简;
            color: white;
            font-size:20px ;
        }
        #text2{
            position: absolute;
            left: 760px;
            top:30px;
            font-family: 全新硬笔行书简;
            color: white;
            font-size:50px ;

        }
        #medium{
            width: 100%;
            height: 100px;
        }
        #all{
            width: 550px;
            height: 70px;
            margin: 20px auto;
            position: relative;
        }
        #findInput{
            width: 400px;
            height: 40px;
            border: #009BDB 1px solid;
        }
        .btns{
            width:145px; height:40px; background:#E9E9EB ;color:red;
            font-family: 经典叠圆体简;
            font-size: 20px;
            position: absolute;
            right: 0px;
        }
        .btns:hover{
            background:#071657;
        }
        #text3{
            font-family: 幼圆;
            color: white;
        }
        #table{
            margin: 50px auto;
            width: 600px;
            height: 200px;
            color: white;
            text-align:center;
            border: white;
        }
        #headPhoto{
            background: url("${friends.headPhoto}");
            background-size: 100%;
            width: 100px;
            height: 100px;
        }
        .footer{
            position: absolute;
            bottom: 76px;
            left: 45%;
            color: white;
        }
        #add{
            width: 54px;
            height: 54px;
            background: url("/images/add.png");
            background-repeat: no-repeat;
            background-position: center;
            cursor:pointer;
        }
        #show{
            font-family:华康雅宋体W9(P);
            font-size: 20px;
        }
    </style>
</head>
<body>
<div id="top">
    <div id="icon"></div>
    <span id="text1">找好友</span>
    <span id="text2">偶像练习生交友中心</span>
</div>
<div id="medium">
    <div id="all">
        <form action="/findFriends" method="post">
            <input type="text" placeholder="请输入ID/用户名" id="findInput" name="userId" value="${friends.userId}">
            <input type="submit" value="查找" class="btns">
        </form>
        <span id="text3">大型婚姻交友，尽在偶像练习生</span>
    </div>
</div>
<table id="table" cellspacing="0">
    <c:if test="${friends!=null}">
        <tr>
            <th>头像</th>
            <th>用户ID</th>
            <th>用户名</th>
            <th>性别</th>
            <th>班级号</th>
            <th>个性签名</th>
            <th>添加好友</th>
        </tr>
        <tr id="show">
            <td id="headPhoto"></td>
            <td>${friends.userId}</td>
            <td >${friends.userName}</td>
            <td >${friends.userSex>0?"女":"男"}</td>
            <td >${friends.classId}</td>
            <td >${friends.signature}</td>
            <td id="add"></td>
        </tr>
    </c:if>
</table>
<div class="footer">
    <p>Copyright &copy; 第三小组*2019.</p>
</div>
</body>
</html>
<script src="/layim/dist/layui.js"></script>
<link rel="stylesheet" href="/layim/dist/css/layui.css">
<script>
    layui.use("layim",function (layim) {
        $("#add").click(function () {
            layim.add({
                type: 'friend' //friend：申请加好友、group：申请加群
                ,username: '${friends.userName}' //好友昵称，若申请加群，参数为：groupname
                ,avatar: '${friends.headPhoto}' //头像
                ,submit: function(group, remark, index){ //一般在此执行Ajax和WS，以通知对方
                    var socket = new WebSocket( "ws://" + window.location.host + "/box");
                    socket.onopen=function (ev) {
                        console.log("${my.userName}连接上了")
                    }



                    console.log(group); //获取选择的好友分组ID，若为添加群，则不返回值
                    console.log(remark); //获取附加信息
                    layer.close(index); //关闭改面板
                }
            });
        })
    })

</script>
