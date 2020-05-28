package JavaBean;

public class Deal {
    private int alreadyNumber;   //已收货数量
    private int deliverNumber;//待发货数量
    private int takeOverNumber;//待收货数量
    private int returningNumber;//退货中数量
    private int returnedNumber;//已退货数量

    private int transactionSuccess; //交易成功
    private int transactionFail; //交易失败
   private int transactionAmount; //交易金额
//    private int refundAmount; //退款金额
    private int orderNumber; //订单数量

    //12个月份
    private String jan;
    private String feb;
    private String mar;
    private String apr;
    private String may;
    private String june;
    private String july;
    private String aug;
    private String sept;
    private String oct;
    private String nov;
    private String dece;

    //四个季度
    private String q1th;
    private String q2nd;
    private String q3rd;
    private String q4th;

    public int getAlreadyNumber() {
        return alreadyNumber;
    }

    public void setAlreadyNumber(int alreadyNumber) {
        this.alreadyNumber = alreadyNumber;
    }

    public int getDeliverNumber() {
        return deliverNumber;
    }

    public void setDeliverNumber(int deliverNumber) {
        this.deliverNumber = deliverNumber;
    }

    public int getTakeOverNumber() {
        return takeOverNumber;
    }

    public void setTakeOverNumber(int takeOverNumber) {
        this.takeOverNumber = takeOverNumber;
    }

    public int getReturningNumber() {
        return returningNumber;
    }

    public void setReturningNumber(int returningNumber) {
        this.returningNumber = returningNumber;
    }

    public int getReturnedNumber() {
        return returnedNumber;
    }

    public void setReturnedNumber(int returnedNumber) {
        this.returnedNumber = returnedNumber;
    }

    public String getJan() {
        return jan;
    }

    public void setJan(String jan) {
        this.jan = jan;
    }

    public String getFeb() {
        return feb;
    }

    public void setFeb(String feb) {
        this.feb = feb;
    }

    public String getMar() {
        return mar;
    }

    public void setMar(String mar) {
        this.mar = mar;
    }

    public String getApr() {
        return apr;
    }

    public void setApr(String apr) {
        this.apr = apr;
    }

    public String getMay() {
        return may;
    }

    public void setMay(String may) {
        this.may = may;
    }

    public String getJune() {
        return june;
    }

    public void setJune(String june) {
        this.june = june;
    }

    public String getJuly() {
        return july;
    }

    public void setJuly(String july) {
        this.july = july;
    }

    public String getAug() {
        return aug;
    }

    public void setAug(String aug) {
        this.aug = aug;
    }

    public String getSept() {
        return sept;
    }

    public void setSept(String sept) {
        this.sept = sept;
    }

    public String getOct() {
        return oct;
    }

    public void setOct(String oct) {
        this.oct = oct;
    }

    public String getNov() {
        return nov;
    }

    public void setNov(String nov) {
        this.nov = nov;
    }

    public String getDece() {
        return dece;
    }

    public void setDece(String dece) {
        this.dece = dece;
    }

    public String getQ1th() {
        return q1th;
    }

    public void setQ1th(String q1th) {
        this.q1th = q1th;
    }

    public String getQ2nd() {
        return q2nd;
    }

    public void setQ2nd(String q2nd) {
        this.q2nd = q2nd;
    }

    public String getQ3rd() {
        return q3rd;
    }

    public void setQ3rd(String q3rd) {
        this.q3rd = q3rd;
    }

    public String getQ4th() {
        return q4th;
    }

    public void setQ4th(String q4th) {
        this.q4th = q4th;
    }

    public int getTransactionSuccess() {
        return transactionSuccess;
    }

    public void setTransactionSuccess(int transactionSuccess) {
        this.transactionSuccess = transactionSuccess;
    }

    public int getTransactionFail() {
        return transactionFail;
    }

    public void setTransactionFail(int transactionFail) {
        this.transactionFail = transactionFail;
    }

    public int getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(int orderNumber) {
        this.orderNumber = orderNumber;
    }

    public int getTransactionAmount() {
        return transactionAmount;
    }

    public void setTransactionAmount(int transactionAmount) {
        this.transactionAmount = transactionAmount;
    }
}
