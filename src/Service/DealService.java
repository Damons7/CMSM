package Service;

import JavaBean.Deal;
import JavaBean.goodsRank;

import java.util.List;

public interface DealService {

    /**
     * 查询商品比例
     * @return int[]
     */
    public int[] goodsScale();

    /**
     * 查询订单状态绘制图表
     * @return Deal
     */
    public Deal orderConditionsService();

    /**
     * 查询订单月销量绘制图表
     * @return Deal
     */
    public Deal orderMonthService();

    /**
     * 查询订单季度销量绘制图表
     * @return Deal
     */
    public Deal orderQuarterService();

    /**
     * 查询交易金额、退款金额、交易失败、交易成功、订单数量
     * @return int[]
     */
    public int[] orderSalesService();

    /**
     * 查询会员人数、男女比例
     * @return int[]
     */
    public int[] userDataService();

    /**
     * 查询团长人数
     * @return int
     */
    public int headManDataService();


    /**
     * 查询具体日期订单量（如今日订单量）
     * @return int[]
     */
    public int[] dateOrderNumberService(String date);

    /**
     * 查询商品销量排行
     * @return  List<goodsRank>
     */
    public List<goodsRank> goodsRankService();

}
