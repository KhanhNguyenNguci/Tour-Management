<?php include 'inc/header.php';?>
<?php include 'inc/sidebar.php';?>
<?php include_once '../helpers/format.php';?>  
<?php include_once 'connect.php'; ?>

<div class="grid_10">
    <div class="box round first grid">
    <h2>Thêm Lịch Trình Tour</h2>
        <div class="block">
        
        <?php
    require_once('connect.php');
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $maTour = $_POST["ma_tour"];
        $sttNgay = $_POST["stt_ngay"];

        $sql = "CALL InsertLichTrinhTour(:ma_tour, :stt_ngay)";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':ma_tour', $maTour);
        $stmt->bindParam(':stt_ngay', $sttNgay);

        if ($stmt->execute()) {
            echo "Thêm lịch trình tour thành công.";
        } else {
            echo "Lỗi trong quá trình thêm lịch trình.";
        }
    }
    $conn = null;
    ?>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        Mã Tour: <input type="text" name="ma_tour"><br>
        Số thứ tự ngày: <input type="number" name="stt_ngay"><br>
        <input type="submit" value="Thêm">
    </form>
       </div>
    </div>
</div>

<?php include 'inc/footer.php';?>