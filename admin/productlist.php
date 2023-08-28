<?php include 'inc/header.php';?>
<?php include 'inc/sidebar.php';?>
<?php include '../classes/category.php';?>
<?php include '../classes/product.php';?>
<?php include_once '../helpers/format.php';?>

<?php
	$pd = new product();
	$fm = new Format();
	if(isset($_GET['productid']))
    {
        $id = $_GET['productid'];
		$delpro = $pd->del_product($id);
    }
?>

<div class="grid_10">
    <div class="box round first grid">
        <h2>Danh sách Tour</h2>
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
					<th>Chi nhánh</th>
					<th>Tên</th>
					<th>Ngày bắt đầu</th>
					<th>Số ngày</th>
					<th>Số đêm</th>
					<th>Ảnh</th>
					<th>S.K.T.TT</th>
					<th>S.K.T.TD</th>
					<th>G.V.L.NL</th>
					<th>G.V.L.TE</th>
					<th>G.V.Đ.NL</th>
					<th>G.V.Đ.TE</th>
					<th>S.K.Đ.TT</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<?php
				$pdlist = $pd->show_product();
				if($pdlist){
					$i = 0;
					while($result = $pdlist->fetch_assoc()){
						$i++;
				?>
				<tr class="odd gradeX">
					<td><?php echo $i ?></td>
					<td><?php echo $result['TenCN']?></td>
					<td><?php echo $result['TenTour']?></td>
					<td><?php echo $result['NgayBatDau']?></td>
					<td><?php echo $result['SoNgay']?></td>
					<td><?php echo $result['SoDem']?></td>
					<td><image src ="uploads/<?php echo $result['image']?>" width="80"> </td>
					<td><?php echo $result['SoKhachTourToiThieu']?></td>
					<td><?php echo $result['SoKhachTourToiDa']?></td>
					<td><?php echo $result['GiaVeLeNguoiLon']?></td>
					<td><?php echo $result['GiaVeLeTreEm']?></td>
					<td><?php echo $result['GiaVeDoanNguoiLon']?></td>
					<td><?php echo $result['GiaVeDoanTreEm']?></td>
					<td><?php echo $result['SoKhachDoanToiThieu']?></td>
					<td><a href="productedit.php?productid=<?php echo $result['MaTour'] ?>">Edit</a> || <a href="?productid=<?php echo $result['MaTour'] ?>">Delete</a></td>
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
