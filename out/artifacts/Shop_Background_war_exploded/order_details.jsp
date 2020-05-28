<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/4/10
  Time: 17:55
  To change this template use File | Settings | File Templates.
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/order_details.css">

    <title>商品详情</title>
</head>
<script>
    var aa = "0";
    var bb = "0";
$(function () {

    $("#up_name2").blur(function () {
        var name = $("#up_name").val();
        var message = "";
        // 完成正则匹配
        if (name.length <= 0) {
            aa = "1";
            $("#reg_spa1").text("输入姓名").css('color', '#f53808');
            $("#up_name").css("border", "1px solid red");
        } else if (name.length > 20) {
            aa = "1";
            $("#reg_spa1").text("姓名太长").css('color', '#f53808');
            $("#up_name").css("border", "1px solid red");
        }
        else if (name.length > 0) {
            aa = "0";
            $("#up_name").css("border", "");
            $("#reg_spa1").text(message).css('color', '#0000ff');
        }

    });

    $("#up_phone2").blur(function () {
        var up_phone2 = $("#up_phone2").val();
        var message = "";
        var reg_phone = /^1[345678][0-9]{9}$/;
        // 完成正则匹配
        if (up_phone2.length <= 0) {
            bb = "2";
            $("#reg_spb2").text("未输入").css('color', '#f53808');
            $("#up_phone2").css("border", "1px solid red");

        } else if (!reg_phone.test(up_phone2)) {
            bb = "2";// 修改全局变量
            $("#reg_spb2").text("手机号格式错误").css('color', '#f53808');
            $("#up_phone2").css("border", "1px solid red");
        }
        else if (up_phone2.length > 0) {
            bb = "0";
            $("#reg_spb2").text(message).css('color', '#0000ff');
            $("#up_phone2").css("border", "");
        }

    });

});
    check_order=function () {
        if (aa == 1||bb==2) {
            alert("格式有误!请检查后重新输入!")
            return false;
        }
        else
            return true;
    }
    update_Order=function () {
        if (check_order()) {
            $.get("Order/UpdateOrderServlet",
                {
                    orderid: "${orderid}",
                    name: $("#up_name2").val(),
                    phone: $("#up_phone2").val(),
                    address: $("#up_address2").val(),
                },
                function (a) {
                    if (a != 0) {
                        alert("修改成功！");
                        showAtRight('Order/DetailOrderServlet?orderid=${orderid}');
                    }
                    else
                        alert("修改失败，请联系客服！");
                })

            $(".close_modal").trigger("click");

        }
    }

    update_message=function () {
        $.get("Order/UpdateOrderMessageServlet",
            {
                orderid: "${orderid}",
               message: $("#up_message2").val(),
            },
            function (a) {
                if (a != 0) {
                    alert("修改成功！");
                    showAtRight('Order/DetailOrderServlet?orderid=${orderid}');
                }
                else
                    alert("修改失败，请联系客服！");
            })

        $(".close_modal").trigger("click");
    }

</script>
<body>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModa2" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true"  >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel" style="text-align:center;">
                    修改订单
                </h4>
            </div>
            <%--显示信息--%>
            <div class="modal-body" id="information">

                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">收件人姓名：</div>
                    <div class="col-md-3" style="text-align:left;">
                        <input type="text" name="name2" id="up_name2" value="${useraddress.name}" class="form-control" style="width: 100px;height: 22px;">
                    </div>
                    <div class="col-md-4"> <span id="reg_spa1"></span></div>
                </div>

                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">收件人电话：</div>
                    <div class="col-md-3" style="text-align:left;">
                        <input type="text" name="up_phone2" id="up_phone2" value="${useraddress.phone}"   class="form-control" style="height: 22px;">
                    </div>
                    <div class="col-md-4"> <span id="reg_spb2"></span></div>
                </div>

                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">收件人地址：</div>
                    <div class="col-md-8" style="text-align:left;">
                       <textarea rows="10" cols="30" class="form-control"value="${useraddress.address}"  id="up_address2" name="address2" style="width: 280px;height: 66px;" placeholder="100字以内">${useraddress.address}
                       </textarea>
                        <span id="reg_spc3"></span>
                    </div>

                </div>

            </div>
            <div class="modal-footer" style="text-align: center">
                <button type="button" class="btn btn-default close_modal" data-dismiss="modal" style="display: none">关闭</button>
                    <button type ="submit" class="btn btn-default"  id="up_information" onclick="update_Order();">提交修改</button>
            </div>

        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModa3" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel3" aria-hidden="true"  >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel3" style="text-align:center;">
                    修改备注
                </h4>
            </div>
            <%--显示信息--%>
            <div class="modal-body">
                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">订单编号：</div>
                    <div class="col-md-3" style="text-align:left;">
                      ${orderid}
                       </div>
                </div>


                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">收件人留言：</div>
                    <div class="col-md-8" style="text-align:left;">
                       <textarea rows="10" cols="30" class="form-control" id="up_message2" name="message" style="width: 280px;height: 66px;" placeholder="100字以内">${useraddress.message}
                       </textarea>
                    </div>
                </div>


            </div>
            <div class="modal-footer" style="text-align: center">
                <button type="button" class="btn btn-default close_modal" data-dismiss="modal" style="display: none">关闭</button>
                <button type ="submit" class="btn btn-default"onclick="update_message();">提交修改</button>
            </div>

        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<div class="row order_id_div">
    <div class="col-md-6">
         <h5>订单编号：<span class="order_id">${orderid}</span></h5>

    </div>
    <div class="col-md-6">
         <h5 style="float:right">总价：￥<span class="order_id">
             <fmt:formatNumber type="number" value="${allprice}" maxFractionDigits="2"/>
              </span>元</h5>
        <a id="open_modal" data-toggle="modal" data-target="#myModa2"style="position: absolute;top: -55px;right: 70px;font-size: 22px">修改订单</a>
        <a href="javascript:showAtRight('order_processing.jsp')" style="position: absolute;top: -55px;right: 15px;font-size: 22px">返回</a>
    </div>
</div>
<div class="row title_name">
    <h4>收件人信息 <a data-toggle="modal" data-target="#myModa3" style="float: right;margin-right:10px;font-size: 18px">修改备注留言</a></h4>
</div>
<div class="row user_info">
    <div class="col-md-3">
        <h4>收件人：  <span>${useraddress.name}</span></h4>
    </div>
    <div class="col-md-3">
        <h4>收件人电话：  <span>${useraddress.phone}</span></h4>
    </div>
    <div class="col-md-3">
        <h4>收件人留言：  <span id="span_message">${useraddress.message}</span></h4>
    </div>
    <div class="col-md-3">
        <h4>收件人地址：  <span>${useraddress.address}</span></h4>
    </div>
</div>

<div class="row title_name">
    <h4>产品信息</h4>
</div>




<div class="row goods_info">
    <%--1--%>
    <c:forEach items="${orderlist}" var="order">
    <div class="col-md-4" >
        <div class="row goods_div">
            <div class="col-md-6 goods_img_div">
                <img class="goods_img" src="${order.goods_img}" alt="加载中。。。">
            </div>
            <div class="col-md-5 goods_info_div">
                <a class="goods_title" href="javascript:showAtRight('details.jsp?type=${order.goods_type}&id=${order.goods_id}')">${order.goods_title}</a>
                <p>数量：${order.goods_number}</p>

                <p>价格: ￥ <span class="price">
                    <fmt:formatNumber type="number" value="${order.goods_price*order.goods_number}" maxFractionDigits="2"/>
                </span>元</p>
                <p>状态:&nbsp <span class="conditions">${order.goods_stock}</span></p>
            </div>
        </div>
    </div>
    </c:forEach>

</div>
</body>
</html>
