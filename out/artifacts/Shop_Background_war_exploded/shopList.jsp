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

        Add_commodity=function () {
            //用户安全提示
          var a=$("#select_shop option:selected").val();
          if (check_commodity()) {
              if (confirm("确定上架该商品？")) {
                  //访问路径
                  if (a == "1") {
                      $.get("Fruit/AddFruitServlet",
                          {
                              name: $("#name").val(),
                              title: $("#title").val(),
                              numbers: $("#amount").val(),
                              price: $("#price").val(),
                              discount_price: $("#discount_price").val(),
                              cost: $("#cost").val(),
                              describes: $("#describes").val()
                          },
                          function (a) {
                              if (a != 0) {
                                  var newUrl = 'Fruit/FruitImgServlet?type=addimg&name='+$("#name").val();    //设置新提交地址
                                  $("#myform").attr('action',newUrl);    //通过jquery为action属性赋值
                                  $("#sumit_img").trigger("click");
                                  alert("上架成功！");
                                  load_commodity();
                                  load_fruit(1, null);
                              }
                              else
                                  alert("上架失败！");
                          })
                  }

                  else if (a == "2") {
                      $.get("Vegetables/AddVegetablesServlet",
                          {
                              name: $("#name").val(),
                              title: $("#title").val(),
                              amount: $("#amount").val(),
                              price: $("#price").val(),
                              discount_price: $("#discount_price").val(),
                              cost: $("#cost").val(),
                              describes: $("#describes").val()
                          },
                          function (a) {
                              if (a != 0) {
                                  var newUrl = 'Vegetables/VegetablesImgServlet?type=addimg&name='+$("#name").val();    //设置新提交地址
                                  $("#myform").attr('action',newUrl);    //通过jquery为action属性赋值
                                  $("#sumit_img").trigger("click");
                                  alert("上架成功！");
                                  load_commodity();
                                  load_Vegetables(1, null);
                              }
                              else
                                  alert("上架失败！");
                          })
                  }

                  else if (a == "3") {
                      $.get("Snacks/AddSnacksServlet",
                          {
                              name: $("#name").val(),
                              title: $("#title").val(),
                              amount: $("#amount").val(),
                              price: $("#price").val(),
                              discount_price: $("#discount_price").val(),
                              cost: $("#cost").val(),
                              describes: $("#describes").val()
                          },
                          function (a) {
                              if (a != 0) {
                                  var newUrl = 'Snacks/SnacksImgServlet?type=addimg&name='+$("#name").val();    //设置新提交地址
                                  $("#myform").attr('action',newUrl);    //通过jquery为action属性赋值
                                  $("#sumit_img").trigger("click");
                                  alert("上架成功！");
                                  load_commodity();
                                  load_Snacks(1, null);
                              }
                              else
                                  alert("上架失败！");
                          })
                  }

                  $(".close_modal").trigger("click");
              }
          }
        }

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

        //加载所有商品数量
        load_commodity=function () {
		    var all=0;
			//异步请求查询水果类数量
            $.get("Vegetables/FindVegetablesByPageServlet",{currentPage: 1,rows:5,condition:null}, function (pv) {
                var count = '&nbsp;蔬菜类(' + pv.totalCount + ')';
                $("#Vegetables").html(count);
                all=pv.totalCount+all;
            });
            //异步请求查询蔬菜类数量
            $.get("Fruit/FindFruitByPageServlet",{currentPage: 1,rows:5,condition:null}, function (pb) {
                var count = '&nbsp;水果类(' + pb.totalCount + ')';
                $("#fruit").html(count);
                all=pb.totalCount+all;
            });
            //异步请求查询蔬菜类数量
            $.get("Snacks/FindSnacksByPageServlet",{currentPage: 1,rows:5,condition:null}, function (ps) {
                var count = '&nbsp;零食类(' + ps.totalCount + ')';
                $("#Snacks").html(count);
                all=ps.totalCount+all;
                var ddd=all;
                var allcount = '&nbsp;全部商品(' +all+ ')';
                $("#allcommodity").html(allcount);
            });


        }
        //批量下架商品处理
        selectAll=function(obj){
            //获取下边的复选框
            $(".itemSelect").prop("checked",obj.checked);
        }

        //1.加载水果类商品
        load_fruit=function (currentPage,condition) {
            //更改列表名
            $("#list_name").html("水果信息列表");

            //更改搜索方法
            $("#search").removeAttr("onclick");
            $("#search").attr("onclick","load_fruit(1,$('#select_').val())");

            //更改批量下架id
            $("#Selected_all").removeAttr("onclick");
            $("#Selected_all").attr("onclick","Selected_fruit()");

            $.get("Fruit/FindFruitByPageServlet", {currentPage: currentPage,rows:5,condition:condition}, function (pb) {
                //解析pagebean数据，展示到页面上

                //1.分页工具条数据展示
                //1.1 展示总页码和总记录数
                var _page1='共'+pb.totalCount+'条记录，共'+pb.totalPage+'页';
                $("#_page").html(_page1);

                var lis = "";
                //计算上一页的页码
                var beforeNum =  pb.currentPage - 1;
                if(beforeNum <= 0){
                    beforeNum = 1;
                }

                if(pb.currentPage==1) {
                    var beforePage = '<li class="disabled"><a href="javascript:void(0)" aria-label="Previous">' +
                        '<span aria-hidden="true">&laquo;</span>' +
                        '</a></li>';
                }
                else{
                    var beforePage = '<li><a href="javascript:void(0)" onclick="load_fruit('+beforeNum+',\''+condition+'\')" aria-label="Previous">' +
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
                var end ; //  结束位置

                //1.要显示10个页码
                if(pb.totalPage < 10){
                    //总页码不够10页

                    begin = 1;
                    end = pb.totalPage;
                }else{
                    //总页码超过10页

                    begin = pb.currentPage - 5 ;
                    end = pb.currentPage + 4 ;

                    //2.如果前边不够5个，后边补齐10个
                    if(begin < 1){
                        begin = 1;
                        end = begin + 9;
                    }

                    //3.如果后边不足4个，前边补齐10个
                    if(end > pb.totalPage){
                        end = pb.totalPage;
                        begin = end - 9 ;
                    }
                }


                for (var i = begin; i <= end ; i++) {
                    var li;
                    //判断当前页码是否等于i
                    if(pb.currentPage == i){

                        li = '<li class="active"><a href="javascript:void(0)" onclick="load_fruit('+i+',\''+condition+'\')">'+i+'</a></li>';

                    }else{
                        //创建页码的li
                        li = '<li><a href="javascript:void(0)" onclick="load_fruit('+i+',\''+condition+'\')">'+i+'</a></li>';
                    }
                    //拼接字符串
                    lis += li;
                }

                var nextNum =  pb.currentPage +1;

                if(nextNum==pb.totalPage+1){
                    var nextPage = '<li class="disabled"><a href="javascript:void(0)" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';

                }else {
                    var nextPage = '<li><a href="javascript:void(0)"  onclick="load_fruit(' + nextNum + ',\''+condition+'\')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';
                }
                lis += nextPage;

                $("#pagination").html(lis);


                var route_lis = "";
                $(".trclass").remove();
                for (var i = 0; i < pb.list.length; i++) {
                    //获取{rid:1,rname:"xxx"}
                    var route2 = pb.list[i];
                    var li2 = '<tr class="trclass"><td><input type="checkbox" id="del" name="uid" class="itemSelect" value="'+route2.id+'">'+'</td>' +
                        '<td>' +route2.id+'</td>' +
                        '<td><img src="${pageContext.request.contextPath}'+route2.imgss[0]+'" alt="不见了"  width="58px" height="40px" onclick="javascript:window.open(this.src)"></td>' +
                        '<td>' +route2.name+'</td>' +
                        '<td>'+route2.price+'</td>' +
                        '<td>'+route2.discount_price+'</td>' +
                        '<td>'+(route2.numbers-route2.amount)+'</td>' +
                        '<td>'+route2.amount+'</td>' +
                        '<td>已上架</td>'+
                        '<td>'+route2.add_time+'</td>'+
                        '<td><a class="btn btn-default btn-sm" href="javascript:void(0)" onclick="showAtRight(\'details.jsp?type=1&id='+route2.id+'\')">商品详情</a>&nbsp;'+
                        '<a class="btn btn-default btn-sm" href="javascript:pull_off_fruit('+route2.id+','+pb.currentPage+',\''+condition+'\');">下架</a></td></tr>'
					;
                    $("#table").append(li2);
                }

            })
        }

        //确定批量下架水果类商品
        Selected_fruit=function () {
            if(confirm("您确定要下架选中商品？")) {
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
                    var uid_json=JSON.stringify(uids)
                    $.get("Fruit/pull_offSelectedFruitServlet", {uid:uid_json}, function (a1){
                        if(a1!=0){
                            alert("商品下架成功！");
                            load_commodity();
                            load_fruit(1,null);
                        }
                        else
                            alert("下架失败！");
                    })
                }
                else{
                    alert("未选中");
                }
            }
        }

        //下架商品
        pull_off_fruit=function(id,currentPage,condition){
            //用户安全提示
            if(confirm("您确定要下架该商品吗？")){
                //访问路径
                $.get("Fruit/pull_offFruitServlet", {id:id}, function (a){
                    if(a!=0){
                        alert("该商品已下架！");
                        load_commodity();
                        load_fruit(currentPage,condition);
                    }
                    else
                        alert("下架失败！");
                })}
        }

        //2.加载蔬菜类商品
        load_Vegetables=function (currentPage,condition) {
            //更改列表名
            $("#list_name").html("蔬菜信息列表");

            //更改搜索方法
            $("#search").removeAttr("onclick");
			$("#search").attr("onclick","load_Vegetables(1,$('#select_').val())");

            //更改批量下架id
            $("#Selected_all").removeAttr("onclick");
            $("#Selected_all").attr("onclick","Selected_Vegetables()");

            $.get("Vegetables/FindVegetablesByPageServlet", {currentPage: currentPage,rows:5,condition:condition}, function (pb) {
                //解析pagebean数据，展示到页面上

                //1.分页工具条数据展示
                //1.1 展示总页码和总记录数
                var _page1='共'+pb.totalCount+'条记录，共'+pb.totalPage+'页';
                $("#_page").html(_page1);

                var lis = "";
                //计算上一页的页码
                var beforeNum =  pb.currentPage - 1;
                if(beforeNum <= 0){
                    beforeNum = 1;
                }

                if(pb.currentPage==1) {
                    var beforePage = '<li class="disabled"><a href="javascript:void(0)" aria-label="Previous">' +
                        '<span aria-hidden="true">&laquo;</span>' +
                        '</a></li>';
                }
                else{
                    var beforePage = '<li><a href="javascript:void(0)" onclick="load_Vegetables('+beforeNum+',\''+condition+'\')" aria-label="Previous">' +
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
                var end ; //  结束位置


                //1.要显示10个页码
                if(pb.totalPage < 10){
                    //总页码不够10页

                    begin = 1;
                    end = pb.totalPage;
                }else{
                    //总页码超过10页

                    begin = pb.currentPage - 5 ;
                    end = pb.currentPage + 4 ;

                    //2.如果前边不够5个，后边补齐10个
                    if(begin < 1){
                        begin = 1;
                        end = begin + 9;
                    }

                    //3.如果后边不足4个，前边补齐10个
                    if(end > pb.totalPage){
                        end = pb.totalPage;
                        begin = end - 9 ;
                    }
                }


                for (var i = begin; i <= end ; i++) {
                    var li;
                    //判断当前页码是否等于i
                    if(pb.currentPage == i){

                        li = '<li class="active"><a href="javascript:void(0)" onclick="load_Vegetables('+i+',\''+condition+'\')">'+i+'</a></li>';

                    }else{
                        //创建页码的li
                        li = '<li><a href="javascript:void(0)" onclick="load_Vegetables('+i+',\''+condition+'\')">'+i+'</a></li>';
                    }
                    //拼接字符串
                    lis += li;
                }

                var nextNum =  pb.currentPage +1;

                if(nextNum==pb.totalPage+1){
                    var nextPage = '<li class="disabled"><a href="javascript:void(0)" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';

                }else {
                    var nextPage = '<li><a href="javascript:void(0)"  onclick="load_Vegetables(' + nextNum + ',\''+condition+'\')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';
                }
                lis += nextPage;

                $("#pagination").html(lis);

                $(".trclass").remove();
                for (var i = 0; i < pb.list.length; i++) {
                    var route2 = pb.list[i];
                    var li2 = '<tr class="trclass"><td><input type="checkbox" id="del" name="uid" class="itemSelect" value="'+route2.id+'">'+'</td>' +
                        '<td>' +route2.id+'</td>' +
                        '<td><img src="${pageContext.request.contextPath}'+route2.imgss[0]+'" alt="不见了"  width="58px" height="40px" onclick="javascript:window.open(this.src)"></td>' +
                        '<td>' +route2.name+'</td>' +
                        '<td>'+route2.price+'</td>' +
                        '<td>'+route2.discount_price+'</td>' +
                        '<td>'+(route2.numbers-route2.amount)+'</td>' +
                        '<td>'+route2.amount+'</td>' +
                        '<td>已上架</td>'+
                        '<td>'+route2.add_time+'</td>'+
                        '<td><a class="btn btn-default btn-sm" href="javascript:void(0)" onclick="showAtRight(\'details.jsp?type=2&id='+route2.id+'\')">商品详情</a>&nbsp;'+
                        '<a class="btn btn-default btn-sm" href="javascript:pull_off_Vegetables('+route2.id+','+pb.currentPage+',\''+condition+'\');">下架</a></td></tr>'
                    ;
                    $("#table").append(li2);
                }

            })
        }

        //确定批量下架蔬菜类商品
        Selected_Vegetables=function () {
            if(confirm("您确定要下架选中商品？")) {
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
                    var uid_json=JSON.stringify(uids)
                    $.get("Vegetables/pull_offSelectedVegetablesServlet", {uid:uid_json}, function (a1){
                        if(a1!=0){
                            alert("商品下架成功！");
                            load_commodity();
                            load_Vegetables(1,null);
                        }
                        else
                            alert("下架失败！");
                    })
                }
                else{
                    alert("未选中");
                }
            }
        }

        //下架商品
        pull_off_Vegetables=function(id,currentPage,condition){
            //用户安全提示
            if(confirm("您确定要下架该商品吗？")){
                //访问路径
                $.get("Vegetables/pull_offVegetablesServlet", {id:id}, function (a){
                    if(a!=0){
                        alert("该商品已下架！");
                        load_commodity();
                        load_Vegetables(currentPage,condition);
                    }
                    else
                        alert("下架失败！");
                })}
        }

        //3.加载零食类商品
        load_Snacks=function (currentPage,condition) {
            //更改列表名
            $("#list_name").html("零食信息列表");

            //更改搜索方法
            $("#search").removeAttr("onclick");
            $("#search").attr("onclick","load_Snacks(1,$('#select_').val())");

            //更改批量下架id
            $("#Selected_all").removeAttr("onclick");
            $("#Selected_all").attr("onclick","Selected_Snacks()");

            $.get("Snacks/FindSnacksByPageServlet", {currentPage: currentPage,rows:5,condition:condition}, function (pb) {
                //解析pagebean数据，展示到页面上

                //1.分页工具条数据展示
                //1.1 展示总页码和总记录数
                var _page1='共'+pb.totalCount+'条记录，共'+pb.totalPage+'页';
                $("#_page").html(_page1);

                var lis = "";
                //计算上一页的页码
                var beforeNum =  pb.currentPage - 1;
                if(beforeNum <= 0){
                    beforeNum = 1;
                }

                if(pb.currentPage==1) {
                    var beforePage = '<li class="disabled"><a href="javascript:void(0)" aria-label="Previous">' +
                        '<span aria-hidden="true">&laquo;</span>' +
                        '</a></li>';
                }
                else{
                    var beforePage = '<li><a href="javascript:void(0)" onclick="load_Snacks('+beforeNum+',\''+condition+'\')" aria-label="Previous">' +
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
                var end ; //  结束位置


                //1.要显示10个页码
                if(pb.totalPage < 10){
                    //总页码不够10页

                    begin = 1;
                    end = pb.totalPage;
                }else{
                    //总页码超过10页

                    begin = pb.currentPage - 5 ;
                    end = pb.currentPage + 4 ;

                    //2.如果前边不够5个，后边补齐10个
                    if(begin < 1){
                        begin = 1;
                        end = begin + 9;
                    }

                    //3.如果后边不足4个，前边补齐10个
                    if(end > pb.totalPage){
                        end = pb.totalPage;
                        begin = end - 9 ;
                    }
                }


                for (var i = begin; i <= end ; i++) {
                    var li;
                    //判断当前页码是否等于i
                    if(pb.currentPage == i){

                        li = '<li class="active"><a href="javascript:void(0)" onclick="load_Snacks('+i+',\''+condition+'\')">'+i+'</a></li>';

                    }else{
                        //创建页码的li
                        li = '<li><a href="javascript:void(0)" onclick="load_Snacks('+i+',\''+condition+'\')">'+i+'</a></li>';
                    }
                    //拼接字符串
                    lis += li;
                }

                var nextNum =  pb.currentPage +1;

                if(nextNum==pb.totalPage+1){
                    var nextPage = '<li class="disabled"><a href="javascript:void(0)" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';

                }else {
                    var nextPage = '<li><a href="javascript:void(0)"  onclick="load_Snacks(' + nextNum + ',\''+condition+'\')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';
                }
                lis += nextPage;

                $("#pagination").html(lis);

                $(".trclass").remove();
                for (var i = 0; i < pb.list.length; i++) {
                    //获取{rid:1,rname:"xxx"}
                    var route2 = pb.list[i];

                    var li2 = '<tr class="trclass"><td><input type="checkbox" id="del" name="uid" class="itemSelect" value="'+route2.id+'">'+'</td>' +
                        '<td>' +route2.id+'</td>' +
                        '<td><img src="${pageContext.request.contextPath}'+route2.imgss[0]+'" alt="不见了"  width="58px" height="40px" onclick="javascript:window.open(this.src)"></td>' +
                        '<td>' +route2.name+'</td>' +
                        '<td>'+route2.price+'</td>' +
                        '<td>'+route2.discount_price+'</td>' +
                        '<td>'+(route2.numbers-route2.amount)+'</td>' +
                        '<td>'+route2.amount+'</td>' +
                        '<td>已上架</td>'+
                        '<td>'+route2.add_time+'</td>'+
                        '<td><a class="btn btn-default btn-sm" href="javascript:void(0)" onclick="showAtRight(\'details.jsp?type=3&id='+route2.id+'\')">商品详情</a>&nbsp;'+
                        '<a class="btn btn-default btn-sm" href="javascript:pull_off_Snacks('+route2.id+','+pb.currentPage+',\''+condition+'\');">下架</a></td></tr>'
                    ;
                    $("#table").append(li2);
                }

            })
        }

        //确定批量下架蔬菜类商品
        Selected_Snacks=function () {
            if(confirm("您确定要下架选中商品？")) {
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
                    var uid_json=JSON.stringify(uids)
                    $.get("Snacks/pull_offSelectedSnacksServlet", {uid:uid_json}, function (a1){
                        if(a1!=0){
                            alert("商品下架成功！");
                            load_commodity();
                            load_Snacks(1,null);
                        }
                        else
                            alert("下架失败！");
                    })
                }
                else{
                    alert("未选中");
                }
            }
        }

        //下架商品
        pull_off_Snacks=function(id,currentPage,condition)
		{
            //用户安全提示
            if(confirm("您确定要下架该商品吗？")){
                //访问路径
                $.get("Snacks/pull_offSnacksServlet", {id:id}, function (a){
                    if(a!=0){
                        alert("该商品已下架！");
                        load_commodity();
                        load_Vegetables(currentPage,condition);
                    }
                    else
                        alert("下架失败！");
                })}
        }

        $(function () {
            //加载商品数量
            load_commodity();

            //加载商品类
            load_fruit(1,null);

        });
	</script>

</head>
<body>
<jsp:include page="addShop.jsp"></jsp:include>
<%--左侧小菜单--%>
<div class="xiaocaidan">
	<div class="shop">
		<ul>
			<li class="fa fa-user lis">&nbsp;商品分类</li>
			<li class="fa fa-user lis"><a href="JavaScript:void(0);" id="allcommodity"></a></li>
			<li class="fa fa-user lis"><a href="JavaScript:load_fruit(1,null);" id="fruit"></a></li>
			<li class="fa fa-user lis"><a href="JavaScript:load_Vegetables(1,null);" id="Vegetables"></a></li>
			<li class="fa fa-user lis"><a href="JavaScript:load_Snacks(1,null);" id="Snacks"></a></li>
		</ul>
	</div>
</div>

	<%--右侧数据列表--%>
	<div class="container">
		<h3 style="text-align: center" id="list_name" >商品信息列表</h3>
		<div style="float: left;">
			<form class="form-inline" onsubmit="return false">
				<div class="form-group">
					<label >&nbsp;&nbsp;&nbsp;&nbsp;商品名称 ：</label>
					<input type="text" name="condition" class="form-control" id="select_" placeholder="名称、编号">
				</div>
					<button type="submit" id="search" class="btn btn-default" onclick="load_fruit(1,$('#select_').val())">搜索</button>
				</form>
		</div>

			<div style="float: right;margin: 5px;">
				<a class="btn btn-primary" href="#" onclick="aa1();">商品上架</a>
				<a class="btn btn-primary" href="javascript:void(0);" id="Selected_all" onclick="Selected_fruit()">批量下架</a>
			</div>
			<form onsubmit="return false">
				<table id="table" border="1" class="table table-bordered table-hover" style=" width:86% !important;">
					<tr class="success">
						<th><input type="checkbox" id="firstCb" onclick="selectAll(this)"></th>
						<th>编号</th>
						<th>图片</th>
						<th>名称</th>
						<th>价格</th>
						<th>成本</th>
						<th>销量</th>
						<th>剩余库存</th>
						<th>状态</th>
						<th>上架时间</th>
						<th>操作</th>
					</tr>

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