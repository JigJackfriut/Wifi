 <?php
session_start();
$con = mysqli_connect("localhost","root", "Kenyon2023","wifi", "wifi_development");
if($con){
      print("Connection Established Successfully");
   }else{
      print("Connection Failed ");
   }
if (isset($POST['submit'])) {
 $name =$_POST['enabled'];
 $query = "INSERT INTO wlans(enabled) VALUES ('$enabled')";
 $query_run = mysqli_query($con, $query);
 
 if ($query_run){
 	$_SESSION['status'] = "Inserted Successfully";
 }
 else
 {
 	$_SESSION['status'] = "Not Inserted";
 }
 ?>