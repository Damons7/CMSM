package Servlet;

import JavaBean.PageBean;
import JavaBean.user;
import Service.UserService;
import Service.impl.UserServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/User/*")
public class UserServlet extends BaseServlet {
    private UserService service = new UserServiceImpl();

    /**
     * 查询用户功能
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void FindUserByPageServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //1.获取参数
        String currentPage = request.getParameter("currentPage");//当前页码
        String rows = request.getParameter("rows");//每页显示条数

        if(currentPage == null || "".equals(currentPage)){

            currentPage = "1";
        }


        if(rows == null || "".equals(rows)){
            rows = "5";
        }

       //获取条件查询参数
        String condition="";
        try{
            String condition1 = request.getParameter("condition");
            if(condition1==null||condition1.equals("null")||condition1.length()<=0){
                condition="";
            }else
                condition = new String(condition1.getBytes("ISO-8859-1"), "UTF-8");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("condition="+condition);
        System.out.println("currentPage="+currentPage);
        System.out.println("rows="+rows);
        //2.调用service查询
        PageBean<user> pb = service.findUserByPage(currentPage,rows,condition);

        System.out.println(pb);

        //3.将PageBean存入request
//        request.setAttribute("pb",pb);
//        request.setAttribute("condition",condition);//将查询条件存入request
//        //4.转发到list.jsp
//        request.getRequestDispatcher("/userList.jsp").forward(request,response);
          writeValue(pb,response);
    }

    /**
     * 批量移除用户功能
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void delSelectedServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        //1.获取所有id
        String idd = request.getParameter("uid");
        //2.调用service删除
        System.out.println("数组"+idd);
        ObjectMapper mapper = new ObjectMapper();
        String []ids=mapper.readValue(idd,String[].class);
        int a1 =  service.delSelectedUser(ids);
        writeValue(a1,response);
        //3.跳转查询所有Servlet
//        if (a != 0) {
//            response.sendRedirect(request.getContextPath()+"/User/FindUserByPageServlet");
//             } else {
//            response.getWriter()
//                    .append("<script>alert('删除失败！');window.location.href='"+request.getContextPath()+  "/User/FindUserByPageServlet'</script>");
//        }
    }

    /**
     * 单个移除用户功能
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void delUserServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //1.获取所有id
        String id = request.getParameter("id");
        System.out.println("id="+id);
        //2.调用service删除
        int a =  service.deleteUser(id);
        //3.跳转查询所有Servlet
        writeValue(a,response);
    }

    }
