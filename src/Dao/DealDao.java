package Dao;

import JavaBean.Deal;
import JavaBean.goodsRank;
import JavaBean.userDetail;

import java.util.List;

public interface DealDao {
    /**
     * 查询水果数量
     * @return String[]
     */
    public int fruitAmount();

    /**
     * 查询零食数量
     * @return String[]
     */
    public int snacksAmount();

    /**
     * 查询蔬菜数量
     * @return String[]
     */
    public int vegetablesAmount();

    /**
     * 查询订单状态各数量
     * @return Deal
     */
    public Deal orderAmount();

    /**
     * 查询订单月销量
     * @return Deal
     */
    public Deal orderMonth();

    /**
     * 查询订单季度销量
     * @return Deal
     */
    public Deal orderQuarter();


    /**
     * 查询交易交易金额
     * @return int
     *
     */
    public int transactionAmount();

    /**
     * 查询交退款金额
     * @return int
     *
     */
    public int refundAmount();

    /**
     * 查询订单数量、交易成功量、交易失败量
     * @return Deal
     *
     */
    public Deal orderNumbers();

    /**
     * 查询会员人数、男女比例
     * @return userDetail
     *
     */
    public userDetail userNumbers();

    /**
     * 查询团长人数
     * @return int
     *
     */
    public int headManNumber();

    /**
     *查询具体日期订单量（如今日订单量）
     * @return Deal
     *
     */
    public Deal dateOrderNumberDao(String date);

    /**
     * 查询商品销量排行
     * @return  List<goodsRank>
     */
    public List<goodsRank> goodsRankDao();

}
