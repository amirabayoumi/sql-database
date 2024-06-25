-- table Clients 
CREATE TABLE Clients (
    ClientID INT AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(255),
    Address VARCHAR(255),
    PRIMARY KEY(ClientID)
);

-- table Locations
CREATE TABLE Locations (
    LocationID INT NOT NULL,
    Description VARCHAR(255),
    PRIMARY KEY (LocationID)
);


-- TABLE Technicians
CREATE TABLE Technicians (
    TechnicianID INT AUTO_INCREMENT ,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(255),
    Specialization VARCHAR(100),
    PRIMARY KEY(TechnicianID)
);

-- TABLE Assets
CREATE TABLE Assets (
    AssetID INT AUTO_INCREMENT PRIMARY KEY,
    Description TEXT NOT NULL,
    ClientID INT,
    LocationID INT,
    TechnicianID INT,
    Status VARCHAR(50),
    DateReceived DATE,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
    FOREIGN KEY (TechnicianID) REFERENCES Technicians(TechnicianID)
);

-- TABLE Repairs
CREATE TABLE Repairs (
    RepairID INT AUTO_INCREMENT PRIMARY KEY,
    AssetID INT,
    TechnicianID INT,
    StartDate DATE,
    EndDate DATE,
    RepairStatus VARCHAR(50) NOT NULL,
    Notes TEXT NOT NULL,
    FOREIGN KEY (AssetID) REFERENCES Assets(AssetID),
    FOREIGN KEY (TechnicianID) REFERENCES Technicians(TechnicianID)
);


-- a view table for assets currently under repair
CREATE VIEW AssetsOnRepair AS
SELECT 
    Assets.AssetID, 
    Assets.Description, 
    clients.Name AS ClientName, 
    locations.Address AS LocationAddress, 
    repairs.StartDate, 
    repairs.EndDate, 
    repairs.RepairStatus, 
    repairs.Notes
FROM Assets a
JOIN Clients c ON Assets.ClientID = clients.ClientID
JOIN Locations l ON Assets.LocationID = locations.LocationID
JOIN Repairs r ON Assets.AssetID = Repairs.AssetID
WHERE Assets.Status = 'Under Repair';

-- a view table for assets completed
CREATE VIEW AssetsCompleted AS
SELECT 
    Assets.AssetID, 
    Assets.Description AS AssetDescription, 
    Clients.Name AS ClientName, 
    locations.Address AS LocationAddress, 
    repairs.StartDate, 
    repairs.EndDate, 
    repairs.RepairStatus, 
    repairs.Notes
FROM Assets a
JOIN Clients c ON Assets.ClientID = Clients.ClientID
JOIN Locations l ON Assets.LocationID = Locations.LocationID
JOIN Repairs r ON Assets.AssetID = repairs.AssetID
WHERE Assets.Status = 'Completed';