-- NYC Food Inspections
-- Dimensional Model
-- r sherman
-- 2022-10-11

CREATE TABLE Dim_NYC_Addresses (
    AddressSK INT NOT NULL AUTO_INCREMENT,
    BUILDING VARCHAR(10) NULL,
    BBL BIGINT NULL,
    BIN INT NULL,
    STREET VARCHAR(40) NULL,
    ZIPCODE CHAR(5) NULL,
    BORO VARCHAR(13) NULL,
    NTA CHAR(4) NULL,
    Latitude DOUBLE NULL,
    Longitude DOUBLE NULL,
    Census_Tract CHAR(6) NULL,
    Community_Board SMALLINT NULL,
    Council_District CHAR(2) NULL,
    DI_CreateDate DATETIME NULL,
    DI_WorkflowDirectory VARCHAR(256) NULL,
    DI_WorkflowFileName VARCHAR(256) NULL,
    PRIMARY KEY (AddressSK)
);

CREATE TABLE Dim_NYC_Borough (
    BoroSK INT NOT NULL AUTO_INCREMENT,
    BORO VARCHAR(13) NULL,
    DI_CreateDate DATETIME NULL,
    DI_WorkflowDirectory VARCHAR(256) NULL,
    DI_WorkflowFileName VARCHAR(256) NULL,
    PRIMARY KEY (BoroSK)
);

CREATE TABLE Dim_NYC_Critical_Flag (
    CRITICAL_FLAG_SK INT NOT NULL AUTO_INCREMENT,
    CRITICAL_FLAG CHAR(14) NULL,
    DI_CreateDate DATETIME NULL,
    DI_WorkflowDirectory VARCHAR(256) NULL,
    DI_WorkflowFileName VARCHAR(256) NULL,
    PRIMARY KEY (CRITICAL_FLAG_SK)
);

CREATE TABLE Dim_NYC_Cuisine (
    CUISINE_DESCRIPTION_SK INT NOT NULL AUTO_INCREMENT,
    CUISINE_DESCRIPTION VARCHAR(30) NULL,
    DI_CreateDate DATETIME NULL,
    DI_WorkflowDirectory VARCHAR(256) NULL,
    DI_WorkflowFileName VARCHAR(256) NULL,
    PRIMARY KEY (CUISINE_DESCRIPTION_SK)
);

CREATE TABLE Dim_NYC_Food_Places (
    FoodPlacesSK INT NOT NULL AUTO_INCREMENT,
    CAMIS INT NULL,
    DBA VARCHAR(95) NULL,
    DI_CreateDate DATETIME NULL,
    DI_WorkflowDirectory VARCHAR(256) NULL,
    DI_WorkflowFileName VARCHAR(256) NULL,
    PRIMARY KEY (FoodPlacesSK)
);

CREATE TABLE Dim_NYC_Inspection_Actions (
    ActionSK INT NOT NULL AUTO_INCREMENT,
    ACTION VARCHAR(130) NULL,
    DI_CreateDate DATETIME NULL,
    DI_WorkflowDirectory VARCHAR(256) NULL,
    DI_WorkflowFileName VARCHAR(256) NULL,
    PRIMARY KEY (ActionSK)
);

CREATE TABLE Dim_NYC_Inspection_Grades (
    GradeSK INT NOT NULL AUTO_INCREMENT,
    GRADE CHAR(1) NULL,
    DI_CreateDate DATETIME NULL,
    DI_WorkflowDirectory VARCHAR(256) NULL,
    DI_WorkflowFileName VARCHAR(256) NULL,
    PRIMARY KEY (GradeSK)
);

CREATE TABLE Dim_NYC_Inspection_Type (
    InspectionTypeSK INT NOT NULL AUTO_INCREMENT,
    INSPECTION_TYPE VARCHAR(59) NULL,
    DI_CreateDate DATETIME NULL,
    DI_WorkflowDirectory VARCHAR(256) NULL,
    DI_WorkflowFileName VARCHAR(256) NULL,
    PRIMARY KEY (InspectionTypeSK)
);

CREATE TABLE Dim_NYC_Violation_Codes (
    ViolationCodeSK INT NOT NULL AUTO_INCREMENT,
    VIOLATION_CODE CHAR(5) NULL,
    VIOLATION_DESCRIPTION VARCHAR(254) NULL,
    DI_CreateDate DATETIME NULL,
    DI_WorkflowDirectory VARCHAR(256) NULL,
    DI_WorkflowFileName VARCHAR(256) NULL,
    PRIMARY KEY (ViolationCodeSK)
);

CREATE TABLE FCT_NYC_Food_Inspections (
    InspectionSK INT NOT NULL AUTO_INCREMENT,
    Inspection_Date DATE NULL,
    Inspection_Date_SK INT NULL,
    FoodPlacesSK INT NULL,
    BoroSK INT NULL,
    AddressSK INT NULL,
    PHONE CHAR(12) NULL,
    CUISINE_DESCRIPTION_SK INT NULL,
    DI_CreateDate DATETIME NULL,
    DI_WorkflowDirectory VARCHAR(256) NULL,
    DI_WorkflowFileName VARCHAR(256) NULL,
    PRIMARY KEY (InspectionSK),
    FOREIGN KEY (AddressSK) REFERENCES Dim_NYC_Addresses (AddressSK),
    FOREIGN KEY (BoroSK) REFERENCES Dim_NYC_Borough (BoroSK),
    FOREIGN KEY (CUISINE_DESCRIPTION_SK) REFERENCES Dim_NYC_Cuisine (CUISINE_DESCRIPTION_SK),
    FOREIGN KEY (FoodPlacesSK) REFERENCES Dim_NYC_Food_Places (FoodPlacesSK)
);

CREATE TABLE FCT_NYC_FoodInspection_Violations (
    InspectionViolationSK INT NOT NULL AUTO_INCREMENT,
    InspectionSK INT NULL,
    InspectionTypeSK INT NULL,
    ActionSK INT NULL,
    CRITICAL_FLAG_SK INT NULL,
    SCORE SMALLINT NULL,
    GradeSK INT NULL,
    Grade_Date DATE NULL,
    ViolationCodeSK INT NULL,
    Record_Date DATE NULL,
    DI_CreateDate DATETIME NULL,
    DI_WorkflowDirectory VARCHAR(256) NULL,
    DI_WorkflowFileName VARCHAR(256) NULL,
    PRIMARY KEY (InspectionViolationSK),
    FOREIGN KEY (CRITICAL_FLAG_SK) REFERENCES Dim_NYC_Critical_Flag (CRITICAL_FLAG_SK),
    FOREIGN KEY (ActionSK) REFERENCES Dim_NYC_Inspection_Actions (ActionSK),
    FOREIGN KEY (GradeSK) REFERENCES Dim_NYC_Inspection_Grades (GradeSK),
    FOREIGN KEY (InspectionTypeSK) REFERENCES Dim_NYC_Inspection_Type (InspectionTypeSK),
    FOREIGN KEY (ViolationCodeSK) REFERENCES Dim_NYC_Violation_Codes (ViolationCodeSK),
    FOREIGN KEY (InspectionSK) REFERENCES FCT_NYC_Food_Inspections (InspectionSK)
);
