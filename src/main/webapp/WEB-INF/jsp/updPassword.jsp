
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>修改密码</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/HTmoban/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/HTmoban/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/HTmoban/css/updxadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/HTmoban/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/HTmoban/js/xadmin.js"></script>

</head>
<body class="login-bg">
    
    <div class="login layui-anim layui-anim-up">
        <div  class="message">修改密码</div>
        <div id="darkbannerwrap"></div>
        
        <form method="post" class="layui-form" action="${pageContext.request.contextPath}/upd/updPassword">
            <span style="color: red;">${msg}</span>
            <input name="oldPassword" placeholder="原密码"  type="password" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="newPassword" lay-verify="required" placeholder="新密码"  type="password" class="layui-input">
            <hr class="hr15">
            <input name="newPasswordAgain"  placeholder="再次输入新密码"  type="password"  lay-verify="required" class="layui-input">
            <hr class="hr15">
            <input value="确认修改" onclick="upd()" lay-submit lay-filter="login" style="width:100%;" type="submit">
            <hr class="hr20" >
        </form>
    </div>
    <script>


    </script>
    <%--<script>--%>
        <%--$(function  () {--%>
            <%--layui.use('form', function(){--%>
              <%--var form = layui.form;--%>

              <%--// layer.msg('玩命卖萌中', function(){--%>
              <%--//   //关闭后的操作--%>
              <%--//   });--%>
              <%--//监听提交--%>
              <%--form.on('submit(login)', function(data){--%>
                 <%--alert(888);--%>
                <%--layer.msg(JSON.stringify(data.field),function(){--%>
                    <%--location.href='${pageContext.request.contextPath}/dl/yz'--%>
                <%--});--%>
                <%--return false;--%>
              <%--});--%>
            <%--});--%>
        <%--})--%>

        <%----%>
    <%--</script>--%>

    
    <!-- 底部结束 -->

</body>
</html>
