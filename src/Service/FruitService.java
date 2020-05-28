package Service;

import JavaBean.Fruit;
import JavaBean.PageBean;
import org.apache.commons.fileupload.FileItem;

import java.util.List;

public interface FruitService {
    /**
     * 分页条件查询
     * @param _currentPage
     * @param _rows
     * @return
     */
    public PageBean<Fruit> findFruitByPage(String _currentPage, String _rows, String condition);

    /**
     * 批量下架商品
     * @param ids
     */
    public int pull_offSelectedFruit(String[] ids);

    /**
     * 单个下架商品
     * @param id
     */
    public int pull_offFruit(String id);

    /**
     * 上架商品
     * @param fruit
     */
    public int AddFruit(Fruit fruit);

    /**
     * 商品详情
     * @param id
     */
    public Fruit DetailsFruit(String id);

    /**
     * 更新商品信息
     * @param fru
     */
    public int UpdateFruit(Fruit  fru ,String []del_imgs);

    /**
     * 查询商品名称信息
     * @param name
     */
    public Fruit FruitName(String name);

    /**
     * 上传商品图片
     * @param items,fruitname,type
     */
    public int FruitImg(List<FileItem> items,String fruitname);

    /**
     * 更新商品图片
     * @param items,fruitname,type
     */
    public int FruitUpdateImg(List<FileItem> items,String updatepath );

}
