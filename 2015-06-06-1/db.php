<?php
	
// Alan Badillo Salas
// @badillosoft | badillo.soft@hotmail.com
	
class DataBase {
	public $conn = null;
	public $result = null;
	public $result_2 = null;
	
	public $err = false;
	public $err_no = 0;
	public $message = '';
	
	public $kill = true;
	
	var $host = 'localhost';
	var $user_name = 'root';
	var $password = '';
	var $db_name = 'test';
	
	public function __construct(
		$host = 'localhost', $user_name = 'root',
		$password = '', $db_name = 'test') {
		$this->connect($host, $user_name, $password, $db_name);
	}
	
	function open() {
		$this->conn = mysql_connect($this->host, $this->user_name, $this->password);
		
		if ($this->conn == null) {
			$this->err = true;
			$this->err_no = 1;
			$this->message = 'One problem occur with the connection';
			
			if ($this->kill) {
				echo json_encode(
					array(
						'error' => $this->err,
						'error_no' => $this->err_no,
						'message' => $this->message
					)
				);
				exit();
			}
			
			return;
		}
		
		if (!mysql_select_db($this->db_name, $this->conn)) {
			$this->err = true;
			$this->err_no = 2;
			$this->message = $this->db_name . " doesn't exists";
			
			if ($this->kill) {
				echo json_encode(
					array(
						'error' => $this->err,
						'error_no' => $this->err_no,
						'message' => $this->message
					)
				);
				exit();
			}
			
			return;
		}
	}
	
	function connect($host, $user_name, $password, $db_name) {
		if ($host != null) {
			$this->host = $host;
		}
		
		if ($user_name != null) {
			$this->user_name = $user_name;
		}
		
		if ($password != null) {
			$this->password = $password;
		}
		
		if ($db_name != null) {
			$this->db_name = $db_name;
		}
	}
	
	function close() {
		if ($this->conn != null) {
			mysql_close($this->conn);
		}
	}
	
	function query($q) {
		$this->result = mysql_query($q, $this->conn);
		
		if ($this->result == null || mysql_num_rows($this->result) <= 0) {
			$this->err = true;
			$this->err_no = 3;
			$this->message = "Query error: [$q]";
			
			if ($this->kill) {
				echo json_encode(
					array(
						'error' => $this->err,
						'error_no' => $this->err_no,
						'message' => $this->message
					)
				);
				exit();
			}
		}
		
		$data = array();
		
		while ($row = mysql_fetch_assoc($this->result)) {
			$data[] = $row;
		}
		
		return $data;
	}
	
	function query2($q, $generate_q2) {
		$this->result = mysql_query($q, $this->conn);
		
		if ($this->result == null || mysql_num_rows($this->result) <= 0) {
			$this->err = true;
			$this->err_no = 3;
			$this->message = "Query error: [$q]";
			
			if ($this->kill) {
				echo json_encode(
					array(
						'error' => $this->err,
						'error_no' => $this->err_no,
						'message' => $this->message,
						'data' => array()
					)
				);
				exit();
			}
			
			return array();
		}
		
		$data = array();
		
		while ($row = mysql_fetch_assoc($this->result)) {
			$q2 = $generate_q2($row);
			
			echo $q2;
			
			$this->result_2 = mysql_query($q2, $this->conn);
		
			if (mysql_num_rows($this->result_2) > 0) {
				while ($row_2 = mysql_fetch_assoc($this->result_2)) {
					$data[] = array('primary' => $row, 'secondary' => $row_2);
				}
			} else {
				$data[] = array('primary' => $row, 'secondary' => array());
			}
		}
		
		return $data;
	}
}

?>