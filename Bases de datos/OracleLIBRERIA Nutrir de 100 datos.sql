--Datos ficticios para Oracle - Proyecto ETL

--Librería

---sql
-- =============================================
-- CATEGORÍAS
-- =============================================

INSERT INTO Category (CategoryDescription) VALUES ('Novela');
INSERT INTO Category (CategoryDescription) VALUES ('Tecnología');
INSERT INTO Category (CategoryDescription) VALUES ('Historia');
INSERT INTO Category (CategoryDescription) VALUES ('Ciencia');
INSERT INTO Category (CategoryDescription) VALUES ('Fantasía');

-- =============================================
-- AUTORES
-- =============================================

BEGIN
    FOR i IN 1..20 LOOP
        INSERT INTO Author (AuthorName)
        VALUES ('Autor ' || i);
    END LOOP;
END;
/

-- =============================================
-- CLIENTES
-- =============================================

BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Customer (
            FirstName,
            LastName,
            ZipCode,
            City,
            State
        )
        VALUES (
            'Nombre' || i,
            'Apellido' || i,
            '25' || LPAD(i,3,'0'),
            CASE MOD(i,5)
                WHEN 0 THEN 'Saltillo'
                WHEN 1 THEN 'Monterrey'
                WHEN 2 THEN 'Torreón'
                WHEN 3 THEN 'Piedras Negras'
                ELSE 'Ramos Arizpe'
            END,
            'Coahuila'
        );
    END LOOP;
END;
/

-- =============================================
-- LIBROS
-- =============================================

BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Book (
            CategoryID,
            Title,
            ISBN,
            Year,
            Price,
            NoPages,
            BookDescription
        )
        VALUES (
            MOD(i,5)+1,
            'Libro ' || i,
            'ISBN-' || TO_CHAR(100000+i),
            2015 + MOD(i,10),
            ROUND(DBMS_RANDOM.VALUE(150,900),2),
            ROUND(DBMS_RANDOM.VALUE(100,800)),
            'Descripción del libro ' || i
        );
    END LOOP;
END;
/

-- =============================================
-- RELACIÓN AUTOR-LIBRO
-- =============================================

BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Author_Book (
            AuthorID,
            BookID
        )
        VALUES (
            MOD(i,20)+1,
            i
        );
    END LOOP;
END;
/

-- =============================================
-- ÓRDENES
-- =============================================

BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Book_Order (
            CustomerID,
            OrderDate
        )
        VALUES (
            MOD(i,100)+1,
            SYSDATE - MOD(i,365)
        );
    END LOOP;
END;
/

-- =============================================
-- DETALLE DE ÓRDENES
-- =============================================

BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Ordering (
            BookID,
            OrderID,
            Price
        )
        VALUES (
            MOD(i,100)+1,
            i,
            ROUND(DBMS_RANDOM.VALUE(100,1000),2)
        );
    END LOOP;
END;
/
---
SELECT COUNT(*) FROM Book;
SELECT COUNT(*) FROM Customer;
SELECT COUNT(*) FROM Orders;
SELECT COUNT(*) FROM Products;