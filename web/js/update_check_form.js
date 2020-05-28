//定义一个全局变量：作来标记具体的是什么错误，如果这个变量 是0说明没有信息问题，可以注册

var b = "2";
var c = "3";
var d = "4";
var e= "5";
var g="7";
var h="8";

// 修改管理员信息校验
$(function () {


    $("#new_password").blur(function () {

        var len = $("#new_password").val();
        var reg_new_password=/^[0-9a-zA-Z]+$/;
        var message = "";
        var flag = false;
        if (len.length < 0 || len.length === 0) {
            b = "2";// 修改全局变量
            message = "密码为空！";
        }
        else if(!reg_new_password.test(len)){
            b = "2";// 修改全局变量
            message = "密码只能为数字和字母！";
        }
        else if (len.length < 6) {
            b = "2";// 修改全局变量
            message = "密码不能少于6位！";
        }
        else if (len.length >16) {
            b = "2";// 修改全局变量
            message = "密码不能多于16位！";
        }
        else {
            b = "0";// 修改全局变量
            flag = true;

        }
        if (flag) {
            $("#reg_sp6").text(message).css('color', '#0000ff');
        } else {
            $("#reg_sp6").text(message).css('color', '#f53808');
        }

    });

    $("#old_password").blur(function () {

        var len = $("#old_password").val();
        var reg_old_password=/^[0-9a-zA-Z]+$/;
        var message = "";
        var flag = false;
        if (len.length < 0 || len.length === 0) {
            b = "2";// 修改全局变量
            message = "密码为空！";
        }
        else if(!reg_old_password.test(len)){
            b = "2";// 修改全局变量
            message = "密码只能为数字和字母！";
        }
        else if (len.length < 6) {
            b = "2";// 修改全局变量
            message = "密码不能少于6位！";
        }
        else if (len.length >16) {
            b = "2";// 修改全局变量
            message = "密码不能多于16位！";
        }
        else {
            b = "0";// 修改全局变量
            flag = true;

        }
        if (flag) {
            $("#reg_sp66").text(message).css('color', '#0000ff');
        } else {
            $("#reg_sp66").text(message).css('color', '#f53808');
        }

    });
    /**
     * 3.判断两次密码是否一样
     */
    $("#new_password2").blur(function () {
        var p1 = $("#new_password").val();
        var p2 = $("#new_password2").val();
        var reg_new_password2=/^[0-9a-zA-Z]+$/;
        var message = "";
        var flag = false;
        if (p1 != p2) {
            c = "3";// 修改全局变量
            message = "两次密码不一样！";
        }
        else if(!reg_new_password2.test(p2)){
            b = "2";// 修改全局变量
            message = "密码只能为数字和字母！";
        }
        else if (p2.length == 0) {
            c = "3";// 修改全局变量
            message = "密码不能为空！";
        }
        else if (p2.length < 6) {
            c = "3";// 修改全局变量
            message = "密码不能少于6位！";
        }
        else if (p2.length >16) {
            c = "3";// 修改全局变量
            message = "密码不能多于16位！";
        }
        else {
            c = "0";// 修改全局变量
            flag = true;

        }
        if (flag) {
            $("#reg_sp7").text(message).css('color', '#0000ff');
        } else {
            $("#reg_sp7").text(message).css('color', '#f53808');
        }
    });

    $("#input_phone").blur(function check_phone() {
        var phone = $("#input_phone").val();
        var reg_phone = /^1[345678][0-9]{9}$/;
        var message = "";
        var flag = false;
        if(phone.length<=0){
            h= "7";// 修改全局变量
            message = "请输入手机号!"
        }else if (!reg_phone.test(phone)) {
            h= "7";// 修改全局变量
            message = "手机号格式错误!"
        } else {
            h = "0";// 修改全局变量
            flag = true;

        }
        if (flag) {
            $("#reg_sp8").text(message).css('color', '#0000ff');
        } else {
            $("#reg_sp8").text(message).css('color', '#f53808');
        }

    });

    $("#input_email").blur(function check_email() {
        var email = $("#input_email").val();
        var reg_email = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        var message = "";
        var flag = false;
        if (email.length <= 0 ) {
            g = "7";// 修改全局变量
            message = "请输入邮箱!";
            $("#input_email").css("border-bottom", "0.2px solid red");
        }
        else if(!reg_email.test(email)){
            g = "7";// 修改全局变量
            message = "邮箱格式错误!";
            $("#input_email").css("border-bottom", "0.2px solid red");
        }
        else {
            g= "0";// 修改全局变量
            flag = true;
            $("#input_email").css("border", "");

        }
        if (flag) {
            $("#reg_sp9").text(message).css('color', '#0000ff');
        } else {
            $("#reg_sp9").text(message).css('color', '#f53808');
        }

    });



})

function check_up_password(){
    if (b == 2||c==3) {
        alert("密码信息错误!请检查后重新输入!")
        return false;
    }
    else
        return true;
}
function check_up_information(){

    if (h == 7) {
        alert("邮箱信息错误!请检查后重新输入!")
        return false;
    }else
    if (g == 7) {
        alert("手机信息错误!请检查后重新输入!")
        return false;
    }else
        return true;
}