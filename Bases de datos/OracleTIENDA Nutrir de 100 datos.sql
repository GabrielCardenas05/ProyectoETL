--Tienda

---sql
-- =============================================
-- MARCAS
-- =============================================

INSERT INTO Brands VALUES (1, 'Samsung');
INSERT INTO Brands VALUES (2, 'Sony');
INSERT INTO Brands VALUES (3, 'LG');
INSERT INTO Brands VALUES (4, 'HP');
INSERT INTO Brands VALUES (5, 'Lenovo');

-- =============================================
-- PRODUCTOS
-- =============================================

BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Products (
            ProductID,
            BrandID,
            ProductName
        )
        VALUES (
            i,
            MOD(i,5)+1,
            'Producto ' || i
        );
    END LOOP;
END;
/

-- =============================================
-- EMPLEADOS
-- =============================================

BEGIN
    FOR i IN 1..20 LOOP
        INSERT INTO Employees (
            EmployeeID,
            FirstName,
            LastName,
            Title,
            WorkPhone
        )
        VALUES (
            i,
            'Empleado' || i,
            'Apellido' || i,
            'Vendedor',
            '84412345' || LPAD(i,2,'0')
        );
    END LOOP;
END;
/

-- =============================================
-- MÉTODOS DE ENVÍO
-- =============================================

INSERT INTO Shipping_Methods VALUES (1, 'Express');
INSERT INTO Shipping_Methods VALUES (2, 'Estándar');
INSERT INTO Shipping_Methods VALUES (3, 'Sucursal');

-- =============================================
-- CLIENTES
-- =============================================

BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Customers (
            CustomerID,
            CompanyName,
            ContactName,
            City,
            State,
            PostalCode,
            PhoneNumber
        )
        VALUES (
            i,
            'Empresa ' || i,
            'Contacto ' || i,
            'Saltillo',
            'Coahuila',
            '25' || LPAD(i,3,'0'),
            '844555' || LPAD(i,4,'0')
        );
    END LOOP;
END;
/

-- =============================================
-- ÓRDENES
-- =============================================

BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Orders (
            OrderID,
            ShippingMethodID,
            EmployeeID,
            CustomerID,
            OrderDate,
            Quantity,
            UnitPrice,
            Discount
        )
        VALUES (
            i,
            MOD(i,3)+1,
            MOD(i,20)+1,
            MOD(i,100)+1,
            SYSDATE - MOD(i,365),
            ROUND(DBMS_RANDOM.VALUE(1,10)),
            ROUND(DBMS_RANDOM.VALUE(100,5000),2),
            ROUND(DBMS_RANDOM.VALUE(0,30),2)
        );
    END LOOP;
END;
/

-- =============================================
-- DETALLE DE ÓRDENES
-- =============================================

BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Order_Details (
            OrderDetailID,
            OrderID,
            ProductID,
            Quantity,
            UnitPrice,
            Discount
        )
        VALUES (
            i,
            i,
            MOD(i,100)+1,
            ROUND(DBMS_RANDOM.VALUE(1,5)),
            ROUND(DBMS_RANDOM.VALUE(100,3000),2),
            ROUND(DBMS_RANDOM.VALUE(0,20),2)
        );
    END LOOP;
END;
/

-- =============================================
-- MÉTODOS DE PAGO
-- =============================================

INSERT INTO Payment_Method VALUES (1, 'Tarjeta');
INSERT INTO Payment_Method VALUES (2, 'Transferencia');
INSERT INTO Payment_Method VALUES (3, 'Efectivo');

-- =============================================
-- PAGOS
-- =============================================

BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Payment (
            PaymentID,
            PaymentMethodID,
            OrderID,
            PaymentAmount,
            PaymentDate,
            CreditCardNumber,
            CreditCardEXPDate,
            CardHoldersName
        )
        VALUES (
            i,
            MOD(i,3)+1,
            i,
            ROUND(DBMS_RANDOM.VALUE(100,6000),2),
            SYSDATE - MOD(i,365),
            '411111111111' || LPAD(i,4,'0'),
            '12/28',
            'Cliente ' || i
        );
    END LOOP;
END;
/

COMMIT;
SELECT COUNT(*) FROM Products;
SELECT COUNT(*) FROM Orders;
SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) FROM Payment;