<?php include 'inc/header.php';?>
<?php include 'inc/sidebar.php';?>
<?php include '../classes/category.php';?>
<?php include '../classes/product.php';?>

<?php
	$pd = new product();
	if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['submit'])) //submit moi Save
	{
		$insertProduct = $pd->insert_product($_POST, $_FILES); //_FILES: Them hinh anh, _POST: lat all data khi submit
	}
?>

<div class="grid_10">
    <div class="box round first grid">
        <h2>Thêm Tour</h2>
        <div class="block">
        <?php
            if(isset($insertProduct))
            {
                echo $insertProduct; #thong bao
            }
        ?>                  
        <form action="productadd.php" method="post" enctype="multipart/form-data">
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
                            <option value="<?php echo $result['MaCN']?>"> <?php echo $result['TenCN']?></option>
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
                        <input type="text" name="TenTour" placeholder="Nhập tên Tour..." class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Số khách tối thiểu</label>
                    </td>
                    <td>
                        <input type="text" name="SoKhachTourToiThieu" placeholder="Nhập số khách tối thiểu..." class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Số khách tối đa</label>
                    </td>
                    <td>
                        <input type="text" name="SoKhachTourToiDa" placeholder="Nhập số khách tối đa..." class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Giá vé lẻ người lớn</label></label>
                    </td>
                    <td>
                        <input type="text" name="GiaVeLeNguoiLon" placeholder="Nhập giá vé lẻ người lớn..." class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Giá vé lẻ trẻ em</label></label>
                    </td>
                    <td>
                        <input type="text" name="GiaVeLeTreEm" placeholder="Nhập giá vé lẻ trẻ em..." class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Giá vé đoàn người lớn</label></label>
                    </td>
                    <td>
                        <input type="text" name="GiaVeDoanNguoiLon" placeholder="Nhập giá vé đoàn người lớn..." class="medium"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Giá vé đoàn trẻ em</label></label>
                    </td>
                    <td>
                        <input type="text" name="GiaVeDoanTreEm" placeholder="Nhập giá vé đoàn trẻ em..." class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Số khách đoàn tối thiểu</label></label>
                    </td>
                    <td>
                        <input type="text" name="SoKhachDoanToiThieu" placeholder="Nhập số khách đoàn tối thiểu..." class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Số đêm</label></label>
                    </td>
                    <td>
                        <input type="text" name="SoDem" placeholder="Nhập số đêm..." class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Số ngày</label></label>
                    </td>
                    <td>
                        <input type="text" name="SoNgay" placeholder="Nhập số ngày..." class="medium" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Hình ảnh</label>
                    </td>
                    <td>
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
                    <input type="text" id="datepicker" name="NgayBatDau">
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
                        <input type="submit" name="submit" Value="Save" />
                    </td>
                </tr> 
            </table>
        </form>
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


