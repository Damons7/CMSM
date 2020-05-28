//定义一个全局变量：作来标记具体的是什么错误，如果这个变量 是0说明没有信息问题，可以注册
var a = "1";
var a2= "1";
var b = "2";
var c = "3";
var d = "4";
var e= "5";
var g="7";
var h="8";
$(function() {
    // 用户名正则
    function check_name() {
        // 定义一个变量，用来存放输入框中的值 ：可以试试这个：$("#username").val(),
        var register = jQuery("#registername").val();
        // 定义一个变量，判断手机的正则
        //var reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        var message = "";
        var flag = false;
        // 完成正则匹配
        if (register.length < 0 || register.length === 0) {
            a = "1";// 修改全局变量
            message = "帐号不能为空！";
            $("#registername").css("border-bottom", "0.2px solid red");
        } else if (register.length > 0) {
            a = "0";
            flag = true;
            $("#registername").css("border", "");

        }

        if (flag) {
            $("#reg_sp1").text(message).css('color', '#0000ff');
            // 判断是否可以正常注册
            //json数据：key:value,$("#username").val():用户名输入框的内容
            var json = {
                "registername": $("#registername").val()
            };
            $.get("http://localhost:8080/admin/RegisterAjaxServlet", json, function (data, suss) {
                if (data == "true") {
                    a = "1";
                    $("#reg_sp1").text("帐号已存在").css('color', '#f53808');
                } else {
                    $("#reg_sp1").text("✔").css('color', '#0000ff');
                    a = "0";
                }
            });
        } else {
            $("#reg_sp1").text(message).css('color', '#f53808');
        }

    }

    $("#registername").blur(function () {
        check_name();

    });

    $(function () {
        $(document).keydown(function (event) {
            if (event.keyCode == 13) {
                check_name();
            }
        });

        // 登录帐号正则
        $("#username").blur(function () {
            // 定义一个变量，用来存放输入框中的值 ：可以试试这个：$("#username").val(),
            var username = jQuery("#username").val();
            // 定义一个变量，判断手机的正则
            //var reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
            var message = "";
            var flag = false;
            var reg_username = /^[0-9a-zA-Z]*$/g;
            // 完成正则匹配
            if (!reg_username.test(username)) {
                a2 = "1";// 修改全局变量
                message = "帐号只能为数字或字母！";
                $("#usernamename").css("border-bottom", "0.2px solid red");
            } else if (username.length > 0) {
                a2 = "0";
                flag = true;
                $("#usernamename").css("border", "");

            }

            if (flag) {
                $("#reg_sp1").text(message).css('color', '#0000ff');

            } else {
                $("#reg_sp1").text(message).css('color', '#f53808');
            }

        });

        /**
         * 2.密码不能少于6位数
         */

        $("#password").blur(function () {
            var len = $("#password").val();
            var reg_password=/^[0-9a-zA-Z]+$/;
            var message = "";
            var flag = false;
            if (len.length < 0 || len.length === 0) {
                b = "2";// 修改全局变量
                message = "密码为空！";
                $("#password").css("border-bottom", "0.2px solid red");
            }
            else if(!reg_password.test(len)) {
                b = "2";// 修改全局变量
                message = "密码只能是数字和字母！";
                $("#password").css("border-bottom", "0.2px solid red");
            }
            else if (len.length < 6) {
                b = "2";// 修改全局变量
                message = "密码不能少于6位！";
                $("#password").css("border-bottom", "0.2px solid red");
            }
            else if (len.length > 16) {
                b = "2";// 修改全局变量
                message = "密码不能大于16位！";
                $("#password").css("border-bottom", "0.2px solid red");
            }
            else {
                b = "0";// 修改全局变量
                flag = true;
                $("#password").css("border", "");
            }
            if (flag) {
                $("#reg_sp2").text(message).css('color', '#0000ff');
            } else {
                $("#reg_sp2").text(message).css('color', '#f53808');
            }

        });


        $("#email").blur(function () {
            var email = $("#email").val();
            var message = "";
            var flag = false;
            if (email.length < 0 || email.length === 0) {
                d = "4";// 修改全局变量
                message = "请输入邮箱!";
                $("#email").css("border-bottom", "0.2px solid red");
            } else {
                d = "0";// 修改全局变量
                flag = true;
                $("#email").css("border", "");

            }
            if (flag) {
                $("#reg_sp5").text(message).css('color', '#0000ff');
            } else {
                $("#reg_sp5").text(message).css('color', '#f53808');
            }

        });


        $("#verifycode").blur(function () {
            var verifycode = $("#verifycode").val();
            var message = "";
            var flag = false;
            if (verifycode.length < 0 || verifycode.length === 0) {
                e = "5";// 修改全局变量
                message = "验证码为空!";
                $("#verifycode").css("border-bottom", "0.2px solid red");
            } else {
                e = "0";// 修改全局变量
                flag = true;
                $("#verifycode").css("border", "");

            }
            if (flag) {
                $("#reg_sp4").text(message).css('color', '#0000ff');
            } else {
                $("#reg_sp4").text(message).css('color', '#f53808');
            }

        });


        $("#phone").blur(function () {
            var phone = $("#phone").val();
            var reg_phone = /^1[345678][0-9]{9}$/;
            var message = "";
            var flag = false;
            if (!reg_phone.test(phone)) {
                d = "4";// 修改全局变量
                message = "手机号格式错误!"
            } else {
                d = "0";// 修改全局变量
                flag = true;

            }
            if (flag) {
                $("#reg_sp8").text(message).css('color', '#0000ff');
            } else {
                $("#reg_sp8").text(message).css('color', '#f53808');
            }

        });


    });


    /**
     * 编写一个方法 ：判断所有的输入框内容是否合法
     *
     * @returns
     */
    function check() {
        if (a == 1) {
            alert("用户信息有误!请检查后重新输入!")
            return false;
        }
        // if (a2 == 1) {
        //     alert("用户信息有误!请检查后重新输入!")
        //     return false;
        // }
        if (b == 2) {
            alert("密码信息有误!请检查后重新输入!")
            return false;
        }
        if (d == 4) {
            alert("邮箱输入有误!请检查后重新输入!")
            return false;
        }
        if (e == 5) {
            alert("验证码为空!")
            return false;
        }


    }
})

// 修改管理员信息校验
$(function () {

    $("#new_password").blur(function () {

        var len = $("#new_password").val();
        var reg_new_password = /^[0-9a-zA-Z]+$/;
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
        var message = "";
        var flag = false;
        if (p1 != p2) {
            c = "3";// 修改全局变量
            message = "两次密码不一样！";
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

    $("#input_phone").blur(function () {
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

    $("#input_email").blur(function () {
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
    }else if (g == 7) {
        alert("手机信息错误!请检查后重新输入!")
        return false;
    }else
        return true;
}