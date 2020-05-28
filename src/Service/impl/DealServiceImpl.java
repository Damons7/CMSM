package Service.impl;

import Dao.DealDao;
import Dao.impl.DealDapImpl;
import JavaBean.Deal;
import JavaBean.goodsRank;
import JavaBean.userDetail;
import Service.DealService;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;

public class DealServiceImpl implements DealService {
    private DealDao dao=new DealDapImpl();
    private ObjectMapper mapper = new ObjectMapper();
    @Override
    public int[] goodsScale(){
        int[] goods={0,0,0};
        goods[0]=dao.fruitAmount();
        goods[1]=dao.snacksAmount();
        goods[2]=dao.vegetablesAmount();
        return goods;
    }

    @Override
    public Deal orderConditionsService(){
     return dao.orderAmount();
    }

    @Override
    public Deal orderQuarterService(){

        return dao.orderQuarter();
    }

    @Override
    public Deal orderMonthService(){
        return dao.orderMonth();
    }

    @Override
    public int[] orderSalesService(){
        int[] order={0,0,0,0,0};
        Deal deal=dao.orderNumbers();
        order[0]=dao.transactionAmount();
        order[1]=deal.getOrderNumber();
        order[2]= deal.getTransactionSuccess();
        order[3]=deal.getTransactionFail();
        order[4]=dao.refundAmount();
        return order;
    }

    @Override
    public int[] userDataService(){
        int[] userData={0,0,0};
        userDetail detail=dao.userNumbers();
        userData[0]=detail.getCounts();
        userData[1]=detail.getManNumber();
        userData[2]=detail.getWomanNumber();
        return userData;
    }

    @Override
    public int headManDataService(){

        return dao.headManNumber();
    }

    @Override
    public int[] dateOrderNumberService(String date){
        int []dateNumber={0,0};
        Deal dateDeal=dao.dateOrderNumberDao(date);
          if (dateDeal!=null) {
              dateNumber[0] = dateDeal.getOrderNumber();
              dateNumber[1] = dateDeal.getTransactionAmount();
          }
        return dateNumber;
    }

    @Override
    public List<goodsRank> goodsRankService() {
        return dao.goodsRankDao();

    }
}
