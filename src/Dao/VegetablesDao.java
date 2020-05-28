package Dao;

import JavaBean.Vegetables;

import java.util.List;

public interface VegetablesDao {

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
    public List<Vegetables> findVegetablesByPage(int start, int rows, String condition);

    /**
     * 下架商品 (将conditons状态变成0)
     * @return
     * @param id
     */
    public int pull_offVegetables(int id,String now_time);

    /**
     * 上架商品
     * @return
     * @param veg
     */
    public int AddVegetables(Vegetables veg);

    /**
     * 商品详情
     * @return
     * @param id
     */
    public Vegetables DetailsVegetables(int id);

    /**
     * 商品详情
     * @return
     * @param veg
     */
    public int UpdateVegetables(Vegetables veg);

    /**
     * 查询商品名称是否存在
     * @return
     * @param name
     */
    public Vegetables VegetablesName(String name);

    /**
     * 根据商品名称存入图片
     * @return
     * @param path,name
     */
    public int VegetablesImgByName(String path,String name);
}
