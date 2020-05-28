package Servlet;

import JavaBean.Fruit;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;

@WebServlet("/general/*")
public class general_shopServlet extends BaseServlet {
    /**
     * 查询用户功能
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void AddcommodityServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.设置编码
        request.setCharacterEncoding("utf-8");
        //2.获取数据
        String type = request.getParameter("type");

        if(type.equals("1")){
            Map<String, String[]> map = request.getParameterMap();
            Fruit fru=new Fruit();
            try {
                BeanUtils.populate(fru,map);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }

        }

    }
    }
