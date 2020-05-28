package Service;

import JavaBean.Snacks;
import JavaBean.PageBean;
import org.apache.commons.fileupload.FileItem;

import java.util.List;

public interface SnacksService {
    /**
     * 分页条件查询
     * @param _currentPage
     * @param _rows
     * @return
     */
    public PageBean<Snacks> findSnacksByPage(String _currentPage, String _rows, String condition);

    /**
     * 批量下架商品
     * @param ids
     */
    public int pull_offSelectedSnacks(String[] ids);

    /**
     * 单个下架商品
     * @param id
     */
    public int pull_offSnacks(String id);

    /**
     * 上架商品
     * @param snack
     */
    public int AddSnacks(Snacks snack);

    /**
     * 商品详情
     * @param id
     */
    public Snacks DetailsSnacks(String id);

    /**
     * 更新商品信息
     * @param sna
     */
    public int UpdateSnacks(Snacks  sna,String []del_imgs);

    /**
     * 上传商品图片
     * @param items,snackstname,type
     */
    public int SnacksImg(List<FileItem> items, String snackstname);

    /**
     * 更新商品图片
     * @param items,snackstname,type
     */
    public int SnacksUpdateImg(List<FileItem> items,String updatepath );
}
