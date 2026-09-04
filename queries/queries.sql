--------------------------------------------------
-- QUERIES: Library Database
-- 7 query untuk menjawab 7 soal tugas
-- Jalankan setelah schema/create_tables.sql dieksekusi
--------------------------------------------------

-- SOAL 1
-- Berapa banyak copy buku "The Lost Tribe" yang dimiliki
-- cabang perpustakaan "Sharpstown"?
SELECT SUM(bc.No_Of_Copies) AS TotalCopies
FROM Book b
JOIN Book_Copies bc ON b.BookID = bc.BookID
JOIN Library_Branch lb ON bc.BranchID = lb.BranchID
WHERE b.Title = 'The Lost Tribe'
  AND lb.BranchName = 'Sharpstown';


-- SOAL 2
-- Berapa banyak copy buku "The Lost Tribe" yang dimiliki
-- oleh MASING-MASING cabang perpustakaan?
SELECT lb.BranchName, SUM(bc.No_Of_Copies) AS TotalCopies
FROM Book b
JOIN Book_Copies bc ON b.BookID = bc.BookID
JOIN Library_Branch lb ON bc.BranchID = lb.BranchID
WHERE b.Title = 'The Lost Tribe'
GROUP BY lb.BranchName;


-- SOAL 3
-- Tampilkan nama semua peminjam yang TIDAK SEDANG
-- meminjam buku apapun (belum ada pinjaman aktif)
SELECT br.Name
FROM Borrower br
WHERE br.CardNo NOT IN (
    SELECT bl.CardNo
    FROM Book_Loans bl
    WHERE bl.ReturnDate IS NULL
);


-- SOAL 4
-- Untuk setiap buku yang dipinjam dari cabang "Sharpstown"
-- dan DueDate-nya adalah hari ini, tampilkan judul buku,
-- nama peminjam, dan alamat peminjam
SELECT
    bk.Title AS BookTitle,
    br.Name AS BorrowerName,
    br.Address AS BorrowerAddress
FROM Book_Loans bl
JOIN Book bk
    ON bl.BookID = bk.BookID
JOIN Borrower br
    ON bl.CardNo = br.CardNo
JOIN Library_Branch lb
    ON bl.BranchID = lb.BranchID
WHERE lb.BranchName = 'Sharpstown'
  AND bl.DueDate = CURDATE();  -- CURDATE() = tanggal hari ini (MySQL)


-- SOAL 5
-- Untuk setiap cabang perpustakaan, tampilkan nama cabang
-- dan total jumlah buku yang dipinjam dari cabang tersebut
SELECT
    lb.BranchName,
    COUNT(bl.BookID) AS TotalBooksLoaned
FROM Library_Branch lb
LEFT JOIN Book_Loans bl
    ON lb.BranchID = bl.BranchID
GROUP BY lb.BranchName
ORDER BY lb.BranchName;


-- SOAL 6
-- Tampilkan nama, alamat, dan jumlah buku yang sedang dipinjam
-- untuk semua peminjam yang sedang meminjam LEBIH DARI 5 buku
SELECT
    br.Name,
    br.Address,
    COUNT(bl.BookID) AS BooksCheckedOut
FROM Borrower br
JOIN Book_Loans bl
    ON br.CardNo = bl.CardNo
WHERE bl.ReturnDate IS NULL
GROUP BY br.Name, br.Address
HAVING COUNT(bl.BookID) > 5

UNION ALL

-- Baris dummy ini muncul HANYA jika hasil di atas kosong,
-- supaya query tetap menampilkan sesuatu (tidak kosong total)
SELECT
    '-' AS Name,
    '-' AS Address,
    0 AS BooksCheckedOut
WHERE NOT EXISTS (
    SELECT 1
    FROM Borrower br
    JOIN Book_Loans bl
        ON br.CardNo = bl.CardNo
    WHERE bl.ReturnDate IS NULL
    GROUP BY br.Name, br.Address
    HAVING COUNT(bl.BookID) > 5
);


-- SOAL 7
-- Untuk setiap buku yang ditulis (atau ditulis bersama) oleh
-- "Stephen King", tampilkan judul buku dan jumlah copy yang
-- dimiliki cabang perpustakaan "Central"
SELECT
    b.Title,
    COALESCE(bc.No_Of_Copies, 0) AS No_Of_Copies
FROM Book b
JOIN Book_Authors ba ON b.BookID = ba.BookID
JOIN Author a        ON ba.AuthorID = a.AuthorID
LEFT JOIN Book_Copies bc
    ON b.BookID = bc.BookID
LEFT JOIN Library_Branch lb
    ON bc.BranchID = lb.BranchID
WHERE a.AuthorName = 'Stephen King'
  AND lb.BranchName = 'Central';
