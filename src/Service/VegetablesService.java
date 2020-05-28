package Service;

import JavaBean.Vegetables;
import JavaBean.PageBean;
import org.apache.commons.fileupload.FileItem;

import java.util.List;

public interface VegetablesService {
    /**
     * 分页条件查询
     * @param _currentPage
     * @param _rows
     * @return
     */
    public PageBean<Vegetables> findVegetablesByPage(String _currentPage, String _rows, String condition);

    /**
     * 批量下架商品
     * @param ids
     */
    public int pull_offSelectedVegetables(String[] ids);

    /**
     * 单个下架商品
     * @param id
     */
    public int pull_offVegetables(String id);

    /**
     * 上架商品
     * @param veg
     */
    public int AddVegetables(Vegetables veg);

    /**
     * 商品详情
     * @param id
     */
    public Vegetables DetailsVegetables(String id);

    /**
     * 更新商品信息
     * @param veg,del_imgs
     */
    public int UpdateVegetables(Vegetables  veg,String []del_imgs);


    /**
     * 上传商品图片
     * @param items,fruitname,type
     */
    public int VegetablesImg(List<FileItem> items, String vegetablesname);

    /**
     * 更新商品图片
     * @param items,fruitname,type
     */
    public int VegetablesUpdateImg(List<FileItem> items,String updatepath );
}
