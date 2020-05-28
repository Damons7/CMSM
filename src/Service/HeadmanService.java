package Service;

import JavaBean.PageBean;
import JavaBean.headman;
import java.util.Map;

public interface HeadmanService {
    /**
     * 分页条件查询
     * @param currentPage
     * @param rows
     * @param condition
     * @return
     */
    PageBean<headman> findHeadmanByPage(String currentPage, String rows, Map<String, String[]> condition);

    /**
     * 批量移除团长
     * @param ids
     */
    public int delSelectedHeadman(String[] ids);

    /**
     * 单个移除团长
     * @param id
     */
    public int deleteHeadman(String id);
}
