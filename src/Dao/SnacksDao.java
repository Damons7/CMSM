package Dao;

import JavaBean.Snacks;

import java.util.List;

public interface SnacksDao {

    /**
     * 查询总记录数
     * @param condition
     * @return int
     */
    public int findTotalCount(String condition);

    /**
     * 分页查询每页记录
     * @param start
     * @param rows
     * @return List
     */
    public List<Snacks> findSnacksByPage(int start, int rows, String condition);

    /**
     * 下架商品 (将conditons状态变成0)
     * @return
     * @param id
     */
    public int pull_offSnacks(int id,String now_time);

    /**
     * 上架商品
     * @return
     * @param snack
     */
    public int AddSnacks(Snacks snack);

    /**
     * 商品详情
     * @return
     * @param id
     */
    public Snacks DetailsSnacks(int id);

    /**
     * 商品详情
     * @return
     * @param sna
     */
    public int UpdateSnacks(Snacks sna);

    /**
     * 查询商品名称是否存在
     * @return
     * @param name
     */
    public Snacks SnacksName(String name);

    /**
     * 根据商品名称存入图片
     * @return
     * @param path,name
     */
    public int SnacksImgByName(String path,String name);
}
