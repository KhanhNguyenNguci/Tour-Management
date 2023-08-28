<?php include 'inc/header.php';?>
<?php include 'inc/sidebar.php';?>
<?php include_once 'connect.php'; ?>
<?php include '../classes/hanhdongtour.php';?>
<?php include_once '../helpers/format.php';?>

<?php
	$pd = new hanhdong();
	$fm = new Format();
	if(isset($_GET['productid']))
    {
        $id = $_GET['productid'];
    }
?>

<div class="grid_10">
    <div class="box round first grid">
        <h2>Danh sách lịch trình tour</h2>
        <div class="block">
			<?php
			if(isset($delpro)){
				echo $delpro;
			}
			?>
            <table class="data display datatable" id="example">
			<thead>
				<tr>
					<th>No.</th>
					<th>Mã Tour</th>
					<th>STT ngày</th>
					
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<?php
				$pdlist = $pd->show_hd();
				if($pdlist){
					$i = 0;
					while($result = $pdlist->fetch_assoc()){
						$i++;
				?>
				<tr class="odd gradeX">
					<td><?php echo $i ?></td>
					<td><?php echo $result['MaTour']?></td>
					<td><?php echo $result['STTNgay']?></td>
					
					<td><a href="detail.php?productid=<?php echo $result['MaTour'] ?>">Chi tiết</a></td>
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