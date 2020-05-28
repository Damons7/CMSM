package Servlet;

import JavaBean.PageBean;
import JavaBean.headman;
import Service.HeadmanService;
import Service.impl.HeadmanServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/Headman/*")
public class HeadmanServlet extends BaseServlet {
    private HeadmanService service = new HeadmanServiceImpl();

    /**
     * 查询团长功能
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void FindHeadmanByPageServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.设置编码
        request.setCharacterEncoding("utf-8");
        String currentPage = request.getParameter("currentPage");//当前页码
        String rows = request.getParameter("rows");//每页显示条数
        Map<String, String[]> condition = request.getParameterMap();
        if (currentPage == null || "".equals(currentPage)) {

            currentPage = "1";
        }


        if (rows == null || "".equals(rows)) {
            rows = "5";
        }
        headman _headman = new headman();
        PageBean<headman> pb = service.findHeadmanByPage(currentPage, rows, condition);
        System.out.println(pb);

        //3.将PageBean存入request
        request.setAttribute("pb", pb);
        request.setAttribute("condition", condition);//将查询条件存入request
        //4.转发到list.jsp
        request.getRequestDispatcher("/headmanList.jsp").forward(request, response);

    }

    /**
     * 批量移除团长功能
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void delSelectedServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        //1.获取所有id
        String[] ids = request.getParameterValues("uid");
        //2.调用service删除
        int a = service.delSelectedHeadman(ids);

        //3.跳转查询所有Servlet
        if (a != 0) {
            response.getWriter()
                    .append("<script>alert('删除成功！');window.location.href='" + request.getContextPath() + "/Headman/FindHeadmanByPageServlet'</script>");
        } else {
            response.getWriter()
                    .append("<script>alert('删除失败！');window.location.href='" + request.getContextPath() + "/Headman/FindHeadmanByPageServlet'</script>");
        }
    }

    /**
     * 单个移除团长功能
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void delHeadmanServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        //1.获取所有id
        String id = request.getParameter("uid");
        //2.调用service删除
        int a = service.deleteHeadman(id);
        //3.跳转查询所有Servlet
        if (a != 0) {
            response.getWriter()
                    .append("<script>alert('删除成功！');window.location.href='" + request.getContextPath() + "/Headman/FindHeadmanByPageServlet'</script>");
        } else {
            response.getWriter()
                    .append("<script>alert('删除失败！');window.location.href='" + request.getContextPath() + "/Headman/FindHeadmanByPageServlet'</script>");
        }
    }
}