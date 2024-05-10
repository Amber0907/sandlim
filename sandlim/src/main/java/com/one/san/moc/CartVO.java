package com.one.san.moc;

public class CartVO {

   private String c_id;
   private String c_name;
   private int c_total;
   private String c_price;
   private String c_option;
   private String c_size;
   private String c_toprice;
   private String c_img;
   private int c_no;

   public String getC_id() {
      return c_id;
   }

   public void setC_id(String c_id) {
      this.c_id = c_id;
   }

   public String getC_name() {
      return c_name;
   }

   public void setC_name(String c_name) {
      this.c_name = c_name;
   }

   public int getC_total() {
      return c_total;
   }

   public void setC_total(int c_total) {
      this.c_total = c_total;
   }

   public String getC_price() {
      return c_price;
   }

   public void setC_price(String c_price) {
      this.c_price = c_price;
   }

   public String getC_option() {
      return c_option;
   }

   public void setC_option(String c_option) {
      this.c_option = c_option;
   }

   public String getC_size() {
      return c_size;
   }

   public void setC_size(String c_size) {
      this.c_size = c_size;
   }

   public String getC_toprice() {
      return c_toprice;
   }

   public void setC_toprice(String c_toprice) {
      this.c_toprice = c_toprice;
   }

   public String getC_img() {
      return c_img;
   }

   public void setC_img(String c_img) {
      this.c_img = c_img;
   }

   public int getC_no() {
      return c_no;
   }

   public void setC_no(int c_no) {
      this.c_no = c_no;
   }

   @Override
   public String toString() {
      return "CartVO [c_id=" + c_id + ", c_name=" + c_name + ", c_total=" + c_total + ", c_price=" + c_price
            + ", c_option=" + c_option + ", c_size=" + c_size + ", c_toprice=" + c_toprice + ", c_img=" + c_img
            + ", c_no=" + c_no + "]";
   }
}