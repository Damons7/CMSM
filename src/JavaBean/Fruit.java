package JavaBean;

public class Fruit {
    private int id;
    private String name;
    private double price;
    private double discount_price;
    private double cost;
    private int numbers;
    private int amount ;
    private String add_time;
    private String pull_off_time;
    private String describes;
    private int conditions;
    private String image;
    private String title;
    private String imgs;
    private String[] imgss;

    public int getNumbers() {
        return numbers;
    }

    public void setNumbers(int numbers) {
        this.numbers = numbers;
    }

    public String[] getImgss() {
        return imgss;
    }

    public void setImgss(String[] imgss) {
        this.imgss = imgss;
    }

    public String getImgs() {
        return imgs;
    }

    public void setImgs(String imgs) {
        this.imgs = imgs;
    }

    public double getDiscount_price() {
        return discount_price;
    }

    public void setDiscount_price(double discount_price) {
        this.discount_price = discount_price;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getAdd_time() {
        return add_time;
    }

    public void setAdd_time(String add_time) {
        this.add_time = add_time;
    }

    public String getPull_off_time() {
        return pull_off_time;
    }

    public void setPull_off_time(String pull_off_time) {
        this.pull_off_time = pull_off_time;
    }

    public String getDescribes() {
        return describes;
    }

    public void setDescribes(String describes) {
        this.describes = describes;
    }

    public int getConditions() {
        return conditions;
    }

    public void setConditions(int conditions) {
        this.conditions = conditions;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
