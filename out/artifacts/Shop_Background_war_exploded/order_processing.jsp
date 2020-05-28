<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/commander.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.12.3.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/check_commodity.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/test5.css">
	<title>Insert title here</title>
	<script type="text/javascript">

        var s=1;
        aa1=function () {
            $("#open_modal3").trigger("click");
        }
        //显示、隐藏小菜单
        qwq=function (){
            $(".xiaocaidan").toggle("fast","swing",function () {
                if(s===1){
                    $(".show").addClass("yincang");
                    $(".show").removeClass("show");
                    $(".table").css({width:"100%"});
                    s=0;
                }
                else
                {
                    $(".yincang").addClass("show");
                    $(".yincang").removeClass("yincang");
                    $(".yincang").addClass("show");
                    $(".table").css({width:"86%"});
                    s=1;
                }
            })
        }
		var allnumber=0;
        //加载所有订单数量
        load_already_Number=function () {
            $.get("Order/FindOrderByPageServlet",{currentPage: 1,rows:10,condition:null,ids:1}, function (pv) {
                $("#already").html( pv.totalCount );
                allnumber=allnumber+pv.totalCount;
            });
		};
        load_deliver_Number=function () {
            $.get("Order/FindOrderByPageServlet",{currentPage: 1,rows:10,condition:null,ids:2}, function (pv) {
                $("#deliver").html( pv.totalCount);
                allnumber=allnumber+pv.totalCount;
            });
        };
        load_take_over_Number=function () {
            $.get("Order/FindOrderByPageServlet",{currentPage: 1,rows:10,condition:null,ids:3}, function (pv) {
                $("#take_over").html( pv.totalCount);
                allnumber=allnumber+pv.totalCount;
            });
        };
        load_returning_Number=function () {
            $.get("Order/FindOrderByPageServlet",{currentPage: 1,rows:10,condition:null,ids:4}, function (pv) {
                $("#returning").html(pv.totalCount);
                allnumber=allnumber+pv.totalCount;
            });
        };
        load_returned_Number=function () {
            $.get("Order/FindOrderByPageServlet",{currentPage: 1,rows:10,condition:null,ids:5}, function (pv) {
                $("#returned").html( pv.totalCount);
                allnumber=allnumber+pv.totalCount;
            });
        };
        load_Order_Number = function () {
            setTimeout(function(){

            $("#all").html(allnumber);},1000);

        };

        selectAll=function(obj){
            //获取下边的复选框
            $(".itemSelect").prop("checked",obj.checked);
        }

        //发货
        deliver_Order=function(orderid,currentPage,condition,ids)
        {
            //用户安全提示
            if(confirm("确定发货？")){
                //访问路径
                $.get("Order/deliver_OrderServlet", {orderid:orderid}, function (a){
                    if(a!=0){
                        alert("已发货！");
                        load_deliver_Number();
                        load_take_over_Number();
                        load_Order_Number();
                        load_Order(currentPage,condition,ids);
                    }
                    else
                        alert("发货失败！");
                })}
        }

        //批量发货
        Selected_deliver_Order=function (currentPage,condition,ids) {
            if(confirm("确定批量发货？")) {
                var flag = false;
                //判断是否有选中条目
                var cbs = $(".itemSelect");
                for (var i = 0; i < cbs.length; i++) {
                    if (cbs[i].checked) {
                        //有一个条目选中了
                        flag = true;
                        break;
                    }
                }

                if (flag) {//有条目被选中
                    //表单提交
                    var uids=[];
                    $('.itemSelect:checked').each(function(){
                        uids.push($(this).val());
                    });
                    var uid_json=JSON.stringify(uids);
                    $.get("Order/Bulk_deliver_OrderServlet", {uid:uid_json}, function (a1){
                        if(a1!=0){
                            alert("发货成功！");
                            load_deliver_Number();
                            load_take_over_Number();
                            load_Order_Number();
                            load_Order(currentPage,condition,ids);
                        }
                        else
                            alert("发货失败！");
                    })
                }
                else{
                    alert("未选中");
                }
            }
        }

        //退货
        return_Order=function(currentPage,orderid,condition,ids)
        {
            //用户安全提示
            if(confirm("确定退货？")){
                //访问路径
                $.get("Order/return_OrderServlet", {orderid:orderid}, function (a){
                    if(a!=0){
                        alert("已退货！");
                        load_already_Number();  //已收货
                        load_deliver_Number();//待发货
						load_returning_Number();//退货中
                        load_Order_Number();
                        load_Order(currentPage,condition,ids);
                    }
                    else
                        alert("退货失败！");
                })}
        }

        //批量退货
        Selected_return_Order=function (currentPage,condition,ids) {
            if(confirm("确定批量退货？")) {
                var flag = false;
                //判断是否有选中条目
                var cbs = $(".itemSelect");
                for (var i = 0; i < cbs.length; i++) {
                    if (cbs[i].checked) {
                        //有一个条目选中了
                        flag = true;
                        break;
                    }
                }

                if (flag) {//有条目被选中
                    //表单提交
                    var uids=[];
                    $('.itemSelect:checked').each(function(){
                        uids.push($(this).val());
                    });
                    var uid_json=JSON.stringify(uids);
                    $.get("Order/Bulk_return_OrderServlet", {uid:uid_json}, function (a1){
                        if(a1!=0){
                            alert("退货成功！");
                            load_already_Number();  //已收货
                            load_deliver_Number();//待发货
                            load_Order_Number();
                            load_Order(currentPage,condition,ids);
                        }
                        else
                            alert("退货失败！");
                    })
                }
                else{
                    alert("未选中");
                }
            }
        }

        load_Order=function (currentPage,condition,ids) {
            //更改批量下架id
            $("#Selected_all").removeAttr("onclick");
            $("#Selected_all2").removeAttr("onclick");
            $("#Selected_all").attr("onclick", "Selected_deliver_Order(" + currentPage + "," + condition + "," + ids + ")");
            $("#Selected_all2").attr("onclick", "Selected_return_Order(" + currentPage + "," + condition + "," + ids + ")");

            $.get("Order/FindOrderByPageServlet", {
                currentPage: currentPage,
                rows: 10,
                condition: condition,
                ids: ids
            }, function (pb) {
                //解析pagebean数据，展示到页面上

                //1.分页工具条数据展示
                //1.1 展示总页码和总记录数
                var _page1 = '共' + pb.totalCount + '条记录，共' + pb.totalPage + '页';
                $("#_page").html(_page1);

                var lis = "";
                //计算上一页的页码
                var beforeNum = pb.currentPage - 1;
                if (beforeNum <= 0) {
                    beforeNum = 1;
                }

                if (pb.currentPage == 1) {
                    var beforePage = '<li class="disabled"><a href="javascript:void(0)" aria-label="Previous">' +
                        '<span aria-hidden="true">&laquo;</span>' +
                        '</a></li>';
                }
                else {

                    var beforePage = '<li><a href="javascript:void(0)" onclick="load_Order(' + beforeNum + ',' + condition + ',' + ids + ')" aria-label="Previous">' +
                        '<span aria-hidden="true">&laquo;</span>' +
                        '</a></li>';
                }
                lis += beforePage;

                //1.2 展示分页页码
                /*
                    1.一共展示10个页码，能够达到前5后4的效果
                    2.如果前边不够5个，后边补齐10个
                    3.如果后边不足4个，前边补齐10个
                */

                // 定义开始位置begin,结束位置 end
                var begin; // 开始位置
                var end; //  结束位置


                //1.要显示10个页码
                if (pb.totalPage < 10) {
                    //总页码不够10页

                    begin = 1;
                    end = pb.totalPage;
                } else {
                    //总页码超过10页

                    begin = pb.currentPage - 5;
                    end = pb.currentPage + 4;

                    //2.如果前边不够5个，后边补齐10个
                    if (begin < 1) {
                        begin = 1;
                        end = begin + 9;
                    }

                    //3.如果后边不足4个，前边补齐10个
                    if (end > pb.totalPage) {
                        end = pb.totalPage;
                        begin = end - 9;
                    }
                }


                for (var i = begin; i <= end; i++) {
                    var li;
                    //判断当前页码是否等于i
                    if (pb.currentPage == i) {

                        li = '<li class="active"><a href="javascript:void(0)" onclick="load_Order(' + i + ',' + condition + ',' + ids + ')">' + i + '</a></li>';

                    } else {
                        //创建页码的li
                        li = '<li><a href="javascript:void(0)" onclick="load_Order(' + i + ',' + condition + ',' + ids + ')">' + i + '</a></li>';
                    }
                    //拼接字符串
                    lis += li;
                }

                var nextNum = pb.currentPage + 1;

                if (nextNum == pb.totalPage + 1) {
                    var nextPage = '<li class="disabled"><a href="javascript:void(0)" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';

                } else {
                    var nextPage = '<li><a href="javascript:void(0)"  onclick="load_Order(' + nextNum + ',' + condition + ',' + ids + ')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';
                }
                lis += nextPage;

                $("#pagination").html(lis);


                var route_lis = "";
                var li1 = '<tr class="success"><th><input type="checkbox" id="firstCb" onclick="selectAll(this)"></th>' +
                    '<th>订单号</th> ' +
                    '<th>价格</th>' +
                    '<th>会员</th> ' +
                    '<th>会员ID号</th> ' +
                    '<th>联系电话</th> ' +
                    '<th>订单状态</th> ' +
                    '<th>创建时间</th> ' +
                    '<th>操作</th> </tr>';
                route_lis += li1;

                for (var i = 0; i < pb.list.length; i++) {
                    //获取{rid:1,rname:"xxx"}
                    var route2 = pb.list[i];

                    var li2 = '<tr><td><input type="checkbox" id="del" name="uid" class="itemSelect" value="' + route2.phone + '">' + '</td>' +
                        '<td id="td_orderid">' + route2.orderid + '</td>' +
                        '<td>' + route2.price + '</td>' +
                        '<td>' + route2.name + '</td>' +
                        '<td>' + route2.userid + '</td>' +
                        '<td>' + route2.phone + '</td>' +
                        '<td >' + route2.conditions + '</td>' +
                        '<td>' + route2.add_time + '</td>' +
                        '<td>';
                    var out_order = "";
                    var dd2 = route2.name;
                    if (route2.conditions === "已收货") {
                        out_order = '<a class="btn btn-default btn-sm" href="javascript:void(0)" onclick="showAtRight(\'Order/DetailOrderServlet?orderid=' + route2.orderid + '\')">订单详情</a>&nbsp;' +
                            '<a class="btn btn-default btn-sm back_order" href="javascript:return_Order('+ pb.currentPage + ',\'' + route2.orderid +'\',' + condition + ',' + ids + ');">退货</a>';
                    } else if (route2.conditions === "待发货") {
                        out_order = '<a class="btn btn-default btn-sm" href="javascript:void(0)" onclick="showAtRight(\'Order/DetailOrderServlet?orderid=' + route2.orderid + '\')">订单详情</a>&nbsp;' +
                            '<a class="btn btn-default btn-sm back_order" href="javascript:return_Order(' + pb.currentPage + ',\'' +route2.orderid+'\',' + condition + ',' + ids + ');">退货</a>&nbsp;' +
                            '<a class="btn btn-default btn-sm out_order" href="javascript:deliver_Order(\'' + route2.orderid + '\',' + pb.currentPage + ',' + condition + ',\'' + ids + '\');">发货</a>';
                    } else if (route2.conditions === "待收货" || route2.conditions === "已退货") {
                        out_order = '<a class="btn btn-default btn-sm" href="javascript:void(0)" onclick="showAtRight(\'Order/DetailOrderServlet?orderid=' + route2.orderid + '\')">订单详情</a>&nbsp;';
                    } else if (route2.conditions === "退货中") {
                        out_order = '<a class="btn btn-default btn-sm" href="javascript:void(0)" onclick="showAtRight(\'Order/DetailOrderServlet?orderid=' + route2.orderid + '\')">订单详情</a>&nbsp;' +
                            '<a class="btn btn-default btn-sm back_order" href="javascript:deliver_Order(' + route2.orderid + ',' + pb.currentPage + ',\'' + condition + '\');">取消退货</a>';
                    }
                    else {

                    }
                    li2 = li2 + out_order + '</td></tr>';
                    route_lis += li2;

                    $("#table").html(route_lis);

                    if (ids === 0 || ids === 5 || ids === 3) {//
                        $("#Selected_all").css("display", "none");
                        $("#Selected_all2").css("display", "none");
                    } else if (ids === 1) {//已收货
                        $("#Selected_all2").removeAttr("style", "");
                        $("#Selected_all").css("display", "none");
                    } else if (ids === 2) {//待发货
                        $("#Selected_all").removeAttr("style", "");
                        $("#Selected_all2").removeAttr("style", "");
                    } else if (ids === 4) {//退货中
                        $("#Selected_all").css("display", "none");
                        $("#Selected_all2").css("display", "none");
                    }

                    //更改搜索方法
                    $("#search").removeAttr("onclick");
                    $("#search").attr("onclick", "load_Order(1,$('#select_').val()," + ids + ")");

                }
            })
        }
        $(function () {
            //加载数量
            load_already_Number();  //已收货
            load_deliver_Number();//待发货
            load_take_over_Number();//待收货
            load_returning_Number();//退货中
            load_returned_Number();//已退货
            load_Order_Number();//全部订单
            //加载类
            load_Order(1,null,0);

        });
	</script>

</head>
<body>
<jsp:include page="addShop.jsp"></jsp:include>
<%--左侧小菜单--%>
<div class="xiaocaidan">
	<div class="shop">
		<ul>
			<li class="fa fa-hourglass-o lis" aria-hidden="true">&nbsp;订单处理</li>
			<li class="fa fa-hourglass-end lis" aria-hidden="true"><a href="JavaScript:load_Order(1,null,0)">全部订单</a><span>(</span><span id="all">1</span><span>)</span></li>
			<li class="fa fa-hourglass lis" aria-hidden="true"><a href="JavaScript:load_Order(1,null,1)" >已收货</a><span>(</span><span id="already">1</span><span>)</span></li>
			<li class="fa fa-hourglass-start lis" aria-hidden="true"><a href="JavaScript:load_Order(1,null,2)">待发货</a><span>(</span><span id="deliver">1</span><span>)</span></li>
				<li class="fa fa-hourglass-half lis" aria-hidden="true"><a href="JavaScript:load_Order(1,null,3)">待收货</a><span>(</span><span id="take_over">1</span><span>)</span></li>
			<i class="fa fa-hourglass-half lis" aria-hidden="true"><a href="JavaScript:load_Order(1,null,4);">退货中</a><span>(</span><span id="returning">1</span><span>)</span></i>
			<i class="fa fa-hourglass-o lis" aria-hidden="true"><a href="JavaScript:load_Order(1,null,5);">已退货</a><span>(</span><span id="returned">1</span><span>)</span></i>
		</ul>
	</div>
</div>

<%--右侧数据列表--%>
<div class="container">
	<h3 style="text-align: center" id="list_name" >订单信息列表</h3>
	<div style="float: left;margin: 5px;">
		<form class="form-inline" onsubmit="return false">
			<div class="form-group">
				<label >&nbsp;&nbsp;&nbsp;&nbsp;订单查询 ：</label>
				<input type="text" name="condition" class="form-control" id="select_" placeholder="订单号、名称">
			</div>
			<button type="submit" id="search" class="btn btn-default" onclick="load_Order(1,$('#select_').val(),0)">搜索</button>
		</form>
	</div>

	<div style="float: right;margin: 5px;">
		<a class="btn btn-primary" href="#"id="Selected_all2" onclick="Selected_return_Order(1,null,0)">批量退货</a>
		<a class="btn btn-primary" href="javascript:void(0);" id="Selected_all" onclick="Selected_deliver_Order(1,null,0)">批量发货</a>
	</div>
	<form onsubmit="return false">
		<table id="table" border="1" class="table table-bordered table-hover" style=" width:86% !important;">
		</table>
	</form>

	<div>
		<nav aria-label="Page navigation">
			<ul class="pagination" id="pagination"></ul>
		</nav>
		<span style="color:#337ab7; font-size: 25px;margin-left: 5px;"id="_page"></span>
	</div>
</div>

<%--显示隐藏按钮--%>
<div class="show">
	<a title="隐藏" href="###" onclick="qwq();"><img src="${pageContext.request.contextPath}/img/sprite2.png"  alt="..." ></a>
</div>




</body>
</html>