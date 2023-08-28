<?php include 'inc/header.php';?>
<?php include 'inc/sidebar.php';?>
<?php include '../classes/category.php'?>
<?php
	$cat = new category();
	if(isset($_GET['delid']))
    {
        $id = $_GET['delid'];
		$delcat = $cat->del_category($id);
    }
?>
        <div class="grid_10">
            <div class="box round first grid">
                <h2>Danh sách chi nhánh</h2>
                <div class="block"> 
				<?php
                if(isset($delcat))
                {
                    echo $delcat; #thong bao
                }
                ?>       
                    <table class="data display datatable" id="example">
					<thead>
						<tr>
							<th>Serial No.</th>
							<th>Department Name</th>
						</tr>
					</thead>
					<tbody>
					<?php
						$show_cate = $cat->show_category();
						if($show_cate){
							$i = 0;
							while($result = $show_cate->fetch_assoc()){
								$i++;
					
					?>
						<tr class="odd gradeX">
							<td><?php echo $result['MaCN'] ?></td>
							<td><?php echo $result['TenCN'] ?></td>
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

