<?php

/**
 * Class to handle all db operations
 * This class will have CRUD methods for database tables
 *
 * @author NwP
 * @link URL Tutorial link
 */
class DbHandler {

    private $conn;

    function __construct() {
        require_once dirname(__FILE__) . '/DbConnect.php';
// opening db connection
        $db = new DbConnect();
        $this->conn = $db->connect();
    }

    /**
     * Checking user login
     * @param String $email User login email id
     * @param String $password User login password
     * @return boolean User login status success/fail
     */
    public function checkLogin($email, $password) {
        // fetching user by email
        $pass_hash = md5($password);

        $query = "SELECT password FROM mahasiswa WHERE email = ? UNION SELECT password FROM dosen WHERE email = ?";

        $stmt = $this->conn->prepare($query);

        $stmt->bind_param("ss", $email, $email);

        $stmt->execute();

        $stmt->bind_result($password_hash);

        $stmt->store_result();

        if ($stmt->num_rows > 0) {
            // Found user with the email
            // Now verify the password

            $stmt->fetch();

            $stmt->close();

            if (PassHash::check_password($password_hash, $pass_hash)) {
                // User password is correct
                return TRUE;
            } else {
                // user password is incorrect
                return FALSE;
            }
        } else {
            $stmt->close();

            // user not existed with the email
            return FALSE;
        }
    }

    /**
     * Checking for duplicate user by email address
     * @param String $email

      email to check in db
     * @return boolean
     */
    private function isUserExists($email) {
        $stmt = $this->conn->prepare("SELECT nim from mahasiswa WHERE email = ? UNION SELECT nik from dosen WHERE email = ?");
        $stmt->bind_param("ss", $email, $email);
        $stmt->execute();
        $stmt->store_result();
        $num_rows = $stmt->num_rows;
        $stmt->close();
        return $num_rows > 0;
    }

    /**
     * Fetching mahasiswa by email
     * @param String $email

      User email id
     */
    public function getUserByEmail($email) {
        $stmt = $this->conn->prepare("SELECT nim, nama_mhs, level "
                . "FROM mahasiswa "
                . "WHERE email = ? "
                . "UNION SELECT nim, nama_dosen, level "
                . "FROM dosen "
                . "WHERE email = ?");
        $stmt->bind_param("ss", $email, $email);
        if ($stmt->execute()) {
            // $user = $stmt->get_result()->fetch_assoc();
            $stmt->bind_result($id, $nama, $level);
            $stmt->fetch();
            $user = array();
            $user["id"] = $id;
            $user["nama"] = $nama;
            $user["level"] = $level;
            $stmt->close();
            return $user;
        } else {
            return NULL;
        }
    }

    /**
     * Fetching mahasiswa by email
     * @param String $email

      User email id
     */
    public function getMahasiswaByEmail($email) {
        $stmt = $this->conn->prepare("SELECT nim, nama_mhs, no_hp, email FROM mahasiswa WHERE email = ?");
        $stmt->bind_param("s", $email);
        if ($stmt->execute()) {
            // $user = $stmt->get_result()->fetch_assoc();
            $stmt->bind_result($nim, $nama_mhs, $no_hp, $email);
            $stmt->fetch();
            $mhs = array();
            $mhs["nim"] = $nim;
            $mhs["nama_mhs"] = $nama_mhs;
            $mhs["no_hp"] = $no_hp;
            $mhs["email"] = $email;
            $stmt->close();
            return $mhs;
        } else {
            return NULL;
        }
    }

    /**
     * Fetching dosen by email
     * @param String $email

      User email id
     */
    public function getDosenByEmail($email) {
        $stmt = $this->conn->prepare("SELECT nik, nama_dosen, no_hp, email FROM dosen WHERE email = ?");
        $stmt->bind_param("s", $email);
        if ($stmt->execute()) {
            // $user = $stmt->get_result()->fetch_assoc();
            $stmt->bind_result($nik, $nama_dosen, $no_hp, $email);
            $stmt->fetch();
            $dosen = array();
            $dosen["nik"] = $nik;
            $dosen["nama_dosen"] = $nama_dosen;
            $dosen["no_hp"] = $no_hp;
            $dosen["email"] = $email;
            $dosen->close();
            return $dosen;
        } else {
            return NULL;
        }
    }

    /**
     * Generating random Unique MD5 String for user Api key
     */
    private function generateApiKey() {
        return md5(uniqid(rand(), true));
    }

    /**
     * get mata kuliah
     * @param type $id
     * @return type
     */
    public function getMK($id) {
        $stmt = $this->conn->prepare("SELECT mhs.nim, mhs.nama_mhs, mk.kode_mk, mk.nama_mk, mk.sks "
                . "FROM matakuliah mk, mahasiswa mhs, mahasiswa_ambil_mk ma "
                . "WHERE mhs.nim = ? AND mhs.nim = ma.nim "
                . "UNION SELECT d.nik, d.nama_dosen, mk.kode_mk, mk.nama_mk, mk.sks "
                . "FROM matakuliah mk, dosen d, dosen_ambil_mk da "
                . "WHERE d.nik = ? AND da.nik = d.nik AND da.kode_mk = mk.kode_mk");
        $stmt->bind_param("ss", $id, $id);

        if ($stmt->execute()) {
            $res = array();
            $stmt->bind_result($id, $nama, $kode_mk, $nama_mk, $sks);
            // TODO
            // $task = $stmt->get_result()->fetch_assoc();
            $stmt->fetch();
            $res["id"] = $id;
            $res["nama"] = $nama;
            $res["kode_mk"] = $kode_mk;
            $res["nama_mk"] = $nama_mk;
            $res["sks"] = $sks;
            $stmt->close();
            return $res;
        } else {
            return NULL;
        }
    }

    /**
     * get materi
     * @param type $kode_mk
     * @param type $id
     * @return type
     */
    public function getMateri($kode_mk, $id) {
        $stmt = $this->conn->prepare("SELECT mhs.nim, mk.kode_mk, mt.id_materi, mt.judul_materi, mt.deskripsi, mt.link_materi, mt.tanggal_upload "
                . "FROM matakuliah mk, mahasiswa mhs, mahasiswa_ambil_mk ma, materi mt, dosen_ambil_mk da, dosen d "
                . "WHERE mhs.nim = ? AND mk.kode_mk = ? AND mhs.nim = ma.nim AND mt.kode_mk = mk.kode_mk AND mt.nik = da.nik AND ma.kode_mk = mk.kode_mk AND da.nik = d.nik AND da.kode_mk = mk.kode_mk "
                . "UNION SELECT d.nik, mk.kode_mk, mt.id_materi, mt.judul_materi, mt.deskripsi, mt.link_materi, mt.tanggal_upload "
                . "FROM matakuliah mk, materi mt, dosen_ambil_mk da, dosen d "
                . "WHERE d.nik = ? AND mk.kode_mk = ? AND mt.kode_mk = mk.kode_mk AND mt.nik = da.nik AND da.nik = d.nik");
        $stmt->bind_param("ssss", $id, $kode_mk, $id, $kode_mk);
        if ($stmt->execute()) {
            $res = array();
            $stmt->bind_result($id, $kode_mk, $id_materi, $judul_materi, $deskripsi, $link_materi, $tanggal_upload);
            // TODO
            // $task = $stmt->get_result()->fetch_assoc();
            $stmt->fetch();
            $res["id"] = $id;
            $res["kode_mk"] = $kode_mk;
            $res["id_materi"] = $id_materi;
            $res["judul_materi"] = $judul_materi;
            $res["deskripsi"] = $deskripsi;
            $res["link_materi"] = $link_materi;
            $res["tanggal_upload"] = $tanggal_upload;
            $stmt->close();
            return $res;
        } else {
            return NULL;
        }
    }

    public function createMateri($kode_mk, $id, $judul, $desk, $link, $tanggal) {
        $stmt = $this->conn->prepare("INSERT INTO materi (id_materi, nik, kode_mk, judul_materi, deskripsi, link_materi, tanggal_upload) "
                . "VALUES (NULL, ?, ?, ?, ?, ?, ?);");
        $stmt->bind_param("sssssi", $id, $kode_mk, $judul, $desk, $link, $tanggal);
        $result = $stmt->execute();

        if (false === $result) {
            die('execute() failed: ' . htmlspecialchars($stmt->error));
        }
        $stmt->close();
        return $result;
    }

}

?>
