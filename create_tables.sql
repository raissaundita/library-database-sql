--------------------------------------------------
-- SCHEMA: Library Database
-- Berisi struktur tabel (CREATE TABLE) dan
-- data contoh (INSERT) untuk sistem perpustakaan
--------------------------------------------------

-- Tabel Publisher: data penerbit buku
CREATE TABLE Publisher (
    PublisherName VARCHAR(100) PRIMARY KEY,
    Address VARCHAR(200),
    Phone VARCHAR(20)
);

-- Tabel Author: data penulis buku
CREATE TABLE Author (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL
);

-- Tabel Book: data buku, terhubung ke Publisher
CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    PublisherName VARCHAR(100),
    FOREIGN KEY (PublisherName) REFERENCES Publisher(PublisherName)
);

-- Tabel Book_Authors: tabel penghubung (junction table)
-- karena satu buku bisa ditulis banyak penulis, dan satu penulis
-- bisa menulis banyak buku (relasi many-to-many)
CREATE TABLE Book_Authors (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);

-- Tabel Library_Branch: data cabang perpustakaan
CREATE TABLE Library_Branch (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL,
    Address VARCHAR(200)
);

-- Tabel Borrower: data peminjam
CREATE TABLE Borrower (
    CardNo INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(200),
    Phone VARCHAR(20)
);

-- Tabel Book_Copies: berapa banyak salinan (copy) tiap buku
-- yang tersedia di tiap cabang perpustakaan
CREATE TABLE Book_Copies (
    BookID INT,
    BranchID INT,
    No_Of_Copies INT,
    PRIMARY KEY (BookID, BranchID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID),
    FOREIGN KEY (BranchID) REFERENCES Library_Branch(BranchID)
);

-- Tabel Book_Loans: catatan peminjaman buku
-- ReturnDate NULL artinya buku belum dikembalikan
CREATE TABLE Book_Loans (
    BookID INT,
    BranchID INT,
    CardNo INT,
    DateOut DATE,
    DueDate DATE,
    ReturnDate DATE NULL,
    PRIMARY KEY (BookID, BranchID, CardNo),
    FOREIGN KEY (BookID) REFERENCES Book(BookID),
    FOREIGN KEY (BranchID) REFERENCES Library_Branch(BranchID),
    FOREIGN KEY (CardNo) REFERENCES Borrower(CardNo)
);

--------------------------------------------------
-- INSERT DATA CONTOH (10 record per tabel)
--------------------------------------------------

INSERT INTO Publisher VALUES
('Gramedia', 'Jl. Veteran 12', '021-111111'),
('Springer', 'Jl. Raya Jakarta 15', '021-222222'),
('Pearson', 'Jl. Diponegoro 17', '021-333333'),
('OReilly', 'Jl. Surabaya 21', '021-444444'),
('MIT Press', 'Jl. Kalimalang 22', '021-555555'),
('Elsevier', 'Jl. Gajahmada 30', '021-666666'),
('McGrawHill', 'Jl. Majapahit 25', '021-777777'),
('Oxford', 'Jl. Pandegiling 27', '021-888888'),
('Cambridge', 'Jl. Darmo 29', '021-999999'),
('Erlangga', 'Jl. Ahmad Yani 33', '021-000000');

INSERT INTO Author VALUES
(1, 'Stephen King'),
(2, 'J.K. Rowling'),
(3, 'Dan Brown'),
(4, 'George Orwell'),
(5, 'Agatha Christie'),
(6, 'Haruki Murakami'),
(7, 'Paulo Coelho'),
(8, 'Jhon Doe'),
(9, 'J.R.R. Tolkien'),
(10, 'Mark Manson');

INSERT INTO Book VALUES
(101, 'The Lost Tribe', 'Gramedia'),
(102, 'It', 'Gramedia'),
(103, 'The Shining', 'Gramedia'),
(104, 'Harry Potter', 'Springer'),
(105, 'Inferno', 'Pearson'),
(106, '1984', 'OReilly'),
(107, 'Murder on the Orient Express', 'MIT Press'),
(108, 'Norwegian Wood', 'Elsevier'),
(109, 'The Alchemist', 'Oxford'),
(110, 'Sapiens', 'Cambridge');

INSERT INTO Book_Authors VALUES
(101, 1),
(102, 1),
(103, 1),
(104, 2),
(105, 3),
(106, 4),
(107, 5),
(108, 6),
(109, 7),
(110, 8);

INSERT INTO Library_Branch VALUES
(1, 'Sharpstown', 'Jl. Merdeka 10'),
(2, 'Central', 'Jl. Sudirman 5'),
(3, 'Westside', 'Jl. Diponegoro 7'),
(4, 'Eastside', 'Jl. Ahmad Yani 12'),
(5, 'Northside', 'Jl. Gatot Subroto 20'),
(6, 'Southside', 'Jl. Imam Bonjol 9'),
(7, 'Uptown', 'Jl. Basuki Rahmat 15'),
(8, 'Downtown', 'Jl. Pahlawan 8'),
(9, 'Harbor', 'Jl. Perak Barat 2'),
(10, 'Airport', 'Jl. Juanda 1');

INSERT INTO Borrower VALUES
(201, 'Andi', 'Jl. Mawar 1', '0811111111'),
(202, 'Budi', 'Jl. Melati 3', '0822222222'),
(203, 'Citra', 'Jl. Kenanga 7', '0833333333'),
(204, 'Dewi', 'Jl. Anggrek 9', '0844444444'),
(205, 'Eka', 'Jl. Dahlia 11', '0855555555'),
(206, 'Fajar', 'Jl. Kamboja 2', '0866666666'),
(207, 'Gilang', 'Jl. Flamboyan 4', '0877777777'),
(208, 'Hana', 'Jl. Seroja 6', '0888888888'),
(209, 'Indra', 'Jl. Mawar Putih 12', '0899999999'),
(210, 'Joko', 'Jl. Bougenville 14', '0810000000');

INSERT INTO Book_Copies VALUES
(101, 1, 3),
(102, 2, 4),
(103, 1, 2),
(104, 3, 5),
(105, 4, 2),
(106, 5, 6),
(107, 6, 4),
(108, 7, 3),
(109, 8, 2),
(110, 9, 5);

INSERT INTO Book_Loans VALUES
(101, 1, 201, '2025-09-20', '2025-09-30', NULL),
(102, 2, 202, '2025-09-21', '2025-10-01', NULL),
(103, 1, 203, '2025-09-22', '2025-10-02', NULL),
(104, 3, 204, '2025-09-23', '2025-10-03', '2025-10-01'),
(105, 4, 205, '2025-09-24', '2025-10-04', '2025-10-04'),
(106, 5, 206, '2025-09-25', '2025-10-05', '2025-10-02'),
(107, 6, 207, '2025-09-26', '2025-10-06', NULL),
(108, 7, 207, '2025-09-27', '2025-10-07', NULL),
(109, 8, 209, '2025-09-28', '2025-10-08', NULL),
(110, 9, 210, '2025-09-29', '2025-10-09', NULL);
