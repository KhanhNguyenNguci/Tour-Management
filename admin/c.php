<?php include 'inc/header.php';?>
<?php include 'inc/sidebar.php';?>
<?php include_once '../helpers/format.php';?>  
<?php include_once 'connect.php'; ?>

<div class="grid_10">
    <div class="box round first grid">
    <h2>Thống kê doanh thu</h2>
        <div class="block">
        
    <form method="post">
        Enter the year: <input type="text" name="year">
        <input type="submit" value="Submit">
    </form>
    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $year = $_POST["year"];
    }
    $stmt = $conn->prepare("CALL ThongKeDoanhThu(:year)");
    $stmt->bindParam(':year', $year, PDO::PARAM_INT);
    $stmt->execute();

    // Display the results
    echo "<table style='border-collapse: collapse; border: 1px solid black; margin: 0 auto;'>
    <tr>
    <th style='border: 2px solid black;'>Tháng</th>
    <th style='border: 2px solid black;'>Tổng doanh thu</th>
    </tr>";

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    echo "<tr>";
    echo "<td style='border: 1px solid black;'>" . $row['Thang'] . "</td>";
    echo "<td style='border: 1px solid black;'>" . $row['TongDoanhThu'] . "</td>";
    echo "</tr>";
    }
    echo "</table>";
    ?>
       </div>
    </div>
</div>

<?php include 'inc/footer.php';?>
