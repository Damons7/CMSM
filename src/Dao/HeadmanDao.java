package Dao;

import JavaBean.headman;

import java.util.List;
import java.util.Map;

public interface HeadmanDao {
    /**
     * 分页查询每页记录
     * @param start
     * @param rows
     * @param condition
     * @return
     */
    public List<headman> findByPage(int start, int rows, Map<String, String[]> condition);

    /**
     * 查询总记录数
     * @return
     * @param condition
     */
    public int findTotalCount(Map<String, String[]> condition);

    /**
     * 删除记录
     * @return
     * @param id
     */
    public int deleteHeadman(int id);
}
