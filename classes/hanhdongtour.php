<?php
    include_once '../lib/database.php';
    include_once '../helpers/format.php'
?>
<?php
    class hanhdong
    {
        private $db;
        private $fm;
        public function __construct()
        {
            $this->db = new Database();
            $this->fm = new Format();
        }
        
        public function show_hd()
        {
            $query = "SELECT lichtrinhtour.*
            FROM lichtrinhtour 
            order by lichtrinhtour.MaTour desc";

            //$query = "SELECT * FROM tbl_product order by productId desc"; //CONNECT DB
            $result = $this->db->select($query); //Process DB
            return $result;
        }
        
        public function getproductbyId($id){
            $query = "SELECT * FROM tour where MaTour = '$id' "; //CONNECT DB
            $result = $this->db->select($query); //Process DB
            return $result;
        }
    }
?>