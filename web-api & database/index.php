<?php

#jetOrder API - Developed by Emre YILDIRIM

include_once "db.php";

//Operations start

if ($_POST["operation"] == "register") {
 if (
  $_POST["userName"] == "" or
  $_POST["userPhone"] == "" or
  $_POST["userEmail"] == "" or
  $_POST["userPassword"] == "" or
  $_POST["userProvince"] == "" or
  $_POST["userDistrict"] == "" or
  $_POST["userAddress"] == ""
) {
  echo json_encode(["status" => "error"]);
  exit();
} else {
  Register(
    $_POST["userName"],
    $_POST["userPhone"],
    $_POST["userEmail"],
    $_POST["userPassword"],
    $_POST["userProvince"],
    $_POST["userDistrict"],
    $_POST["userAddress"]
  );
}
}

if ($_POST["operation"] == "login") {
  Login($_POST["email"], $_POST["password"]);
}

if ($_POST["operation"] == "getProducts") {
  GetProducts($_POST["categoryID"]);
}

if ($_POST["operation"] == "getSearchedProducts") {
  GetSearchedProducts($_POST["productName"]);
}

if ($_POST["operation"] == "addFavorite") {
  AddFavorite($_POST["userID"], $_POST["productID"]);
}

if ($_POST["operation"] == "getFavoriteProducts") {
  GetFavoriteProducts($_POST["userID"]);
}

if ($_POST["operation"] == "addShoppingCart") {
  AddShoppingCart($_POST["userID"], $_POST["productID"],$_POST["quantity"]);
}

if ($_POST["operation"] == "getShoppingCart") {
 GetShoppingCart($_POST["userID"]);
}

if ($_POST["operation"] == "getTotalPrice") {
 GetTotalPrice($_POST["userID"]);
}

if ($_POST["operation"] == "getProfileData") {
 GetProfileData($_POST["userID"]);
}

if ($_POST["operation"] == "emptyShoppingCart") {
 EmptyShoppingCart($_POST["userID"]);
}


if ($_POST["operation"] == "updateProfileData") {
  if (
    $_POST["userPassword"] == "" or
    $_POST["userProvince"] == "" or
    $_POST["userDistrict"] == "" or
    $_POST["userAddress"] == ""
  ) {
    echo json_encode(["status" => "error"]);
    exit();
  } else {
    UpdateProfileData(
      $_POST["userID"],
      $_POST["userPassword"],
      $_POST["userProvince"],
      $_POST["userDistrict"],
      $_POST["userAddress"]
    );
  }

}

if ($_POST["operation"] == "addProductShoppingCart") {
 AddProductShoppingCart($_POST["userID"], $_POST["productID"]);
}

if ($_POST["operation"] == "removeProductShoppingCart") {
 RemoveProductShoppingCart($_POST["userID"], $_POST["productID"]);
}

if ($_POST["operation"] == "deleteProductShoppingCart") {
 DeleteProductShoppingCart($_POST["userID"], $_POST["productID"]);
}

if ($_POST["operation"] == "getOrderData") {
 GetOrderData($_POST["userID"]);
}

if ($_POST["operation"] == "placeOrder") {
 PlaceOrder($_POST["userID"], $_POST["totalPrice"]);
}

if ($_POST["operation"] == "getOrders") {
 GetOrders($_POST["userID"]);
}


if ($_POST["operation"] == "giveStar") {
 GiveStar($_POST["userID"],$_POST["productID"],$_POST["point"],$_POST["categoryID"]);
}

if ($_POST["operation"] == "getOrderDetails") {
 GetOrderDetails($_POST["orderCode"]);
}

// operations end

function Register($name,$phone,$email,$password,$province,$district,$address)
{
  global $con;
  $checkUsername = "SELECT * FROM users WHERE userEmail = ?";
  $st2 = $con->prepare($checkUsername);
  $st2->execute([$email]);
  $all = $st2->fetchAll();
  if (count($all) < 1) {
    $sql = "INSERT INTO users SET
    userName = ?,
    userPhone = ?,
    userEmail = ?,
    userPassword = ?,
    userProvince = ?,
    userDistrict = ?,
    userAddress = ?";
    $st = $con->prepare($sql);

    $st->execute([$name, $phone, $email, md5($password), $province, $district, $address]);
    if ($st) {
      echo json_encode(["status" => "success"]);
      exit();
    } else {
      echo json_encode(["status" => "error"]);
      exit();
    }
  }else{

  	echo json_encode(["status" => "error"]);
    exit();
  }
}

function Login($email, $password)
{
  global $con;

  $sql =
  "SELECT userID,userName,userEmail FROM users WHERE userEmail=? AND userPassword=?";
  $st = $con->prepare($sql);
  $st->execute([$email, md5($password)]); //encrypt password
  $all = $st->fetchAll();

  if (count($all) == 1) {
    $all[0]["status"] = "success";
    echo json_encode($all[0]);
    exit();
  }

  echo json_encode(["status" => "error","userID" => 0]);
  exit();

}


function GetProducts($id)
{
  global $con;

  $sql = "SELECT * FROM products WHERE productCategory = ?";
  $st = $con->prepare($sql);
  $st->execute([$id]);
  $all = $st->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($all);
  exit();
}


function GetSearchedProducts($name)
{
  global $con;

  $sql = "SELECT * FROM products WHERE productName LIKE '%$name%' ";
  $st = $con->prepare($sql);
  $st->execute([$name]);
  $all = $st->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($all);
  exit();
}

function AddFavorite($userid,$productid)
{
  global $con;

  $checkFavorite = "SELECT * FROM favorites WHERE favoriteProductID = ? AND favoriteUserID = ?";
  $st2 = $con->prepare($checkFavorite);
  $st2->execute([$productid,$userid]);
  $all = $st2->fetchAll();

  if(count($all) > 0){
    $sql = "DELETE FROM favorites WHERE favoriteProductID = ? AND favoriteUserID = ?";
    $st = $con->prepare($sql);
    $st->execute([$productid,$userid]);
    if($st){
     echo json_encode(["status" => "removedSuccess"]);
     exit;
   }
 }else{
  $sql = "INSERT INTO favorites SET favoriteProductID = ? , favoriteUserID = ?";
  $st = $con->prepare($sql);
  $st->execute([$productid,$userid]);
  if($st){

   echo json_encode(["status" => "addedSuccess"]);
   exit;

 }else{

  echo json_encode(["status" => "error"]);
  exit;
}

}


}


function GetFavoriteProducts($userid)
{
  global $con;

  $sql = "SELECT productID, productName, productPhoto, productPrice, productDesc, productQuantity, productCategory, productPoint FROM favorites INNER JOIN products ON favoriteProductID = productID WHERE favoriteUserID = ?";
  $st = $con->prepare($sql);
  $st->execute([$userid]);
  $all = $st->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($all);
  exit();
}


function AddShoppingCart($userid,$productid,$quantity)
{
  global $con;


  $checkCart = "SELECT * FROM shoppingCart WHERE cartUserID = ? AND cartProductID = ?";
  $st2 = $con->prepare($checkCart);
  $st2->execute([$userid,$productid]);
  $all = $st2->fetchAll();

  if(count($all) > 0){
    $sql = "UPDATE shoppingCart SET cartQuantity = cartQuantity + ? WHERE cartUserID = ? AND cartProductID = ?";
    $st = $con->prepare($sql);
    $st->execute([$quantity,$userid,$productid]);
    if($st){
     echo json_encode(["status" => "success"]);
     exit;
   }
 }else{
  $sql = "INSERT INTO shoppingCart SET cartProductID = ? , cartUserID = ?, cartQuantity = ? ";
  $st = $con->prepare($sql);
  $st->execute([$productid,$userid,$quantity]);
  if($st){

   echo json_encode(["status" => "success"]);
   exit;

 }else{

  echo json_encode(["status" => "error"]);
  exit;
}


}

}

function GetShoppingCart($userid)
{
  global $con;

  $sql = "SELECT productID, productName, productPhoto, productPrice, productQuantity, cartQuantity, productPrice * cartQuantity AS totalPrice FROM shoppingCart INNER JOIN products ON cartProductID = productID WHERE cartUserID = ?";
  $st = $con->prepare($sql);
  $st->execute([$userid]);
  $all = $st->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($all);
  exit();
}


function GetTotalPrice($userid)
{
  global $con;

  $sql = "SELECT SUM(productPrice * cartQuantity) as cartPrice FROM shoppingCart INNER JOIN products ON cartProductID = productID WHERE cartUserID = ?";

  $st = $con->prepare($sql);

  $st->execute([$userid]);

  $totalPrice = $st->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($totalPrice);
  exit();
}


function GetProfileData($userid)
{
  global $con;

  $sql = "SELECT * FROM users WHERE userID = ?";

  $st = $con->prepare($sql);

  $st->execute([$userid]);

  $userData = $st->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($userData);
  exit();
}


function UpdateProfileData($userid,$password,$province,$district,$address)
{
  global $con;

  $sql = "UPDATE users SET
  userPassword = ?,
  userProvince = ?,
  userDistrict = ?,
  userAddress = ? WHERE userID = ?";
  $st = $con->prepare($sql);

  $st->execute([md5($password), $province, $district, $address, $userid]);
  if ($st) {
    echo json_encode(["status" => "success"]);
    exit();
  } else {
    echo json_encode(["status" => "error"]);
    exit();
  }

}


function AddProductShoppingCart($userid,$productid)
{
 global $con;

 $sql = "UPDATE shoppingCart SET
 cartQuantity = cartQuantity + 1 WHERE cartUserID = ? AND cartProductID = ?";

 $st = $con->prepare($sql);

 $st->execute([$userid,$productid]);

 if ($st) {
  echo json_encode(["status" => "success"]);
  exit();
} else {
  echo json_encode(["status" => "error"]);
  exit();
}

}


function RemoveProductShoppingCart($userid,$productid)
{
 global $con;

 $sql = "UPDATE shoppingCart SET
 cartQuantity = cartQuantity - 1 WHERE cartUserID = ? AND cartProductID = ?";

 $st = $con->prepare($sql);

 $st->execute([$userid,$productid]);

 if ($st) {
  echo json_encode(["status" => "success"]);
  exit();
} else {
  echo json_encode(["status" => "error"]);
  exit();
}

}

function EmptyShoppingCart($userid)
{
 global $con;

 $sql = "DELETE FROM shoppingCart WHERE cartUserID = ?";

 $st = $con->prepare($sql);

 $st->execute([$userid]);

 if ($st) {
  echo json_encode(["status" => "success"]);
  exit();
} else {
  echo json_encode(["status" => "error"]);
  exit();
}

}

function DeleteProductShoppingCart($userid, $productid)
{
  global $con;

  $sql = "DELETE FROM shoppingCart WHERE cartUserID = ? AND cartProductID = ? ";

  $st = $con->prepare($sql);

  $st->execute([$userid,$productid]);

  if ($st) {
    echo json_encode(["status" => "success"]);
    exit();
  } else {
    echo json_encode(["status" => "error"]);
    exit();
  }

}

function GetOrderData($userid)
{
  global $con;

  $sql = "SELECT SUM(productPrice * cartQuantity) as cartPrice, userAddress, userProvince, userDistrict FROM shoppingCart INNER JOIN products ON cartProductID = productID INNER JOIN users ON cartUserID = userID WHERE cartUserID = ?";
  $st = $con->prepare($sql);
  $st->execute([$userid]);
  $all = $st->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($all);
  exit();
}

function PlaceOrder($userid,$totalPrice)
{

 function generateRandomString($length = 5) {
  return substr(str_shuffle(str_repeat($x='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length/strlen($x)) )),1,$length);
}

$code = generateRandomString();

global $con;

$sql = "INSERT INTO orders (orderCustomerID, orderProductID,orderQuantity,orderCode,orderTotalPrice)
SELECT cartUserID, cartProductID, cartQuantity, '$code' , $totalPrice  FROM shoppingCart
WHERE cartUserID = ?";
$st = $con->prepare($sql);
$st->execute([$userid]);
if($st){
 echo json_encode(["status" => "success"]);
 $sql = "DELETE FROM shoppingCart WHERE cartUserID = ?";

 $st = $con->prepare($sql);

 $st->execute([$userid]);
 exit;
}else{

  echo json_encode(["status" => "error"]);
  exit;
}
}


function GetOrders($userid)
{
  global $con;

  $sql = "SELECT DISTINCT orderCode , orderStatus , orderDate, orderTotalPrice FROM orders WHERE orderCustomerID = ? ORDER BY orderDate DESC";
  $st = $con->prepare($sql);
  $st->execute([$userid]);
  $all = $st->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($all);
  exit();
}

function GiveStar($userid,$productid,$point,$categoryid)
{
  global $con;


  $checkRating = "SELECT * FROM productRatings WHERE ratingCustomerID = ? AND ratingProductID = ?";
  $st2 = $con->prepare($checkRating);
  $st2->execute([$userid,$productid]);
  $all = $st2->fetchAll();

  if(count($all) > 0){
    $sql = "UPDATE productRatings SET ratingPoint = ? WHERE ratingCustomerID = ? AND ratingProductID = ?";
    $st = $con->prepare($sql);
    $st->execute([$point, $userid,$productid]);
    if($st){
     echo json_encode(["status" => "success"]);
     exit;
   }
 }else{
  $sql = "INSERT INTO productRatings SET ratingPoint = ? , ratingCategoryID = ? , ratingCustomerID = ?, ratingProductID = ? ";
  $st = $con->prepare($sql);
  $st->execute([$point,$categoryid,$userid,$productid]);
  if($st){

   echo json_encode(["status" => "success"]);
   exit;

 }else{

  echo json_encode(["status" => "error"]);
  exit;
}


}
}

function GetOrderDetails($code)
{
  global $con;

  $sql = "SELECT * FROM orders
  INNER JOIN products ON orderProductID = productID
  INNER JOIN users ON orderCustomerID = userID
  WHERE orderCode = ?";
  $st = $con->prepare($sql);
  $st->execute([$code]);
  $all = $st->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($all);
  exit();
}



echo "jetOrder API";
exit();
?>
