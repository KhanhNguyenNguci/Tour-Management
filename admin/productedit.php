<?php include 'inc/header.php';?>
<?php include 'inc/sidebar.php';?>
<?php include '../classes/category.php';?>
<?php include '../classes/product.php';?>

<?php
	$pd = new product();
    if(!isset($_GET['productid']) || $_GET['productid'] == NULL)
    {
        echo "<script>window.location ='productlist.php'</script>";
    }else{
        $id = $_GET['productid'];
    }

	if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['submit'])) //submit moi Save
	{
		$updateProduct = $pd->update_product($_POST, $_FILES, $id); //_FILES: Them hinh anh, _POST: lat all data khi submit
	}
?>

<div class="grid_10">
    <div class="box round first grid">
        <h2>Thêm Tour</h2>
        <div class="block">
        <?php
            if(isset($updateProduct))
            {
                echo $updateProduct; #thong bao
            }
        ?> 
        <?php
        $get_product_by_id = $pd->getproductbyId($id);
        if($get_product_by_id){
            while($result_product = $get_product_by_id->fetch_assoc()){
        ?>                 
        <form action="" method="post" enctype="multipart/form-data">
            <table class="form">
                <tr>
                    <td>
                        <label>Chi Nhánh</label>
                    </td>
                    <td>
                        <select id="select" name="category">
                            <option>------Select Category------</option>
                            <?php
                            $cat = new category();
                            $catlist = $cat->show_category();
                            if($catlist){
                                while($result = $catlist->fetch_assoc()){
                            ?>
                            <option
                            <?php
                            if($result['MaCN'] == $result_product['MaCN']){
                                echo 'selected';
                            }
                            ?>
                            value="<?php echo $result['MaCN']?>"> <?php echo $result['TenCN']?></option>
                            <?php
                                }
                            }   
                            ?>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Tên</label>
                    </td>
                    <td>
                        <input type="text" name="TenTour" value="<?php echo $result_product['TenTour']?>" class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Số khách tối thiểu</label>
                    </td>
                    <td>
                        <input type="text" name="SoKhachTourToiThieu" value="<?php echo $result_product['SoKhachTourToiThieu']?>" class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Số khách tối đa</label>
                    </td>
                    <td>
                        <input type="text" name="SoKhachTourToiDa" value="<?php echo $result_product['SoKhachTourToiDa']?>" class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Giá vé lẻ người lớn</label></label>
                    </td>
                    <td>
                        <input type="text" name="GiaVeLeNguoiLon" value="<?php echo $result_product['GiaVeLeNguoiLon']?>" class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Giá vé lẻ trẻ em</label></label>
                    </td>
                    <td>
                        <input type="text" name="GiaVeLeTreEm" value="<?php echo $result_product['GiaVeLeTreEm']?>" class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Giá vé đoàn người lớn</label></label>
                    </td>
                    <td>
                        <input type="text" name="GiaVeDoanNguoiLon" value="<?php echo $result_product['GiaVeDoanNguoiLon']?>" class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Giá vé đoàn trẻ em</label></label>
                    </td>
                    <td>
                        <input type="text" name="GiaVeDoanTreEm" value="<?php echo $result_product['GiaVeDoanTreEm']?>" class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Số khách đoàn tối thiểu</label></label>
                    </td>
                    <td>
                        <input type="text" name="SoKhachDoanToiThieu" value="<?php echo $result_product['SoKhachDoanToiThieu']?>" class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Số đêm</label></label>
                    </td>
                    <td>
                        <input type="text" name="SoDem" value="<?php echo $result_product['SoDem']?>" class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Số ngày</label></label>
                    </td>
                    <td>
                        <input type="text" name="SoNgay" value="<?php echo $result_product['SoNgay']?>" class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Hình ảnh</label>
                    </td>
                    <td>
                        <image src ="uploads/<?php echo $result_product['image']?>" width="90"><br>
                        <input type="file" name="image"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Ngày bắt đầu</label>
                    </td>
                    <td>
                    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

                    <label for="datepicker">Select a date:</label>
                    <input type="text" id="datepicker" name="NgayBatDau" value="<?php echo $result_product['NgayBatDau']?>">
                    </form>

                    <!-- Include jQuery library -->
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

                    <!-- Include jQuery UI library -->
                    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

                    <script>
                    $(document).ready(function(){
                        $("#datepicker").datepicker({
                            dateFormat: "dd/mm/yy"
                        });
                    });
                    </script>
                    </td>
                </tr>
				<tr>
                    <td></td>
                    <td>
                        <input type="submit" name="submit" Value="Update" />
                    </td>
                </tr> 
            </table>
        </form>
        <?php
        }
    }
        ?>
        </div>
    </div>
</div>
<!-- Load TinyMCE -->
<script src="js/tiny-mce/jquery.tinymce.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        setupTinyMCE();
        setDatePicker('date-picker');
        $('input[type="checkbox"]').fancybutton();
        $('input[type="radio"]').fancybutton();
    });
</script>
<!-- Load TinyMCE -->
<?php include 'inc/footer.php';?>


