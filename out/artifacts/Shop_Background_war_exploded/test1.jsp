
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <title></title>
</head>
<script language="javascript">

    function time(h)
    {
        var date=new Date();
        var year=date.getFullYear();
        var month=date.getMonth()+1;
        console.log("看看yera"+year);
        console.log("看看month"+month);
        month=month<10?"0"+month:month;
        console.log("看看month2"+month);
        var day=date.getDate();
        console.log("看看day"+day);
        day=day<10?"0"+day:day;
        console.log("看看day2"+day);
        var nowTime=year+"-"+month+"-"+day;
        console.log("看看"+nowTime);
    }
</script>
<body>
     <button onclick="time()">测试</button>
</body>
</html>