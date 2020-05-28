package Service.impl;

import Dao.FruitDao;
import Dao.OrderDao;
import Dao.SnacksDao;
import Dao.VegetablesDao;
import Dao.impl.FruitDaoImpl;
import Dao.impl.OrderDaoImpl;
import Dao.impl.SnacksDaoImpl;
import Dao.impl.VegetablesDaoImpl;
import Functions.in_img;
import JavaBean.*;
import Service.OrderService;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class OrderServiceImpl implements OrderService {

    private OrderDao dao = new OrderDaoImpl();
    @Override
    public PageBean<Order> findOrderByPage(String _currentPage, String _rows,String condition,String conditions) {

        int currentPage = Integer.parseInt(_currentPage);
        int rows = Integer.parseInt(_rows);

        if(currentPage <=0) {
            currentPage = 1;
        }
        //1.创建空的PageBean对象
        PageBean<Order> pb = new PageBean<Order>();
        //2.设置参数
        pb.setCurrentPage(currentPage);
        pb.setRows(rows);

        //3.调用dao查询总记录数
        int totalCount = dao.findTotalCount(condition,conditions);
        pb.setTotalCount(totalCount);
        //4.调用dao查询List集合
        //计算开始的记录索引
        int start = (currentPage - 1) * rows;
        List<Order> list = dao.findByPage(start,rows,condition,conditions);
        pb.setList(list);

        //5.计算总页码
        int totalPage = (totalCount % rows)  == 0 ? totalCount/rows : (totalCount/rows) + 1;
        pb.setTotalPage(totalPage);
        return pb;
    }

    @Override
    public int Bulk_deliver_Order(String[] ids) {
        int a = 0;
        SimpleDateFormat now_time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (ids != null && ids.length > 0) {
            //1.遍历数组
            for (String orderid : ids) {
                //2.调用dao
                a = dao.deliver_Order(orderid, now_time.format(new Date()));
            }
        }
        return a;
    }

    @Override
    public int deliver_Order(String orderid) {
        SimpleDateFormat now_time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return dao.deliver_Order(orderid, now_time.format(new Date()));
    }

    @Override
    public int Bulk_return_Order(String[] ids) {
        int a = 0;
        SimpleDateFormat now_time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (ids != null && ids.length > 0) {
            //1.遍历数组
            for (String orderid : ids) {
                //2.调用dao
                a = dao.return_Order(orderid, now_time.format(new Date()));
            }
        }
        return a;
    }

    @Override
    public int return_Order(String orderid) {
        SimpleDateFormat now_time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return dao.return_Order(orderid, now_time.format(new Date()));
    }

    @Override
    public List<DetailOrder> DetailsOrderService(String orderid){

        in_img imgs = new in_img(); //图片方法
        DetailOrder order=new DetailOrder();
        List<DetailOrder> list=dao.DetailOrderDao(orderid); //获取订单详情的数据存至list
        try {
            for (int i = 0; i < list.size(); i++) {
                DetailOrder obj =  list.get(i);
                ObjectMapper mapper = new ObjectMapper();
                String Order_json = obj.getGoods();
                System.out.println("Order_json:"+Order_json);
                obj = mapper.readValue(Order_json, DetailOrder.class);
                if (obj.getGoods_type().equals("fruit")){
                    FruitDao fruit1=new FruitDaoImpl();
                    Fruit fruit= fruit1.DetailsFruit(Integer.parseInt(obj.getGoods_id()));
                    obj.setGoods_type("1"); //商品类型，fruit用1表示
                    obj.setGoods_price(fruit.getDiscount_price());  //商品单价
                    obj.setGoods_img(fruit.getImgs());  //商品图片路径
                    obj.setGoods_title(fruit.getTitle()); //商品标题
                    obj.setGoods_img(imgs.get_firstImgPath(fruit.getImgs()));  //商品首个图片
                    if (fruit.getAmount()>0){   //查询数量是否有库存
                        obj.setGoods_stock("有货");
                    }else{
                        obj.setGoods_stock("缺货");
                    }
                }else if (obj.getGoods_type().equals("snacks")){
                    SnacksDao sna1=new SnacksDaoImpl();
                    Snacks sna= sna1.DetailsSnacks(Integer.parseInt(obj.getGoods_id()));
                    obj.setGoods_type("3"); //商品类型，snacks用3表示
                    obj.setGoods_price(sna.getDiscount_price());
                    obj.setGoods_img(sna.getImgs());
                    obj.setGoods_title(sna.getTitle());
                    obj.setGoods_img(imgs.get_firstImgPath(sna.getImgs()));
                    if (sna.getAmount()>0){
                        obj.setGoods_stock("有货");
                    }else{
                        obj.setGoods_stock("缺货");
                    }
                }else  if (obj.getGoods_type().equals("vegetables")){
                    VegetablesDao veg1=new VegetablesDaoImpl();
                    Vegetables veg= veg1.DetailsVegetables(Integer.parseInt(obj.getGoods_id()));
                    obj.setGoods_type("2"); //商品类型，vegetables用2表示
                    obj.setGoods_price(veg.getDiscount_price());
                    obj.setGoods_img(veg.getImgs());
                    obj.setGoods_title(veg.getTitle());
                    obj.setGoods_img(imgs.get_firstImgPath(veg.getImgs()));
                    if (veg.getAmount()>0){
                        obj.setGoods_stock("有货");
                    }else{
                        obj.setGoods_stock("缺货");
                    }
                }
                list.set(i,obj);
            }

        }
         catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public userAddress DetailsUserAddress(String orderid){
        userAddress useraddress=new userAddress();
        useraddress= dao.FindAddressByOrderid(orderid);
        return  useraddress;
    }

    @Override
    public int updateOrder(userAddress addre ,String orderid)
    {
        return dao.updateOrderDao(addre,orderid);
    }

    @Override
    public int updateOrderMessage(String message ,String orderid)
    {
        return dao.updateOrderMessageDao(message,orderid);
    }
}
