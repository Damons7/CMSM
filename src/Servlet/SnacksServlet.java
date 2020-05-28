package Servlet;

import JavaBean.PageBean;
import JavaBean.Snacks;
import Service.SnacksService;
import Service.impl.SnacksServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

@WebServlet("/Snacks/*")
public class SnacksServlet extends BaseServlet {
    private SnacksService service = new SnacksServiceImpl();

    /**
     * 查询用户功能
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void FindSnacksByPageServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        PageBean<Snacks> ps = service.findSnacksByPage(currentPage,rows,condition);

        System.out.println(ps);

        writeValue(ps,response);
    }

    /**
     * 下架单个商品
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void pull_offSnacksServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //1.获取所有id
        String id = request.getParameter("id");
        System.out.println("id="+id);
        //2.调用service删除
        int a =  service.pull_offSnacks(id);
        //3.跳转查询所有Servlet
        writeValue(a,response);

    }

    /**
     * 批量下架商品
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void pull_offSelectedSnacksServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        //1.获取所有id
        String idd = request.getParameter("uid");
        //2.调用service删除
        ObjectMapper mapper = new ObjectMapper();
        String []ids=mapper.readValue(idd,String[].class);
        int a1 =  service.pull_offSelectedSnacks(ids);
        writeValue(a1,response);
    }

    /**
     * 上架商品
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void AddSnacksServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.设置编码
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //2.获取数据

        Map<String, String[]> map = request.getParameterMap();
        Snacks snack=new Snacks();
        try {
            BeanUtils.populate(snack,map);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }

        int a=service.AddSnacks(snack);
        writeValue(a,response);


    }

    /**
     * 商品详情
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void DetailsSnacksServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.设置编码
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //2.获取数据
        String id = request.getParameter("id");

        Snacks sna=new Snacks();

        sna=service.DetailsSnacks(id);
        writeValue(sna,response);


    }

    /**
     * 更新商品信息
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void UpdateSnacksServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //1.设置编码
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //2.获取数据
        Map<String, String[]> map = request.getParameterMap();
        Snacks sna=new Snacks();
        try {
            BeanUtils.populate(sna,map);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        String del_imgs1 = request.getParameter("del_imgs");
        ObjectMapper mapper = new ObjectMapper();
        String []del_imgs=mapper.readValue(del_imgs1,String[].class);
        int a=service.UpdateSnacks(sna,del_imgs);
        writeValue(a,response);
    }

    /**
     * 查询商品名称
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void SnacksImgServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        String name1 = request.getParameter("name");
        String type = request.getParameter("type");
        String snacksname = new String(name1.getBytes("ISO-8859-1"), "UTF-8");
        int a = 0;
        //判断表单是否设置了上传属性
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (isMultipart) {
            //产生关键对象upload,用来取数据
            FileItemFactory factory = new DiskFileItemFactory(); // 实例化一个硬盘文件工厂,用来配置上传组件ServletFileUpload
            ServletFileUpload upload = new ServletFileUpload(factory); // 用以上工厂实例化上传组件
            try {
                //把request中的数据转换成FileItem的集合
                List<FileItem> items = null;
                items = upload.parseRequest(request);
                System.out.println("item:"+items);
                if (items.size()!=0) {
                    if (type.equals("updateimg"))
                        a = service.SnacksUpdateImg(items, snacksname);
                    else
                        a = service.SnacksImg(items, snacksname);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (a != 1) {
            response.getWriter().append("<script>alert('图片上传失败！');</script>");
        }


    }

}
