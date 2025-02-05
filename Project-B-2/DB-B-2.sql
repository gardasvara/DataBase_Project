USE PENDUDUK
GO

DROP TABLE IF EXISTS menetap, melakukan, menentukan, mendapatkan, menetapkan, memengaruhi, mengalami, memiliki;
DROP TABLE IF EXISTS PERPAJAKAN;
DROP TABLE IF EXISTS menetap, melakukan, menentukan, mendapatkan, menetapkan;
DROP TABLE IF EXISTS PNS;
DROP TABLE IF EXISTS SWASTA;
DROP TABLE IF EXISTS TEMPAT_TINGGAL;
DROP TABLE IF EXISTS BANTUAN_SOSIAL;
DROP TABLE IF EXISTS TRANSMIGRASI;
DROP TABLE IF EXISTS IMIGRASI;
DROP TABLE IF EXISTS EMIGRASI;
DROP TABLE IF EXISTS KELAHIRAN;
DROP TABLE IF EXISTS PERCERAIAN;
DROP TABLE IF EXISTS KEMATIAN;
DROP TABLE IF EXISTS PERNIKAHAN;
DROP TABLE IF EXISTS STATUS_KESEHATAN;
DROP TABLE IF EXISTS PENDIDIKAN;
DROP TABLE IF EXISTS PENGHASILAN;
DROP TABLE IF EXISTS PEKERJAAN;
DROP TABLE IF EXISTS KELUARGA;
DROP TABLE IF EXISTS PENDUDUK;
DROP TABLE IF EXISTS PERISTIWA_PENTING;
DROP TABLE IF EXISTS PERPINDAHAN;

-- Tabel KELUARGA
CREATE TABLE KELUARGA (
    No_KK VARCHAR(20) PRIMARY KEY,
    Jumlah_Anggota INT,
    Kepala_Keluarga VARCHAR(255),
);

-- Tabel PENDUDUK
CREATE TABLE PENDUDUK (
    NIK VARCHAR(20) PRIMARY KEY,
    Nama VARCHAR(255),
    Usia INT,
    Status_Perkawinan VARCHAR(50),
    Agama VARCHAR(50),
    Jenis_Kelamin VARCHAR(10),
    Tempat_Lahir VARCHAR(100),
    Tanggal_Lahir DATE,
	Nama_Jalan VARCHAR(255) NULL,
	No_Rumah VARCHAR(20) NULL, 
	RTRW VARCHAR(11) NULL,
	Kewarganegaraan VARCHAR(5) NULL,
	No_KK VARCHAR (20),
	FOREIGN KEY (No_KK) REFERENCES KELUARGA(No_KK)
);

-- Tabel PEKERJAAN
CREATE TABLE PEKERJAAN (
    Id_Pekerjaan VARCHAR(20) PRIMARY KEY,
    Nama_Pekerjaan VARCHAR(100),
    Lokasi_Pekerjaan VARCHAR(100),
    Kontak VARCHAR(20)
);

-- Tabel PNS (Subclass 1)
CREATE TABLE PNS (
    Id_Pekerjaan VARCHAR(20) PRIMARY KEY,
    NIP VARCHAR(20) UNIQUE,
    Jabatan_PNS VARCHAR(50),
    Instansi VARCHAR(100),
    FOREIGN KEY (Id_Pekerjaan) REFERENCES PEKERJAAN(Id_Pekerjaan)
);

-- Tabel SWASTA (Subclass 2)
CREATE TABLE SWASTA (
    Id_Pekerjaan VARCHAR(20) PRIMARY KEY,
    Nama_Perusahaan VARCHAR(100),
    Jabatan_Swasta VARCHAR(50),
    FOREIGN KEY (Id_Pekerjaan) REFERENCES PEKERJAAN(Id_Pekerjaan)
);

-- Tabel PENGHASILAN
CREATE TABLE PENGHASILAN (
    No_Laporan_Penghasilan VARCHAR(20),
    Nominal_Penghasilan DECIMAL(20,2),
    Id_Pekerjaan VARCHAR(20),
    PRIMARY KEY (No_Laporan_Penghasilan),
    FOREIGN KEY (Id_Pekerjaan) REFERENCES PEKERJAAN(Id_Pekerjaan)
);

-- Tabel TEMPAT_TINGGAL
CREATE TABLE TEMPAT_TINGGAL (
    Id_Tempat_Tinggal VARCHAR(20) PRIMARY KEY,
	Kode_Pos VARCHAR(10),
    Kecamatan VARCHAR(100),
    Kabupaten VARCHAR(100),
    Provinsi VARCHAR(100),
);

-- Tabel BANTUAN_SOSIAL
CREATE TABLE BANTUAN_SOSIAL (
    ID_Bansos VARCHAR(20) PRIMARY KEY,
    Jenis_Bantuan VARCHAR(100),
    Nama_Program VARCHAR(100)
);

-- Tabel PERPINDAHAN
CREATE TABLE PERPINDAHAN (
    ID_Perpindahan VARCHAR(20) PRIMARY KEY
);

-- Tabel TRANSMIGRASI (Subclass)
CREATE TABLE TRANSMIGRASI (
    Id_Perpindahan VARCHAR(20) PRIMARY KEY,
    Alamat_Asal VARCHAR(255),
    Alamat_Tujuan VARCHAR(255),
	Tanggal_Transmigrasi DATE,
    FOREIGN KEY (Id_Perpindahan) REFERENCES PERPINDAHAN(Id_Perpindahan)
);

-- Tabel IMIGRASI (Subclass)
CREATE TABLE IMIGRASI (
    Id_Perpindahan VARCHAR(20) PRIMARY KEY,
    Negara_Asal VARCHAR(100),
    No_Paspor_I VARCHAR(20),
	Tanggal_Imigrasi DATE,
    FOREIGN KEY (Id_Perpindahan) REFERENCES PERPINDAHAN(Id_Perpindahan)
);

-- Tabel EMIGRASI (Subclass)
CREATE TABLE EMIGRASI (
    Id_Perpindahan VARCHAR(20) PRIMARY KEY,
    Negara_Tujuan VARCHAR(100),
    No_Paspor_E VARCHAR(20),
	Tanggal_Emigrasi DATE,
    FOREIGN KEY (Id_Perpindahan) REFERENCES PERPINDAHAN(Id_Perpindahan)
);

-- Tabel PERPAJAKAN
CREATE TABLE PERPAJAKAN (
    NPWP VARCHAR(20) PRIMARY KEY,
    Total_Pajak DECIMAL(10,2),
    Tanggal_Bayar DATE,
    NIK VARCHAR(20),
    FOREIGN KEY (NIK) REFERENCES PENDUDUK(NIK)
);

-- Tabel PERISTIWA_PENTING
CREATE TABLE PERISTIWA_PENTING (
    No_Surat_Peristiwa VARCHAR(20) PRIMARY KEY
);

-- Tabel KELAHIRAN (Subclass 1)
CREATE TABLE KELAHIRAN (
    No_Surat_Peristiwa VARCHAR(20) PRIMARY KEY,
    No_Akta_Kelahiran VARCHAR(20),
	Tanggal_Kelahiran DATE,
    FOREIGN KEY (No_Surat_Peristiwa) REFERENCES PERISTIWA_PENTING(No_Surat_Peristiwa)
);

-- Tabel PERCERAIAN (Subclass 2)
CREATE TABLE PERCERAIAN (
    No_Surat_Peristiwa VARCHAR(20) PRIMARY KEY,
    No_Surat_Perceraian VARCHAR(20),
	Tanggal_Perceraian DATE,
    FOREIGN KEY (No_Surat_Peristiwa) REFERENCES PERISTIWA_PENTING(No_Surat_Peristiwa)
);

-- Tabel KEMATIAN (Subclass 3)
CREATE TABLE KEMATIAN (
    No_Surat_Peristiwa VARCHAR(20) PRIMARY KEY,
    No_Surat_Kematian VARCHAR(20),
    Penyebab_Kematian VARCHAR(255),
	Tanggal_Kematian DATE,
    FOREIGN KEY (No_Surat_Peristiwa) REFERENCES PERISTIWA_PENTING(No_Surat_Peristiwa)
);

-- Tabel PERNIKAHAN (Subclass 4)
CREATE TABLE PERNIKAHAN (
    No_Surat_Peristiwa VARCHAR(20) PRIMARY KEY,
    No_Buku_Nikah VARCHAR(20),
	Tanggal_Pernikahan DATE,
    FOREIGN KEY (No_Surat_Peristiwa) REFERENCES PERISTIWA_PENTING(No_Surat_Peristiwa)
);

-- Tabel STATUS_KESEHATAN
CREATE TABLE STATUS_KESEHATAN (
    No_Rekam_Medis VARCHAR(20) PRIMARY KEY,
    Riwayat_Sakit VARCHAR(255),
    NIK VARCHAR(20),
    FOREIGN KEY (NIK) REFERENCES PENDUDUK(NIK)
);

-- Tabel PENDIDIKAN
CREATE TABLE PENDIDIKAN (
    NISN VARCHAR(20) PRIMARY KEY,
    Tingkat_Pendidikan VARCHAR(50),
    NIK VARCHAR(20),
    FOREIGN KEY (NIK) REFERENCES PENDUDUK(NIK)
);

-- Tabel memiliki
CREATE TABLE memiliki (
    NIK VARCHAR(20),
    Id_Pekerjaan VARCHAR(20),
    PRIMARY KEY (NIK, Id_Pekerjaan),
    FOREIGN KEY (NIK) REFERENCES PENDUDUK(NIK),
    FOREIGN KEY (Id_Pekerjaan) REFERENCES PEKERJAAN(Id_Pekerjaan)
);

-- Tabel mengalami
CREATE TABLE mengalami (
    NIK VARCHAR(20),
    No_Surat_Peristiwa VARCHAR(20),
    PRIMARY KEY (NIK, No_Surat_Peristiwa),
    FOREIGN KEY (NIK) REFERENCES PENDUDUK(NIK),
    FOREIGN KEY (No_Surat_Peristiwa) REFERENCES PERISTIWA_PENTING(No_Surat_Peristiwa)
);

-- Tabel memengaruhi
CREATE TABLE memengaruhi (
    No_Surat_Peristiwa VARCHAR(20),
    No_KK VARCHAR(20) NOT NULL,  
    PRIMARY KEY (No_Surat_Peristiwa, No_KK),
    FOREIGN KEY (No_Surat_Peristiwa) REFERENCES PERISTIWA_PENTING(No_Surat_Peristiwa),
    FOREIGN KEY (No_KK) REFERENCES KELUARGA(No_KK)
);


-- Tabel mendapatkan
CREATE TABLE mendapatkan (
    NIK VARCHAR(20),
    Id_Bansos VARCHAR(20),
    PRIMARY KEY (NIK, Id_Bansos),
    FOREIGN KEY (NIK) REFERENCES PENDUDUK(NIK),
    FOREIGN KEY (Id_Bansos) REFERENCES BANTUAN_SOSIAL(ID_Bansos)
);

-- Tabel menetapkan
CREATE TABLE menetapkan (
    No_Laporan_Penghasilan VARCHAR(20),
    Id_Bansos VARCHAR(20),
    PRIMARY KEY (No_Laporan_Penghasilan, Id_Bansos),
    FOREIGN KEY (No_Laporan_Penghasilan) REFERENCES PENGHASILAN(No_Laporan_Penghasilan),
    FOREIGN KEY (Id_Bansos) REFERENCES BANTUAN_SOSIAL(ID_Bansos)
);

-- Tabel menetap
CREATE TABLE menetap (
    No_KK VARCHAR(20),
    Id_Tempat_Tinggal VARCHAR(20),
    PRIMARY KEY (No_KK, Id_Tempat_Tinggal),
    FOREIGN KEY (No_KK) REFERENCES KELUARGA(No_KK),
    FOREIGN KEY (Id_Tempat_Tinggal) REFERENCES TEMPAT_TINGGAL(Id_Tempat_Tinggal)
);

-- Tabel melakukan
CREATE TABLE melakukan (
    NIK VARCHAR(20),
    Id_Perpindahan VARCHAR(20),
    PRIMARY KEY (NIK, Id_Perpindahan),
    FOREIGN KEY (NIK) REFERENCES PENDUDUK(NIK),
    FOREIGN KEY (Id_Perpindahan) REFERENCES PERPINDAHAN(ID_Perpindahan)
);

-- Tabel menentukan
CREATE TABLE menentukan (
    No_Laporan_Penghasilan VARCHAR(20),
    NPWP VARCHAR(20),
    PRIMARY KEY (No_Laporan_Penghasilan, NPWP),
    FOREIGN KEY (No_Laporan_Penghasilan) REFERENCES PENGHASILAN(No_Laporan_Penghasilan),
    FOREIGN KEY (NPWP) REFERENCES PERPAJAKAN(NPWP)
);