-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 04 Sep 2015 pada 23.33
-- Versi Server: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mobilelearning`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen`
--

CREATE TABLE IF NOT EXISTS `dosen` (
`id_dosen` int(11) NOT NULL,
  `nik` varchar(30) NOT NULL,
  `nama_dosen` varchar(40) NOT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(250) NOT NULL,
  `level` enum('mhs','dosen','','') NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data untuk tabel `dosen`
--

INSERT INTO `dosen` (`id_dosen`, `nik`, `nama_dosen`, `no_hp`, `email`, `password`, `level`) VALUES
(1, '1103138477', 'Dosen 1', '085647714245', 'dosen1@email.com', 'f499263a253447dd5cb68dafb9f13235', 'dosen'),
(2, '1103138478', 'Dosen 2', '085647714245', 'dosen2@email.com', 'ac41c4e0e6ef7ac51f0c8f3895f82ce5', 'dosen');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen_ambil_mk`
--

CREATE TABLE IF NOT EXISTS `dosen_ambil_mk` (
`id_dosen_ambil_mk` int(11) NOT NULL,
  `kode_mk` varchar(11) NOT NULL,
  `nik` varchar(30) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data untuk tabel `dosen_ambil_mk`
--

INSERT INTO `dosen_ambil_mk` (`id_dosen_ambil_mk`, `kode_mk`, `nik`) VALUES
(1, 'MK001', '1103138477'),
(2, 'MK002', '1103138478'),
(3, 'MK003', '1103138477');

-- --------------------------------------------------------

--
-- Struktur dari tabel `forum`
--

CREATE TABLE IF NOT EXISTS `forum` (
`id_forum` int(11) NOT NULL,
  `id_dosen_mhs` int(11) NOT NULL,
  `isi_chat` text NOT NULL,
  `tanggal_chat` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE IF NOT EXISTS `mahasiswa` (
`id_mhs` int(11) NOT NULL,
  `nim` varchar(15) NOT NULL,
  `nama_mhs` varchar(40) NOT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `password` varchar(250) NOT NULL,
  `level` enum('mhs','dosen','','') NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data untuk tabel `mahasiswa`
--

INSERT INTO `mahasiswa` (`id_mhs`, `nim`, `nama_mhs`, `no_hp`, `email`, `password`, `level`) VALUES
(1, '613101049', 'Mahasiswa 1', '085647714245', 'mhs1@email.com', '8eac357684eb8c36513235c7e77bfdfb', 'mhs'),
(2, '613101050', 'Mahasiswa 2', '085647714245', 'mhs2@email.com', '01484c79145c559ee6e3c9790ba6a1bb', 'mhs');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa_ambil_mk`
--

CREATE TABLE IF NOT EXISTS `mahasiswa_ambil_mk` (
`id_ambil_mhs_mk` int(11) NOT NULL,
  `nim` varchar(15) NOT NULL,
  `id_periode` int(11) NOT NULL,
  `kode_mk` varchar(10) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data untuk tabel `mahasiswa_ambil_mk`
--

INSERT INTO `mahasiswa_ambil_mk` (`id_ambil_mhs_mk`, `nim`, `id_periode`, `kode_mk`) VALUES
(1, '613101049', 1, 'MK001'),
(2, '613101049', 1, 'MK002');

-- --------------------------------------------------------

--
-- Struktur dari tabel `matakuliah`
--

CREATE TABLE IF NOT EXISTS `matakuliah` (
`id_mk` int(11) NOT NULL,
  `kode_mk` varchar(10) NOT NULL,
  `nama_mk` varchar(100) NOT NULL,
  `sks` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data untuk tabel `matakuliah`
--

INSERT INTO `matakuliah` (`id_mk`, `kode_mk`, `nama_mk`, `sks`) VALUES
(1, 'MK001', 'Algoritma dan Pemrograman', 4),
(2, 'MK002', 'Kalkulus 1', 4),
(3, 'MK003', 'Basis Data', 4),
(4, 'MK004', 'Sistem Informasi', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `materi`
--

CREATE TABLE IF NOT EXISTS `materi` (
`id_materi` int(11) NOT NULL,
  `nik` varchar(30) NOT NULL,
  `kode_mk` varchar(15) NOT NULL,
  `judul_materi` varchar(40) NOT NULL,
  `deskripsi` text NOT NULL,
  `link_materi` text NOT NULL,
  `tanggal_upload` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data untuk tabel `materi`
--

INSERT INTO `materi` (`id_materi`, `nik`, `kode_mk`, `judul_materi`, `deskripsi`, `link_materi`, `tanggal_upload`) VALUES
(1, '1103138477', 'MK001', 'Materi 1', 'Ini Materi 1', 'asdf', '2015-09-04 17:00:00'),
(2, '1103138478', 'MK002', 'Materi 2', 'Ini MAteri 2', 'asdf', '2015-09-04 17:00:00'),
(3, '1103138477', 'MK003', 'Materi 3', 'Ini Materi 3', 'asdf', '2015-09-04 20:29:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `periode`
--

CREATE TABLE IF NOT EXISTS `periode` (
`id_periode` int(11) NOT NULL,
  `tahun` varchar(11) NOT NULL,
  `semester` int(1) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data untuk tabel `periode`
--

INSERT INTO `periode` (`id_periode`, `tahun`, `semester`) VALUES
(1, '2015/2016', 1),
(2, '2015/2016', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `quiz`
--

CREATE TABLE IF NOT EXISTS `quiz` (
`id_quiz` int(11) NOT NULL,
  `nik` varchar(30) NOT NULL,
  `kode_mk` varchar(10) NOT NULL,
  `judul_quiz` varchar(100) NOT NULL,
  `tanggal_upload` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `quiz_jawaban`
--

CREATE TABLE IF NOT EXISTS `quiz_jawaban` (
`id_jawab` int(11) NOT NULL,
  `nim` varchar(15) NOT NULL,
  `id_quiz_soal` int(11) NOT NULL,
  `index_soal` int(11) NOT NULL,
  `jawaban` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `quiz_soal`
--

CREATE TABLE IF NOT EXISTS `quiz_soal` (
`id_quiz_soal` int(11) NOT NULL,
  `id_quiz` int(11) NOT NULL,
  `index_pertanyaan` int(11) NOT NULL,
  `pertanyaan` text NOT NULL,
  `jawaban_a` text NOT NULL,
  `jawaban_b` text NOT NULL,
  `jawaban_c` text NOT NULL,
  `jawaban_d` text NOT NULL,
  `jawaban_benar` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
 ADD PRIMARY KEY (`id_dosen`), ADD UNIQUE KEY `nik` (`nik`);

--
-- Indexes for table `dosen_ambil_mk`
--
ALTER TABLE `dosen_ambil_mk`
 ADD PRIMARY KEY (`id_dosen_ambil_mk`), ADD KEY `nik` (`nik`), ADD KEY `kode_mk` (`kode_mk`);

--
-- Indexes for table `forum`
--
ALTER TABLE `forum`
 ADD PRIMARY KEY (`id_forum`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
 ADD PRIMARY KEY (`id_mhs`), ADD UNIQUE KEY `nim` (`nim`);

--
-- Indexes for table `mahasiswa_ambil_mk`
--
ALTER TABLE `mahasiswa_ambil_mk`
 ADD PRIMARY KEY (`id_ambil_mhs_mk`), ADD KEY `nim` (`nim`), ADD KEY `id_periode` (`id_periode`), ADD KEY `kode_mk` (`kode_mk`);

--
-- Indexes for table `matakuliah`
--
ALTER TABLE `matakuliah`
 ADD PRIMARY KEY (`id_mk`), ADD UNIQUE KEY `kode_mk` (`kode_mk`);

--
-- Indexes for table `materi`
--
ALTER TABLE `materi`
 ADD PRIMARY KEY (`id_materi`), ADD KEY `nik` (`nik`), ADD KEY `kode_mk` (`kode_mk`);

--
-- Indexes for table `periode`
--
ALTER TABLE `periode`
 ADD PRIMARY KEY (`id_periode`);

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
 ADD PRIMARY KEY (`id_quiz`), ADD KEY `nik` (`nik`), ADD KEY `kode_mk` (`kode_mk`);

--
-- Indexes for table `quiz_jawaban`
--
ALTER TABLE `quiz_jawaban`
 ADD PRIMARY KEY (`id_jawab`), ADD KEY `nim` (`nim`), ADD KEY `id_quiz_soal` (`id_quiz_soal`);

--
-- Indexes for table `quiz_soal`
--
ALTER TABLE `quiz_soal`
 ADD PRIMARY KEY (`id_quiz_soal`), ADD KEY `id_quiz` (`id_quiz`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dosen`
--
ALTER TABLE `dosen`
MODIFY `id_dosen` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `dosen_ambil_mk`
--
ALTER TABLE `dosen_ambil_mk`
MODIFY `id_dosen_ambil_mk` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `forum`
--
ALTER TABLE `forum`
MODIFY `id_forum` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
MODIFY `id_mhs` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `mahasiswa_ambil_mk`
--
ALTER TABLE `mahasiswa_ambil_mk`
MODIFY `id_ambil_mhs_mk` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `matakuliah`
--
ALTER TABLE `matakuliah`
MODIFY `id_mk` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `materi`
--
ALTER TABLE `materi`
MODIFY `id_materi` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `periode`
--
ALTER TABLE `periode`
MODIFY `id_periode` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `quiz`
--
ALTER TABLE `quiz`
MODIFY `id_quiz` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `quiz_jawaban`
--
ALTER TABLE `quiz_jawaban`
MODIFY `id_jawab` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `quiz_soal`
--
ALTER TABLE `quiz_soal`
MODIFY `id_quiz_soal` int(11) NOT NULL AUTO_INCREMENT;
--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `dosen_ambil_mk`
--
ALTER TABLE `dosen_ambil_mk`
ADD CONSTRAINT `dosen_ambil_mk_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `dosen` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `dosen_ambil_mk_ibfk_2` FOREIGN KEY (`kode_mk`) REFERENCES `matakuliah` (`kode_mk`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `mahasiswa_ambil_mk`
--
ALTER TABLE `mahasiswa_ambil_mk`
ADD CONSTRAINT `mahasiswa_ambil_mk_ibfk_1` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `mahasiswa_ambil_mk_ibfk_3` FOREIGN KEY (`id_periode`) REFERENCES `periode` (`id_periode`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `mahasiswa_ambil_mk_ibfk_4` FOREIGN KEY (`kode_mk`) REFERENCES `matakuliah` (`kode_mk`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `materi`
--
ALTER TABLE `materi`
ADD CONSTRAINT `materi_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `dosen` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `materi_ibfk_2` FOREIGN KEY (`kode_mk`) REFERENCES `matakuliah` (`kode_mk`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `quiz`
--
ALTER TABLE `quiz`
ADD CONSTRAINT `quiz_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `dosen` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `quiz_ibfk_2` FOREIGN KEY (`kode_mk`) REFERENCES `matakuliah` (`kode_mk`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `quiz_jawaban`
--
ALTER TABLE `quiz_jawaban`
ADD CONSTRAINT `quiz_jawaban_ibfk_1` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `quiz_jawaban_ibfk_2` FOREIGN KEY (`id_quiz_soal`) REFERENCES `quiz_soal` (`id_quiz_soal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `quiz_soal`
--
ALTER TABLE `quiz_soal`
ADD CONSTRAINT `quiz_soal_ibfk_1` FOREIGN KEY (`id_quiz`) REFERENCES `quiz` (`id_quiz`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
