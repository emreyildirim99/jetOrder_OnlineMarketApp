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

echo "jetOrder API";
exit();
?>
