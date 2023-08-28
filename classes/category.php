<?php
    include_once '../lib/database.php';
    include_once '../helpers/format.php';
?>
<?php
    class category
    {
        private $db;
        private $fm;
        public function __construct()
        {
            $this->db = new Database();
            $this->fm = new Format();
        }
        public function insert_category($catName)
        {
            $catName = $this->fm->validation($catName); //check valid value
            $catName = mysqli_real_escape_string($this->db->link, $catName); //connect DB

            if(empty($catName))
            {
                $alert = "<span class= 'error'>Department must be not empty</span>";
                return $alert;
            }
            else
            {
                $query = "INSERT INTO tbl_category(catName) VALUES('$catName')"; //CONNECT DB
                $result = $this->db->insert($query); //Process DB
                if($result)
                {
                    $alert = "<span class= 'success'>Insert Department Successfully</span>";
                    return $alert;
                }
                else
                {
                    $alert = "<span class= 'error'>Insert Department Not Success</span>";
                    return $alert;
                }
            }
        }
        public function show_category()
        {
            $query = "SELECT * FROM chinhanh order by MaCN desc"; //CONNECT DB
            $result = $this->db->select($query); //Process DB
            return $result;
        }
        public function update_category($catName, $id){
            $catName = $this->fm->validation($catName); //check valid value
            $catName = mysqli_real_escape_string($this->db->link, $catName); //connect DB
            $id = mysqli_real_escape_string($this->db->link, $id); //connect DB

            if(empty($catName))
            {
                $alert = "<span class= 'error'>Department must be not empty</span>";
                return $alert;
            }
            else
            {
                $query = "UPDATE tbl_category SET catName = '$catName' WHERE catId = '$id'"; //CONNECT DB
                $result = $this->db->update($query); //Process DB
                if($result)
                {
                    $alert = "<span class= 'success'>Department Updated Successfully</span>";
                    return $alert;
                }
                else
                {
                    $alert = "<span class= 'error'>Department Updated Not Success</span>";
                    return $alert;
                }
            }
        }
        public function del_category($id){
            $query = "DELETE FROM tbl_category where catId = '$id' "; //CONNECT DB
            $result = $this->db->delete($query); //Process DB
            if($result)
            {
                $alert = "<span class= 'success'>Department Deleted Successfully</span>";
                return $alert;
            }
            else
            {
                $alert = "<span class= 'error'>Department Deleted Not Success</span>";
                return $alert;
            }
        }
        public function getcatbyId($id){
            $query = "SELECT * FROM tbl_category where catId = '$id' "; //CONNECT DB
            $result = $this->db->select($query); //Process DB
            return $result;
        }
    }
?>