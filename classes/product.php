<?php
    include_once '../lib/database.php';
    include_once '../helpers/format.php'
?>
<?php
    class product
    {
        private $db;
        private $fm;
        public function __construct()
        {
            $this->db = new Database();
            $this->fm = new Format();
        }
        public function insert_product($data, $files)
        {
            $category = mysqli_real_escape_string($this->db->link, $data['category']); //ChiNhanh
            $TenTour = mysqli_real_escape_string($this->db->link, $data['TenTour']); //connect DB
            $SoKhachTourToiThieu = mysqli_real_escape_string($this->db->link, $data['SoKhachTourToiThieu']); 
            $SoKhachTourToiDa = mysqli_real_escape_string($this->db->link, $data['SoKhachTourToiDa']); 
            $GiaVeLeNguoiLon = mysqli_real_escape_string($this->db->link, $data['GiaVeLeNguoiLon']); 
            $GiaVeLeTreEm = mysqli_real_escape_string($this->db->link, $data['GiaVeLeTreEm']);
            $GiaVeDoanNguoiLon = mysqli_real_escape_string($this->db->link, $data['GiaVeDoanNguoiLon']);
            $GiaVeDoanTreEm = mysqli_real_escape_string($this->db->link, $data['GiaVeDoanTreEm']);
            $SoKhachDoanToiThieu = mysqli_real_escape_string($this->db->link, $data['SoKhachDoanToiThieu']); 
            $SoDem = mysqli_real_escape_string($this->db->link, $data['SoDem']); 
            $SoNgay = mysqli_real_escape_string($this->db->link, $data['SoNgay']); 
            $NgayBatDau = mysqli_real_escape_string($this->db->link, $data['NgayBatDau']); 
            
            //kiem tra hinh anh va lay hinh anh cho vao folder uploads
            $permited = array('jpg','jpeg','png','gif');
            $file_name = $_FILES['image']['name'];
            $file_size = $_FILES['image']['size'];
            $file_temp = $_FILES['image']['tmp_name'];

            $div = explode('.', $file_name);
            $file_ext = strtolower(end($div));
            $unique_image = substr(md5(time()), 0, 10).'.'.$file_ext;
            $uploaded_image = "uploads/".$unique_image;

            if($category =="" || $TenTour =="" || $SoKhachTourToiThieu =="" || $SoKhachTourToiDa =="" || $GiaVeLeNguoiLon =="" || $GiaVeLeTreEm =="" || 
            $GiaVeDoanNguoiLon =="" || $GiaVeDoanTreEm =="" || $SoKhachDoanToiThieu =="" || $SoDem =="" || $SoNgay =="" || $NgayBatDau =="" || $file_name =="")
            {
                $alert = "<span class= 'error'>Fields must be not empty</span>";
                return $alert;
            }
            elseif($GiaVeDoanTreEm >= $GiaVeDoanNguoiLon || $GiaVeLeTreEm >= $GiaVeLeNguoiLon || $GiaVeDoanNguoiLon >= $GiaVeLeNguoiLon ||
            $GiaVeDoanTreEm >= $GiaVeLeTreEm || $SoKhachTourToiThieu >= $SoKhachTourToiDa)
            {
                $alert = "<span class= 'error'>Exists the value of some invalid field</span>";
                return $alert;
            }
            else
            {
                move_uploaded_file($file_temp, $uploaded_image);
                $query = "INSERT INTO tour(MaCN, TenTour, SoKhachTourToiThieu, SoKhachTourToiDa, GiaVeLeNguoiLon, GiaVeLeTreEm, 
                GiaVeDoanNguoiLon, GiaVeDoanTreEm, SoKhachDoanToiThieu, SoDem, SoNgay, NgayBatDau, image) 
                VALUES('$category','$TenTour','$SoKhachTourToiThieu','$SoKhachTourToiDa','$GiaVeLeNguoiLon','$GiaVeLeTreEm',
                '$GiaVeDoanNguoiLon','$GiaVeDoanTreEm','$SoKhachDoanToiThieu','$SoDem','$SoNgay','$NgayBatDau','$unique_image')"; //CONNECT DB

                $result = $this->db->insert($query); //Process DB
                if($result)
                {
                    $alert = "<span class= 'success'>Insert Tour Successfully</span>";
                    return $alert;
                }
                else
                {
                    $alert = "<span class= 'error'>Insert Tour Not Success</span>";
                    return $alert;
                }
            }
        }
        public function show_product()
        {
            $query = "SELECT tour.*, chinhanh.TenCN
            FROM tour 
            INNER JOIN chinhanh ON tour.MaCN = chinhanh.MaCN
            order by tour.MaTour desc";

            //$query = "SELECT * FROM tbl_product order by productId desc"; //CONNECT DB
            $result = $this->db->select($query); //Process DB
            return $result;
        }
        public function update_product($data, $files, $id){

            $category = mysqli_real_escape_string($this->db->link, $data['category']); //ChiNhanh
            $TenTour = mysqli_real_escape_string($this->db->link, $data['TenTour']); //connect DB
            $SoKhachTourToiThieu = mysqli_real_escape_string($this->db->link, $data['SoKhachTourToiThieu']); 
            $SoKhachTourToiDa = mysqli_real_escape_string($this->db->link, $data['SoKhachTourToiDa']); 
            $GiaVeLeNguoiLon = mysqli_real_escape_string($this->db->link, $data['GiaVeLeNguoiLon']); 
            $GiaVeLeTreEm = mysqli_real_escape_string($this->db->link, $data['GiaVeLeTreEm']);
            $GiaVeDoanNguoiLon = mysqli_real_escape_string($this->db->link, $data['GiaVeDoanNguoiLon']);
            $GiaVeDoanTreEm = mysqli_real_escape_string($this->db->link, $data['GiaVeDoanTreEm']);
            $SoKhachDoanToiThieu = mysqli_real_escape_string($this->db->link, $data['SoKhachDoanToiThieu']); 
            $SoDem = mysqli_real_escape_string($this->db->link, $data['SoDem']); 
            $SoNgay = mysqli_real_escape_string($this->db->link, $data['SoNgay']); 
            $NgayBatDau = mysqli_real_escape_string($this->db->link, $data['NgayBatDau']); 
            
            //kiem tra hinh anh va lay hinh anh cho vao folder uploads
            $permited = array('jpg','jpeg','png','gif');
            $file_name = $_FILES['image']['name'];
            $file_size = $_FILES['image']['size'];
            $file_temp = $_FILES['image']['tmp_name'];

            $div = explode('.', $file_name);
            $file_ext = strtolower(end($div));
            $unique_image = substr(md5(time()), 0, 10).'.'.$file_ext;
            $uploaded_image = "uploads/".$unique_image;

            if($category =="" || $TenTour =="" || $SoKhachTourToiThieu =="" || $SoKhachTourToiDa =="" || $GiaVeLeNguoiLon =="" || $GiaVeLeTreEm =="" || 
            $GiaVeDoanNguoiLon =="" || $GiaVeDoanTreEm =="" || $SoKhachDoanToiThieu =="" || $SoDem =="" || $SoNgay =="" || $NgayBatDau =="")
            {
                $alert = "<span class= 'error'>Fields must be not empty</span>";
                return $alert;
            }
            elseif($GiaVeDoanTreEm >= $GiaVeDoanNguoiLon || $GiaVeLeTreEm >= $GiaVeLeNguoiLon || $GiaVeDoanNguoiLon >= $GiaVeLeNguoiLon ||
            $GiaVeDoanTreEm >= $GiaVeLeTreEm || $SoKhachTourToiThieu >= $SoKhachTourToiDa)
            {
                $alert = "<span class= 'error'>Exists the value of some invalid field</span>";
                    return $alert;
            }
            else
            {
                if(!empty($file_name)){ //neu nguoi dung chon anh
                    if($file_size > 2048000){ //20MB
                        $alert = "<span class= 'error'>Image Size should be less then 20MB!</span>";
                        return $alert;
                    }elseif(in_array($file_ext, $permited) === false){
                        //echo "<span class='error'>You can upload only:-".implode(',', $permited)."</span>";
                        $alert = "<span class= 'error'>You can upload only:-".implode(',', $permited)."</span>";
                        return $alert;
                    }
                    $query = "UPDATE tour SET 
                    MaCN = '$category',
                    TenTour = '$TenTour',
                    SoKhachTourToiThieu = '$SoKhachTourToiThieu',
                    SoKhachTourToiDa = '$SoKhachTourToiDa', 
                    GiaVeLeNguoiLon = '$GiaVeLeNguoiLon', 
                    GiaVeLeTreEm = '$GiaVeLeTreEm',
                    GiaVeDoanNguoiLon = '$GiaVeDoanNguoiLon',
                    GiaVeDoanTreEm = '$GiaVeDoanTreEm',
                    SoKhachDoanToiThieu = '$SoKhachDoanToiThieu', 
                    SoDem = '$SoDem', 
                    SoNgay = '$SoNgay',
                    NgayBatDau = '$NgayBatDau',
                    image = '$unique_image'
                    WHERE MaTour = '$id'";
                }
                else{ //neu nguoi dung khong chon anh
                    $query = "UPDATE tour SET 
                    MaCN = '$category',
                    TenTour = '$TenTour',
                    SoKhachTourToiThieu = '$SoKhachTourToiThieu',
                    SoKhachTourToiDa = '$SoKhachTourToiDa', 
                    GiaVeLeNguoiLon = '$GiaVeLeNguoiLon', 
                    GiaVeLeTreEm = '$GiaVeLeTreEm',
                    GiaVeDoanNguoiLon = '$GiaVeDoanNguoiLon',
                    GiaVeDoanTreEm = '$GiaVeDoanTreEm',
                    SoKhachDoanToiThieu = '$SoKhachDoanToiThieu', 
                    SoDem = '$SoDem', 
                    SoNgay = '$SoNgay',
                    NgayBatDau = '$NgayBatDau'
                    WHERE MaTour = '$id'";
                }   
            }
            $result = $this->db->update($query); //Process DB
            if($result)
            {
                $alert = "<span class= 'success'>Tour Updated Successfully</span>";
                return $alert;
            }
            else
            {
                $alert = "<span class= 'error'>Tour Updated Not Success</span>";
                return $alert;
            }
        }
        public function del_product($id){
            $query = "DELETE FROM tour where MaTour = '$id' "; //CONNECT DB
            $result = $this->db->delete($query); //Process DB
            if($result)
            {
                $alert = "<span class= 'success'>Tour Deleted Successfully</span>";
                return $alert;
            }
            else
            {
                $alert = "<span class= 'error'>Tour Deleted Not Success</span>";
                return $alert;
            }
        }
        public function getproductbyId($id){
            $query = "SELECT * FROM tour where MaTour = '$id' "; //CONNECT DB
            $result = $this->db->select($query); //Process DB
            return $result;
        }
    }
?>