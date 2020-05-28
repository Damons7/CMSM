package Dao;

import JavaBean.Fruit;

import java.util.List;

public interface FruitDao {

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
    public List<Fruit> findFruitByPage(int start, int rows, String condition);

    /**
     * 下架商品 (将conditons状态变成0)
     * @return
     * @param id
     */
    public int pull_offFruit(int id,String now_time);

    /**
     * 上架商品
     * @return
     * @param fruit
     */
    public int AddFruit(Fruit fruit);

    /**
     * 商品详情
     * @return
     * @param id
     */
    public Fruit DetailsFruit(int id);


    /**
     * 更新商品信息
     * @return
     * @param fru
     */
    public int UpdateFruit(Fruit fru);

    /**
     * 根据id查询商品图片目录
     * @return
     * @param id
     */
    public String FruitImgsPath(int id);

    /**
     * 查询商品名称是否存在
     * @return
     * @param name
     */
    public Fruit FruitName(String name);

    /**
     * 根据商品名称存入图片
     * @return
     * @param path,name
     */
    public int FruitImgByName(String path,String name);
}
