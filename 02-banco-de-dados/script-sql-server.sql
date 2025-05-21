-- Products Table
CREATE TABLE Products (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Code VARCHAR(50) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Weight DECIMAL(10,2),
    Volume DECIMAL(10,2),
    Perishable BIT DEFAULT 0,
    TemperatureControlled BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME,
    INDEX IX_Products_Code NONCLUSTERED (Code)
);

-- Lots Table
CREATE TABLE Lots (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ProductId UNIQUEIDENTIFIER NOT NULL,
    Number VARCHAR(50) NOT NULL,
    ManufacturingDate DATE NOT NULL,
    ExpirationDate DATE NOT NULL,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Ativo', 'Vencido', 'Bloqueado')),
    Quantity INT NOT NULL,
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    INDEX IX_Lots_Number NONCLUSTERED (Number)
);

-- Locations Table
CREATE TABLE Locations (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Area VARCHAR(50) NOT NULL,
    Aisle VARCHAR(10) NOT NULL,
    Shelf VARCHAR(10) NOT NULL,
    Position VARCHAR(10) NOT NULL,
    MaxCapacity INT NOT NULL,
    INDEX IX_Locations_AreaShelf NONCLUSTERED (Area, Shelf)
);

-- Inventory Table
CREATE TABLE Inventory (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ProductId UNIQUEIDENTIFIER NOT NULL,
    LotId UNIQUEIDENTIFIER NOT NULL,
    LocationId UNIQUEIDENTIFIER NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    LastUpdated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    FOREIGN KEY (LotId) REFERENCES Lots(Id),
    FOREIGN KEY (LocationId) REFERENCES Locations(Id),
    INDEX IX_Inventory_Location NONCLUSTERED (LocationId)
);

-- RFID Tags Table
CREATE TABLE RfidTags (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    TagUid VARCHAR(50) NOT NULL UNIQUE,
    ProductId UNIQUEIDENTIFIER NOT NULL,
    LotId UNIQUEIDENTIFIER NOT NULL,
    AssignedTo VARCHAR(50),
    Active BIT DEFAULT 1,
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    FOREIGN KEY (LotId) REFERENCES Lots(Id),
    INDEX IX_RfidTags_TagUid NONCLUSTERED (TagUid)
);

-- Temperature Logs Table
CREATE TABLE TemperatureLogs (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    SensorId VARCHAR(50) NOT NULL,
    LocationId UNIQUEIDENTIFIER NOT NULL,
    Temperature DECIMAL(5,2) NOT NULL,
    Timestamp DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (LocationId) REFERENCES Locations(Id),
    INDEX IX_TemperatureLogs_SensorTime NONCLUSTERED (SensorId, Timestamp)
);

-- Users Table
CREATE TABLE Users (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash TEXT NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('Operador', 'Supervisor', 'Admin')),
    WarehouseId UNIQUEIDENTIFIER
);

-- Tasks Table
CREATE TABLE Tasks (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Type VARCHAR(30) NOT NULL CHECK (Type IN ('Picking', 'Movimentacao', 'Inventario')),
    AssignedToUserId UNIQUEIDENTIFIER NOT NULL,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Pendente', 'Em Andamento', 'Finalizado')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FinishedAt DATETIME,
    FOREIGN KEY (AssignedToUserId) REFERENCES Users(Id)
);

-- Task Items Table
CREATE TABLE TaskItems (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    TaskId UNIQUEIDENTIFIER NOT NULL,
    ProductId UNIQUEIDENTIFIER NOT NULL,
    LotId UNIQUEIDENTIFIER NOT NULL,
    FromLocationId UNIQUEIDENTIFIER,
    ToLocationId UNIQUEIDENTIFIER,
    Quantity INT NOT NULL,
    FOREIGN KEY (TaskId) REFERENCES Tasks(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    FOREIGN KEY (LotId) REFERENCES Lots(Id),
    FOREIGN KEY (FromLocationId) REFERENCES Locations(Id),
    FOREIGN KEY (ToLocationId) REFERENCES Locations(Id)
);

-- Trigger: Atualizar UpdatedAt em Produtos
CREATE TRIGGER trg_UpdateProductTimestamp
ON Products
AFTER UPDATE
AS
BEGIN
    UPDATE Products
    SET UpdatedAt = GETDATE()
    FROM Products p
    INNER JOIN inserted i ON p.Id = i.Id
END;

-- Trigger: Bloquear saída de lote vencido
CREATE TRIGGER trg_CheckExpiredLotBeforeMovement
ON TaskItems
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Lots l ON i.LotId = l.Id
        WHERE l.ExpirationDate < GETDATE() AND l.Status = 'Vencido'
    )
    BEGIN
        THROW 50001, 'Não é permitido movimentar lotes vencidos.', 1;
        RETURN;
    END

    INSERT INTO TaskItems (Id, TaskId, ProductId, LotId, FromLocationId, ToLocationId, Quantity)
    SELECT Id, TaskId, ProductId, LotId, FromLocationId, ToLocationId, Quantity
    FROM inserted;
END;
