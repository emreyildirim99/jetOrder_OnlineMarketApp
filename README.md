# CET 301 Final Project - jetOrder Online Market App - Emre YILDIRIM

## ✨ Purpose of the jetOrder
  Due to the coronavirus epidemic (COVID-19), which was declared a pandemic by the WHO, restrictions, and bans lead to increasing online shopping dramatically. While there is a rapid rise in online shopping around the world, this has significantly changed consumer behavior. Therefore, I developed jetOrder to create an opportunity for people to do shopping fast at any time of the day and with just a few clicks thanks to the jetOrder.

## 📝 Description of the jetOrder
  **jetOrder** is an online mobile market application in which users can do shopping easily without going to the real market. I developed the jetOrder with **Flutter** and **Dart** language. Besides, I also coded and developed my own API by using **PHP** and **MySQL**. All functions of the jetOrder are fully integrated with this API and they communicate with **JSON**.
  
  First of all, to use jetOrder, users should create an account in jetOrder to start online shopping. After users sign up and provide necessary information like phone number and delivery address, they can log in to jetOrder.
 
  There are four categories (fruits, vegetables, snacks, and drinks) for shopping in this minimum viable product (MVP) version of jetOrder. When clicked on one of these categories, the list of products related to that category appears. In this product list, the name, photo, price, and quantity information of products are provided. Users can click to "Add to cart" button bottom of the product to add the product into the shopping cart fast. Or, users can click the photo of the product to view it on the product detail page. On the product detail page, users can see the details of the product (e.g. description), add the product to the shopping cart more than once by using + and - buttons or add the product to their favorite list. If users seek a specific product, they can use the search button in the app bar to find a specific product.
  
  By using the bottom navigation bar on the home page, users can access the pages(favorite products, shopping cart, my orders, and profile pages) easily. 
  
  On the favorite products page, users can see their favorite products to order them fast also they can remove these products from their favorite list.
  
  On the shopping cart page, users can see the products and their information (e.g. total price of products) in the shopping cart and order them by using a credit card on the payment page. Also, they can remove all or a specific product from the shopping cart, increase or decrease the quantity of them. After each user's action on this page, all the information on this page is updated instantaneously and dynamically thanks to API.
  
  On my orders page, users can see their all orders and track the status of the orders (whether they are on the way or delivered).
  
  On the profile page, users can change the password or delivery address information.
  
## 💻 Framework and Programming Languages Used in the jetOrder
   * **Flutter & Dart**: jetOrder is developed with Flutter and Dart. I designed the UI of jetOrder as minimal and simple for a fast and effective shopping experience by using UI widgets. Also, I created services for each page that are necessary for API communication. These services send a post request to API according to the operation and get the data from the API. Since these processes are asynchronous, I used FutureBuilder to get the data. I also use some additional classes such as sessions to keep users logged in the app and for auto-login.

  * **PHP**: I coded the API with PHP. All functions in jetOrder app are performed thanks to this API. The API returns JSON responses to be used on the Flutter side.

  * **MySQL**: I created the database and also schema in MySQL and API communicates with this MySQL server. All data (users, products, etc.) about jetOrder is stored here.

## 🚀 Installation Guide
  To install and use jetOrder, first of all, you need Apache server to run API and MySQL server for the database. You can access the API and SQL file in [this folder](https://github.com/emreyildirim99/jetOrder_OnlineMarketApp/tree/master/web-api%20%26%20database). After running Apache and MySQL server and installing the API and SQL properly, you have to set the API URL in [this dart file](https://github.com/emreyildirim99/jetOrder_OnlineMarketApp/blob/master/lib/constants/Constants.dart). Then, jetOrder will be running fully functional.
  
  **⚠️ If you just want to test the jetOrder without installing API and SQL, you can test it by setting the API URL in [the dart file](https://github.com/emreyildirim99/jetOrder_OnlineMarketApp/blob/master/lib/constants/Constants.dart) as the following URL**
  ```
  http://cetwin.tk/jetorder/api.php
  ```
  
## 📱 Some Screenshots from the jetOrder
<p float="left">
<img src="https://i.hizliresim.com/rWAmIe.png" width="180" height="320">
<img src="https://i.hizliresim.com/knLBuy.png" width="180" height="320">
<img src="https://i.hizliresim.com/PVUyBL.png" width="180" height="320">
<img src="https://i.hizliresim.com/4YalgB.png" width="180" height="320">
<img src="https://i.hizliresim.com/f2NhIx.png" width="180" height="320">
<img src="https://i.hizliresim.com/Kq3LU9.png" width="180" height="320">
<img src="https://i.hizliresim.com/EWbdIF.png" width="180" height="320">
<img src="https://i.hizliresim.com/Hk2lGR.png" width="180" height="320">
</p>

## 🧑🏻‍💻 Developer

👤 **Emre YILDIRIM**

* Github: [@emreyildirim99](https://github.com/emreyildirim99)