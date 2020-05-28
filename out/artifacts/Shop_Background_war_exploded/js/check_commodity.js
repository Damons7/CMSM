//定义一个全局变量：作来标记具体的是什么错误，如果这个变量 是0说明没有信息问题，可以注册
var a = "1";
var b = "2";
var c= "3";
var d = "4";


$(function () {
    $("#name").blur(function () {
        alert("lail");
        var name = $("#name").val();
        var message = "";
        var flag = false;
        // 完成正则匹配
        if (name.length<= 0) {
            a = "1";
            message = "请输入商品名称！";
            $("#name").css("border","1px solid red");
        }
        else if (name.length > 0) {
            a= "0";
            flag = true;
            $("#name").css("border", "");
        }
        if(flag) {
            // 判断商品名称是否存在
            $.get("Fruit/AddFruitServlet", {name: name}, function (data, suss) {
                if (data == "true") {
                    a = "1";
                    flag = false;
                    message = "该商品已上架！";
                    $("#name").css("border", "1px solid red");
                } else {
                    flag = true;
                    $("#name").css("border", "");
                    a = "0";
                }
            });
        }

        if (flag) {
            $("#reg_sp1").text("✔").css('color', '#0000ff');

        } else {
            $("#reg_sp1").text(message).css('color', '#f53808');
        }

    });


    $("#price").blur(function () {

        var price = $("#price").val();
        var message = "";
        var flag = false;
        var reg_price =/^\d{0,8}\.{0,1}(\d{1,2})?$/;
        // 完成正则匹配
        if (price.length<= 0) {
            a = "1";
            message = "请输入商品价格！";
            $("#price").css("border","1px solid red");

        }
        else   if (!reg_price.test(price)) {
            a= "1";// 修改全局变量
            message = "价格格式有误！";
            $("#price").css("border", "1px solid red");
        }
        else if (price.length > 0) {
            a = "0";
            flag = true;
            $("#price").css("border", "");
        }
        if (flag) {
            $("#reg_sp1").text(message).css('color', '#0000ff');

        } else {
            $("#reg_sp1").text(message).css('color', '#f53808');
        }

    });

});


function check_commodity() {
    if (a == 1) {
        alert("商品价格有误!请检查后重新输入!")
        return false;
    }

    if (b == 2) {
        alert("商品数量有误!请检查后重新输入!")
        return false;
    }
}