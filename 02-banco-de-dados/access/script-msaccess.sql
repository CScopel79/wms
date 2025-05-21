-- Products Table
CREATE TABLE Products (
    Id GUID PRIMARY KEY,
    Code TEXT(50),
    Name TEXT(100),
    Description MEMO,
    Weight DOUBLE,
    Volume DOUBLE,
    Perishable YESNO,
    TemperatureControlled YESNO,
    CreatedAt DATETIME DEFAULT Now(),
    UpdatedAt DATETIME
);

-- Lots Table
CREATE TABLE Lots (
    Id GUID PRIMARY KEY,
    ProductId GUID,
    Number TEXT(50),
    ManufacturingDate DATE,
    ExpirationDate DATE,
    Status TEXT(20),
    Quantity LONG,
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);

-- Locations Table
CREATE TABLE Locations (
    Id GUID PRIMARY KEY,
    Area TEXT(50),
    Aisle TEXT(10),
    Shelf TEXT(10),
    Position TEXT(10),
    MaxCapacity LONG
);

-- Inventory Table
CREATE TABLE Inventory (
    Id GUID PRIMARY KEY,
    ProductId GUID,
    LotId GUID,
    LocationId GUID,
    Quantity LONG CHECK (Quantity >= 0),
    LastUpdated DATETIME DEFAULT Now(),
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    FOREIGN KEY (LotId) REFERENCES Lots(Id),
    FOREIGN KEY (LocationId) REFERENCES Locations(Id)
);

-- RFID Tags Table
CREATE TABLE RfidTags (
    Id GUID PRIMARY KEY,
    TagUid TEXT(50),
    ProductId GUID,
    LotId GUID,
    AssignedTo TEXT(50),
    Active YESNO,
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    FOREIGN KEY (LotId) REFERENCES Lots(Id)
);

-- Temperature Logs Table
CREATE TABLE TemperatureLogs (
    Id GUID PRIMARY KEY,
    SensorId TEXT(50),
    LocationId GUID,
    Temperature SINGLE,
    Timestamp DATETIME DEFAULT Now(),
    FOREIGN KEY (LocationId) REFERENCES Locations(Id)
);

-- Users Table
CREATE TABLE Users (
    Id GUID PRIMARY KEY,
    Name TEXT(100),
    Email TEXT(100),
    PasswordHash MEMO,
    Role TEXT(20),
    WarehouseId GUID
);

-- Tasks Table
CREATE TABLE Tasks (
    Id GUID PRIMARY KEY,
    Type TEXT(30),
    AssignedToUserId GUID,
    Status TEXT(20),
    CreatedAt DATETIME DEFAULT Now(),
    FinishedAt DATETIME,
    FOREIGN KEY (AssignedToUserId) REFERENCES Users(Id)
);

-- Task Items Table
CREATE TABLE TaskItems (
    Id GUID PRIMARY KEY,
    TaskId GUID,
    ProductId GUID,
    LotId GUID,
    FromLocationId GUID,
    ToLocationId GUID,
    Quantity LONG,
    FOREIGN KEY (TaskId) REFERENCES Tasks(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    FOREIGN KEY (LotId) REFERENCES Lots(Id),
    FOREIGN KEY (FromLocationId) REFERENCES Locations(Id),
    FOREIGN KEY (ToLocationId) REFERENCES Locations(Id)
);
