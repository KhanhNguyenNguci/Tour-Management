<?php include 'inc/header.php';?>
<?php include 'inc/sidebar.php';?>
<?php include '../classes/detailtour.php';?>
<?php include_once '../helpers/format.php';?>

<?php
	$pd = new dethanhdong();
	$fm = new Format();
	if(isset($_GET['productid']))
    {
        $id = $_GET['productid'];
    }
?>

<div class="grid_10">
    <div class="box round first grid">
        <h2>Chi tiết lịch trình tour</h2>
        <div class="block">
            <table class="data display datatable" id="example">
			<thead>
				<tr>
					<th>No.</th>
					<th>Mã Tour</th>
					<th>STT ngày</th>
					<th>Loại hành động</th>
					<th>Giờ bắt đầu</th>
                    <th>Giờ kết thúc</th>
					<th>Mô tả</th>
				</tr>
			</thead>
			<tbody>
				<?php
				$pdlist = $pd->show_hddet();
				if($pdlist){
					$i = 0;
					while($result = $pdlist->fetch_assoc()){
						$i++;
				?>
				<tr class="odd gradeX">
					<td><?php echo $i ?></td>
					<td><?php echo $result['MaTour']?></td>
					<td><?php echo $result['STTNgay']?></td>
					<td><?php echo $result['LoaiHanhDong']?></td>
					<td><?php echo $result['GioBatDau']?></td>
                    <td><?php echo $result['GioKetThuc']?></td>
					<td><?php echo $result['MoTa']?></td>
				</tr>
				<?php
					}
				}
				?>
			</tbody>
		</table>

       </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        setupLeftMenu();
        $('.datatable').dataTable();
		setSidebarHeight();
    });
</script>
<?php include 'inc/footer.php';?>