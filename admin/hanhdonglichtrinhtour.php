<?php include 'inc/header.php';?>
<?php include 'inc/sidebar.php';?>
<?php include_once '../helpers/format.php';?>  
<?php include_once 'connect.php'; ?>

<div class="grid_10">
    <div class="box round first grid">
    <h2>Thêm Hành Động Lịch Trình Tour</h2>
        <div class="block">
        <?php
    require_once('connect.php');
    $actionTypes = array(
        1 => "Khởi hành tour",
        2 => "Kết thúc tour",
        3 => "Ăn sáng",
        4 => "Ăn trưa",
        5 => "Ăn tối",
        6 => "Check in",
        7 => "Check out"
    );

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $maTour = $_POST["ma_tour"];
        $loaiHanhDong = $_POST["loai_hanh_dong"];
        $gioBatDau = $_POST["gio_bat_dau"];
        $gioKetThuc = $_POST["gio_ket_thuc"];
        $sttNgay = $_POST["stt_ngay"];

        $sql = "CALL InsertHanhDongLichTrinhTour(:ma_tour, :loai_hanh_dong, :gio_bat_dau, :gio_ket_thuc, :stt_ngay)";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':ma_tour', $maTour);
        $stmt->bindParam(':loai_hanh_dong', $loaiHanhDong);
        $stmt->bindParam(':gio_bat_dau', $gioBatDau);
        $stmt->bindParam(':gio_ket_thuc', $gioKetThuc);
        $stmt->bindParam(':stt_ngay', $sttNgay);

        if ($stmt->execute()) {
            echo "Thêm hành động lịch trình tour thành công.";
        } else {
            echo "Lỗi trong quá trình thêm hành động lịch trình.";
        }
    }
    $conn = null;
    ?>

    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        Mã Tour: <input type="text" name="ma_tour"><br>
        Loại Hành Động:
        <select name="loai_hanh_dong">
            <?php foreach ($actionTypes as $key => $value) {
                echo "<option value=\"$key\">$value</option>";
            } ?>
        </select><br>
        Giờ Bắt Đầu: <input type="time" name="gio_bat_dau"><br>
        Giờ Kết Thúc: <input type="time" name="gio_ket_thuc"><br>
        Số thứ tự ngày: <input type="number" name="stt_ngay"><br>
        <input type="submit" value="Thêm">
    </form>
       </div>
    </div>
</div>

<?php include 'inc/footer.php';?>