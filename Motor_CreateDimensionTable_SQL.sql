USE Motor

CREATE TABLE Dim_Date(
Dim_Date_SK INT PRIMARY KEY,
Date_NK Date,
Day INT,
DayOfWeek INT
)

CREATE TABLE Dim_Time(
Dim_Time_SK INT PRIMARY KEY,
Time_NK Time,
Hour INT
)

CREATE TABLE Dim_Injure(
Dim_Injure_SK INT PRIMARY KEY,
EJECTION varchar(80) NULL,
EMOTIONAL_STATUS varchar(80) NULL,
BODILY_INJURY varchar(80) NULL,
POSITION_IN_VEHICLE varchar(255) NULL,
SAFETY_EQUIPMENT varchar(255) NULL,
DI_PID varchar(20) NULL,
DI_Create_Date datetime DEFAULT getdate() NULL
)

CREATE TABLE  Dim_Person(
Dim_PersonInfo_SK INT PRIMARY KEY,
PERSON_ID varchar(80) NULL,
PERSON_TYPE varchar(80) NULL,
PERSON_INJURY varchar(80) NULL,
PERSON_AGE int NULL,
PERSON_SEX varchar(10) NULL,
Dim_Injure_SK INT FOREIGN KEY REFERENCES Dim_Injure(Dim_Injure_SK),
DI_PID varchar(20) NULL,
DI_Create_Date datetime DEFAULT getdate() NULL
)

CREATE TABLE  Dim_Ped(
Dim_Ped_SK INT PRIMARY KEY,
PED_LOCATION varchar(255) NULL,
PED_ACTION varchar(255) NULL,
COMPLAINT varchar(255) NULL,
PED_ROLE varchar(255) NULL,
DI_PID varchar(20) NULL,
DI_Create_Date datetime DEFAULT getdate() NULL
)

CREATE TABLE Dim_Vehicle_Damage(
Dim_Vehicle_Damge_SK INT PRIMARY KEY,
PRE_CRASH varchar(255) NULL,
POINT_OF_IMPACT varchar(255) NULL,
VEHICLE_DAMAGE varchar(255) NULL,
VEHICLE_DAMAGE_1 varchar(255) NULL,
VEHICLE_DAMAGE_2 varchar(255) NULL,
VEHICLE_DAMAGE_3 varchar(255) NULL,
PUBLIC_PROPERTY_DAMAGE varchar(1024) NULL,
PUBLIC_PROPERTY_DAMAGE_TYPE varchar(1024) NULL,
DI_PID varchar(20) NULL,
DI_Create_Date datetime DEFAULT getdate() NULL
)

CREATE TABLE Dim_Travel_Direction(
Dim_Travel_Direction_SK INT PRIMARY KEY,
TRAVEL_DIRECTION varchar(255) NULL,
DI_PID varchar(20) NULL,
DI_Create_Date datetime DEFAULT getdate() NULL
)

CREATE TABLE Dim_Driver(
Dim_Driver_SK INT PRIMARY KEY,
DRIVER_SEX varchar(80) NULL,
DRIVER_LICENSE_STATUS varchar(255) NULL,
DRIVER_LICENSE_JURISDICTION varchar(255) NULL,
DI_PID varchar(20) NULL,
DI_Create_Date datetime DEFAULT getdate() NULL
)

CREATE TABLE Dim_Vehicle(
Dim_Vehicle_SK INT PRIMARY KEY,
VEHICLE_ID varchar(80) NULL,
STATE_REGISTRATION varchar(80) NULL,
VEHICLE_TYPE varchar(80) NULL,
VEHICLE_MAKE varchar(80) NULL,
VEHICLE_MODEL varchar(80) NULL,
VEHICLE_YEAR varchar(80) NULL,
VEHICLE_OCCUPANTS int NULL,
Dim_Vehicle_Damge_SK INT FOREIGN KEY REFERENCES Dim_Vehicle_Damage(Dim_Vehicle_Damge_SK),
Dim_Travel_Direction_SK INT FOREIGN KEY REFERENCES Dim_Travel_Direction(Dim_Travel_Direction_SK),
Dim_Driver_SK INT FOREIGN KEY REFERENCES Dim_Driver(Dim_Driver_SK),
DI_PID varchar(20) NULL,
DI_Create_Date datetime DEFAULT getdate() NULL
)

CREATE TABLE Dim_Location(
Dim_Location_SK INT PRIMARY KEY,
borough varchar(40) NULL,
zip_code varchar(40) NULL,
off_street_name varchar(40) NULL,
on_street_name varchar(40) NULL,
cross_street_name varchar(40) NULL,
latitude numeric(24,6) NULL,
longitude numeric(24,6) NULL,
location varchar(256) NULL,
DI_JobID varchar(20) NULL,
DI_Create_Date datetime DEFAULT getdate() NULL
)

CREATE TABLE Dim_Vehicle_Factor(
Dim_Vehicle_Factor_SK INT PRIMARY KEY,
contributing_factor_vehicle_1 varchar(256) NULL,
vehicle_type_code1 varchar(80) NULL,
DI_JobID varchar(20) NULL,
DI_Create_Date datetime DEFAULT getdate() NULL
)


CREATE TABLE Fct_Crash(
Fct_Crash_SK INT PRIMARY KEY,
COLLISION_ID bigint NOT NULL, 
collision_day date NULL,  
Dim_Date_SK INT FOREIGN KEY REFERENCES Dim_Date(Dim_Date_SK),
Dim_Time_SK INT FOREIGN KEY REFERENCES Dim_Time(Dim_Time_SK),
collision_time time NULL, 
Dim_Person_SK INT FOREIGN KEY REFERENCES Dim_Person(Dim_PersonInfo_SK),
Dim_Ped_SK INT FOREIGN KEY REFERENCES Dim_Ped(Dim_Ped_SK),
Dim_Vehicle_SK INT FOREIGN KEY REFERENCES Dim_Vehicle(Dim_Vehicle_SK),
Dim_Location_SK INT FOREIGN KEY REFERENCES Dim_Location(Dim_Location_SK),
number_of_cyclist_injured int NULL,
number_of_cyclist_killed int NULL,
number_of_motorist_injured int NULL,
number_of_motorist_killed int NULL,
number_of_pedestrians_injured int NULL,
number_of_pedestrians_killed int NULL,
number_of_persons_injured int NULL,
number_of_persons_killed int NULL,
DI_JobID varchar(20) NULL,
DI_Create_Date datetime DEFAULT getdate() NULL
)

CREATE TABLE Bridge(
Dim_Vehicle_Factor_SK INT FOREIGN KEY REFERENCES Dim_Vehicle_Factor(Dim_Vehicle_Factor_SK) ,
Vehicle_Factor_Group_SK INT FOREIGN KEY REFERENCES Fct_Crash(Fct_Crash_SK),
DI_JobID varchar(20) NULL,
DI_Create_Date datetime DEFAULT getdate() NULL
)
