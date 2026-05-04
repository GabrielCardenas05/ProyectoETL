-- =====================================================
-- DIMENSIÓN PRODUCTOS
-- =====================================================

CREATE TABLE Dim_Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(200) NOT NULL,
    CategoryID INT,
    CategoryName NVARCHAR(150)
);
GO

-- =====================================================
-- DIMENSIÓN CLIENTES
-- =====================================================

CREATE TABLE Dim_Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(200) NOT NULL
);
GO

-- =====================================================
-- DIMENSIÓN TIEMPO
-- =====================================================

CREATE TABLE Dim_Time (
    [Date] DATE PRIMARY KEY,
    [Month] INT NOT NULL,
    Quarter INT NOT NULL,
    [Year] INT NOT NULL
);
GO

-- =====================================================
-- DIMENSIÓN UBICACIÓN
-- =====================================================

CREATE TABLE Dim_Location (
    PostalCode NVARCHAR(20) PRIMARY KEY,
    TerritoryID INT,
    TerritoryName NVARCHAR(100),
    RegionID INT,
    RegionName NVARCHAR(100)
);
GO

-- =====================================================
-- TABLA DE HECHOS
-- =====================================================

CREATE TABLE Fact_Sales (
    OrderID INT NOT NULL,
    OrderDetailID INT NOT NULL,

    ProductID INT NOT NULL,
    PostalCode NVARCHAR(20) NOT NULL,
    CustomerID INT NOT NULL,
    [Date] DATE NOT NULL,

    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2),

    CONSTRAINT pk_fact_sales
        PRIMARY KEY (OrderID, OrderDetailID),

    -- =========================================
    -- FOREIGN KEYS
    -- =========================================

    CONSTRAINT fk_fact_product
        FOREIGN KEY (ProductID)
        REFERENCES Dim_Products(ProductID),

    CONSTRAINT fk_fact_location
        FOREIGN KEY (PostalCode)
        REFERENCES Dim_Location(PostalCode),

    CONSTRAINT fk_fact_customer
        FOREIGN KEY (CustomerID)
        REFERENCES Dim_Customer(CustomerID),

    CONSTRAINT fk_fact_time
        FOREIGN KEY ([Date])
        REFERENCES Dim_Time([Date])
);
GO