package Servlet;

import JavaBean.administrator;
import Service.AdministratorService;
import Service.impl.AdministratorServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;
import java.util.Random;

@WebServlet("/admin/*")
public class AdministratorServlet extends BaseServlet {
    //声明UserService业务对象
    private AdministratorService service = new AdministratorServiceImpl();


    /**
     * 登录功能
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void LoginServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.设置编码
        request.setCharacterEncoding("utf-8");
        //2.获取数据
        Map<String, String[]> map = request.getParameterMap();
        //4.封装User对象
        administrator admin = new administrator();
        try {
            BeanUtils.populate(admin, map);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        //5.调用Service查询
        administrator loginUser = service.login(admin);
        //6.判断是否登录成功
        HttpSession session2 = request.getSession();
        if (admin.getUsername() == "" || admin.getUsername().length() <= 0) { //登录失败
            //提示信息
            session2.setAttribute("login_msg", "用户名不能为空！");
            //跳转登录页面
            response.sendRedirect("/login.jsp");

        } else if (admin.getPassword() == "" || admin.getPassword().length() <= 0) {
            //登录失败
            //提示信息
            session2.setAttribute("login_msg", "密码不能为空！");
            //跳转登录页面
            response.sendRedirect("/login.jsp");
        } else if (loginUser != null) {
            //登录成功
            //检查用户是否激活
            System.out.println("激活：" + loginUser.getStatus());
            if (loginUser.getStatus().equals("Y")) {
                //已经激活
                //将用户存入session
                HttpSession session = request.getSession();
                session.setAttribute("user", loginUser);
                session.setAttribute("username", loginUser.getUsername());
                request.setAttribute("user", loginUser);
                //跳转页面
                //  request.getRequestDispatcher(request.getContextPath() + "/index.jsp").forward(request, response);
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {//未激活
                session2.setAttribute("login_msg", "用户尚未激活，请前往邮箱激活！");
                //跳转登录页面
                response.sendRedirect("/login.jsp");

            }
        } else {
            //登录失败
            //提示信息
            session2.setAttribute("login_msg", "用户名或密码错误！");
            //跳转登录页面
            response.sendRedirect("/login.jsp");

        }

    }

    /**
     * 验证码功能
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */

    public void CheckCodeServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //服务器通知浏览器不要缓存
        response.setHeader("pragma", "no-cache");
        response.setHeader("cache-control", "no-cache");
        response.setHeader("expires", "0");

        //在内存中创建一个长80，宽30的图片，默认黑色背景
        //参数一：长
        //参数二：宽
        //参数三：颜色
        int width = 125;
        int height = 46;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        //获取画笔
        Graphics g = image.getGraphics();
        //设置画笔颜色
        g.setColor(Color.white);
        //填充图片
        g.fillRect(0, 0, width, height);

        //产生4个随机验证码，12Ey
        String checkCode = getCheckCode();
        //将验证码放入HttpSession中
        request.getSession().setAttribute("CHECKCODE_SERVER", checkCode);

        //设置画笔颜色为黄色
        g.setColor(new Color(66, 139, 202));
        //设置字体的小大
        g.setFont(new Font("黑体", Font.BOLD, 30));
        //向图片上写入验证码
        g.drawString(checkCode, 15, 25);

        //将内存中的图片输出到浏览器
        //参数一：图片对象
        //参数二：图片的格式，如PNG,JPG,GIF
        //参数三：图片输出到哪里去
        ImageIO.write(image, "PNG", response.getOutputStream());
    }

    /**
     * 产生4位随机字符串
     */
    private String getCheckCode() {
        String base = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        int size = base.length();
        Random r = new Random();
        StringBuffer sb = new StringBuffer();
        for (int i = 1; i <= 4; i++) {
            //产生0到size-1的随机值
            int index = r.nextInt(size);
            //在base字符串中获取下标为index的字符
            char c = base.charAt(index);
            //将c放入到StringBuffer中去
            sb.append(c);
        }
        return sb.toString();

    }

    /**
     * 注册时ajax访问数据库中的帐号是否存在
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void RegisterAjaxServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String registername = request.getParameter("registername");
        System.out.println("ajax-->" + registername);
        administrator admin = new administrator();
        admin = service.register(registername);
        PrintWriter pw = response.getWriter();
        System.out.println("ajax--->" + admin);
        if (admin == null) {
            pw.write("false");
        } else {
            pw.write("true");
        }

    }

    /**
     * 注册方法，邮箱激活
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void ActiveRegisterServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.获取激活码
        String code = request.getParameter("code");
        if (code != null) {
            //2.调用service完成激活
            boolean flag = service.active(code);

            //3.判断标记
            String msg = null;
            if (flag) {
                //激活成功
                msg = "激活成功，请<a href='login.jsp'>登录</a>";
            } else {
                //激活失败
                msg = "激活失败，请联系管理员!";
            }
            response.setContentType("text/html;charset=utf-8");
            response.getWriter().write(msg);
        }

    }

    /**
     * 注册功能
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void RegisterServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.设置编码
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //2.获取数据
        //2.1获取用户填写验证码
        String verifycode = request.getParameter("verifycode");

        //3.验证码校验
        HttpSession session = request.getSession();
        String checkcode_server = (String) session.getAttribute("CHECKCODE_SERVER");
        session.removeAttribute("CHECKCODE_SERVER");//确保验证码一次性
        if (!checkcode_server.equalsIgnoreCase(verifycode)) {
            //验证码不正确
            //提示信息
            //跳转登录页面
            response.getWriter()
                    .append("<script>alert('验证码错误！');window.location.href='" + request.getContextPath() + "/login.jsp'</script>");
        } else {
            Map<String, String[]> map = request.getParameterMap();
            //4.封装User对象
            administrator admin = new administrator();
            try {
                BeanUtils.populate(admin, map);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
            //5.调用Service查询
            int a = service.registerUser(admin);
            if (a != 0) {
                response.getWriter()
                        .append("<script>alert('注册成功！请前往邮箱进行验证');window.location.href='" + request.getContextPath() + "/login.jsp'</script>");
            } else {
                response.getWriter()
                        .append("<script>alert('注册失败！');window.location.href='" + request.getContextPath() + "/login.jsp'</script>");
            }

        }
    }

    /**
     * 修改管理员信息功能
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void Up_informationServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.设置编码
        request.setCharacterEncoding("utf-8");
        //2.获取数据
        Map<String, String[]> map = request.getParameterMap();
        //4.封装User对象
        administrator admin = new administrator();
        try {
            BeanUtils.populate(admin, map);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        String username = request.getParameter("username");
        System.out.println("username:" + username);
        ;
        //5.调用Service查询
        int a = service.update_information(admin);
        writeValue(a, response);

    }

    /**
     * 修改管理员密码功能
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void Up_passwordServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.设置编码
        request.setCharacterEncoding("utf-8");
        //2.获取数据
        String old_password = request.getParameter("old_password");
        String new_password = request.getParameter("new_password");
        String username = request.getParameter("username");

        administrator admin = new administrator();
        admin = service.findUserByUsername(username);

        int a = 0;
        a = service.update_password(admin, new_password, old_password);
        writeValue(a, response);

    }


    /**
     * 退出功能
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void ExitServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.销毁session
        request.getSession().invalidate();
        System.out.println("已退出帐号");

        //2.跳转登录页面
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    public void testRegisterServletdo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        System.out.println("进了测试");
}


}
