-- Crear base de datos
CREATE DATABASE libreria_db;

-- Usar la base de datos
USE libreria_db;

-- =========================
-- Tabla: Author
-- =========================
CREATE TABLE Author (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL
);


-- =========================
-- Tabla: Category
-- =========================
CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryDescription VARCHAR(150) NOT NULL
);

-- =========================
-- Tabla: Customer
-- =========================
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    ZipCode VARCHAR(10),
    City VARCHAR(100),
    State VARCHAR(100)
);

-- =========================
-- Tabla: Book
-- =========================
CREATE TABLE Book (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryID INT,
    Title VARCHAR(200) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    Year YEAR,
    Price DECIMAL(10,2),
    NoPages INT,
    BookDescription TEXT,

    CONSTRAINT fk_book_category
        FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- =========================
-- Tabla: Book_Order
-- =========================
CREATE TABLE Book_Order (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,

    CONSTRAINT fk_order_customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =========================
-- Tabla intermedia: Author_Book
-- Relación muchos a muchos
-- =========================
CREATE TABLE Author_Book (
    AuthorID INT NOT NULL,
    BookID INT NOT NULL,

    PRIMARY KEY (AuthorID, BookID),

    CONSTRAINT fk_authorbook_author
        FOREIGN KEY (AuthorID)
        REFERENCES Author(AuthorID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_authorbook_book
        FOREIGN KEY (BookID)
        REFERENCES Book(BookID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =========================
-- Tabla intermedia: Ordering
-- Relación entre Book y Book_Order
-- =========================
CREATE TABLE Ordering (
    BookID INT NOT NULL,
    OrderID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (BookID, OrderID),

    CONSTRAINT fk_ordering_book
        FOREIGN KEY (BookID)
        REFERENCES Book(BookID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_ordering_order
        FOREIGN KEY (OrderID)
        REFERENCES Book_Order(OrderID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

SHOW TABLES;

SHOW CREATE TABLE Book;