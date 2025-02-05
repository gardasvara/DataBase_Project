USE PENDUDUK
GO

--Menampilkan Nama, Jenis Kelamin, dan Usia dari penduduk
SELECT Nama, Jenis_Kelamin, Usia
FROM PENDUDUK;

--Menampilkan Nama dan Jenis Pekerjaan dari penduduk bersama dengan informasi pekerjaan
SELECT PENDUDUK.Nama, PEKERJAAN.Nama_Pekerjaan
FROM PENDUDUK
JOIN memiliki ON PENDUDUK.NIK = memiliki.NIK
JOIN PEKERJAAN ON memiliki.Id_Pekerjaan = PEKERJAAN.Id_Pekerjaan;

--Menampilkan Nama, Tanggal Lahir, dan Kewarganegaraan dari penduduk Indonesia yang berusia di atas 30 tahun, diurutkan berdasarkan usia:
SELECT Nama, Tanggal_Lahir, Kewarganegaraan
FROM PENDUDUK
WHERE Kewarganegaraan = 'WNI' AND Usia > 30
ORDER BY Usia ASC

--Menampilkan Jumlah Anggota Keluarga untuk setiap Kepala Keluarga:
SELECT Kepala_Keluarga, COUNT(*) AS Jumlah_Anggota
FROM KELUARGA
GROUP BY Kepala_Keluarga;

--Menampilkan Nama dan Total Pajak yang dibayarkan oleh penduduk yang memiliki NPWP:
SELECT Nama, Total_Pajak
FROM PERPAJAKAN
WHERE NPWP IN (SELECT NPWP FROM PENDUDUK WHERE NPWP IS NOT NULL);

-- Menampilkan Nama Penduduk dan Nama Program Bantuan Sosial yang diterima:
SELECT PENDUDUK.Nama, BANTUAN_SOSIAL.Nama_Program
FROM PENDUDUK
JOIN menetapkan ON PENDUDUK.NIK = menetapkan.No_Laporan_Penghasilan
JOIN BANTUAN_SOSIAL ON menetapkan.Id_Bansos = BANTUAN_SOSIAL.ID_Bansos;


SELECT ID_Bansos, Jenis_Bantuan, Nama_Program
FROM BANTUAN_SOSIAL

-- Menampilkan penduduk yang berusia lebih dari 30 tahun
SELECT NIK, Nama, Tanggal_Lahir
FROM PENDUDUK
WHERE DATEDIFF(YEAR, Tanggal_Lahir, GETDATE()) > 30;

-- Menampilkan Nama Penduduk, NIK, Nama Pekerjaan, dan Total Pajak
SELECT PENDUDUK.Nama, PENDUDUK.NIK, PEKERJAAN.Nama_Pekerjaan, PERPAJAKAN.Total_Pajak
FROM PENDUDUK
JOIN memiliki ON PENDUDUK.NIK = memiliki.NIK
JOIN memiliki ON PEKERJAAN.Id_Pekerjaan = memiliki.Id_Pekerjaan
JOIN PENGHASILAN ON PEKERJAAN.Id_Pekerjaan = PENGHASILAN.Id_Pekerjaan -- Hubungan 'mendapatkan'
JOIN PERPAJAKAN ON PENGHASILAN.No_Laporan_Penghasilan = PERPAJAKAN.No_Laporan_Penghasilan -- Hubungan 'menentukan';


-- SOAL QUERY
-- Orang pekerjaan dan jumlah pajak
SELECT P.Nama, PEK.Nama_Pekerjaan, SUM(PAJ.Total_Pajak) AS Jumlah_Pajak
FROM PENDUDUK P
JOIN memiliki M ON P.NIK = M.NIK
JOIN PEKERJAAN PEK ON M.Id_Pekerjaan = PEK.Id_Pekerjaan
LEFT JOIN PERPAJAKAN PAJ ON P.NIK = PAJ.NIK
GROUP BY P.Nama, PEK.Nama_Pekerjaan;

-- Penduduk perempuan yang bekerja sebagai pns yang sudah bercerai yang berusia lebih dari 
-- 30 tahun dan anak lebih dari 2 serta melakukan emigrasi menjadi WNA
SELECT P.NIK, P.Nama, P.Kewarganegaraan, DATEDIFF(YEAR, P.Tanggal_Lahir, GETDATE()) AS Usia, 
      K.Jumlah_Anggota - 1 AS Jumlah_Anak, PS.Jabatan_PNS, PS.Instansi,
      E.Id_Perpindahan, E.Tanggal_Emigrasi, E.Negara_Tujuan, E.No_Paspor_E
FROM PENDUDUK P
JOIN KELUARGA K ON P.No_KK = K.No_KK
LEFT JOIN melakukan M ON P.NIK = M.NIK
LEFT JOIN EMIGRASI E ON M.Id_Perpindahan = E.Id_Perpindahan
JOIN MEMILIKI MI ON P.NIK = MI.NIK
JOIN PEKERJAAN PEK ON MI.Id_Pekerjaan = PEK.Id_Pekerjaan
JOIN PNS PS ON PEK.Id_Pekerjaan = PS.Id_Pekerjaan
WHERE P.Jenis_Kelamin = 'P'
  AND P.Status_Perkawinan = 'Cerai Hidup'
  AND K.Jumlah_Anggota > 2
  AND P.Kewarganegaraan = 'WNA'
  AND DATEDIFF(YEAR, P.Tanggal_Lahir, GETDATE()) > 30;