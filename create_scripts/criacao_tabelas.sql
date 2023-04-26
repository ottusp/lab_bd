CREATE TABLE circuits (
	circuitId int PRIMARY KEY,
	circuitRef varchar(255) NOT NULL,
	name varchar(255) NOT NULL,
	location varchar(255),
	country varchar(255),
	lat float, 
	lng float,
	alt float,
	url varchar(255) NOT NULL UNIQUE
);

CREATE TABLE constructors (
	constructorId int PRIMARY KEY,
	constructorRef varchar(255) NOT NULL,
	name varchar(255) NOT NULL UNIQUE,
	nationality varchar(255),
	url varchar(255) NOT NULL
);

CREATE TABLE drivers (
	driverId int PRIMARY KEY,
	driverRef varchar(255) NOT NULL,
	number int,
	code varchar(3),
	forename varchar(255) NOT NULL,
	surname varchar(255) NOT NULL,
	dob date,
	nationality varchar(255),
	url varchar(255) NOT NULL UNIQUE
);

CREATE TABLE seasons (
	year int PRIMARY KEY,
	url varchar(255) NOT NULL UNIQUE
);

CREATE TABLE races (
	raceId int PRIMARY KEY,
	year int NOT NULL REFERENCES seasons(year),
	round int NOT NULL,
	circuitId int NOT NULL REFERENCES circuits(circuitId),
	name varchar(255) NOT NULL,
	date date NOT NULL,
	time time,
	url varchar(255) UNIQUE,
	fp1_date date,
	fp1_time time,
	fp2_date date,
	fp2_time time,
	fp3_date date,
	fp3_time time,
	quali_date date,
	quali_time time,
	sprint_date date,
	sprint_time time
);

CREATE TABLE driver_standings (
	driverStandingsId int PRIMARY KEY,
	raceId int NOT NULL REFERENCES races(raceId),
	driverId int NOT NULL REFERENCES drivers(driverId),
	points float NOT NULL,
	position int,
	positionText varchar(255),
	wins int NOT NULL
);

CREATE TABLE lap_times (
	raceId int NOT NULL REFERENCES races(raceId),
	driverId int NOT NULL REFERENCES drivers(driverId),
	lap int NOT NULL,
	position int,
	time varchar(255),
	milliseconds int,
	PRIMARY KEY (raceId, driverId, lap)
);

CREATE TABLE pit_stops (
	raceId int NOT NULL REFERENCES races(raceId),
	driverId int NOT NULL REFERENCES drivers(driverId),
	stop int NOT NULL,
	lap int NOT NULL,
	time time NOT NULL,
	duration varchar(255),
	milliseconds int,
	PRIMARY KEY (raceId, driverId, stop)
);

CREATE TABLE qualifying (
	qualifyId int PRIMARY KEY,
	raceId int NOT NULL REFERENCES races(raceId),
	driverId int NOT NULL REFERENCES drivers(driverId),
	constructorId int NOT NULL REFERENCES constructors(constructorId),
	number int NOT NULL,
	position int,
	q1 varchar(255),
	q2 varchar(255),
	q3 varchar(255)
);

CREATE TABLE status (
	statusId int PRIMARY KEY,
	status varchar(255) NOT NULL
);

CREATE TABLE results (
	resultId int PRIMARY KEY,
	raceId int NOT NULL REFERENCES races(raceId),
	driverId int NOT NULL REFERENCES drivers(driverId),
	constructorId int NOT NULL REFERENCES constructors(constructorId),
	number int,
	grid int NOT NULL,
	position int,
	positionText varchar(255) NOT NULL,
	positionOrder int NOT NULL,
	points float NOT NULL,
	laps int NOT NULL,
	time varchar(255),
	milliseconds int,
	fastestLap int,
	rank int,
	fastestLapTime varchar(255),
	fastestLapSpeed varchar(255),
	statusId int NOT NULL REFERENCES status(statusId)
);


CREATE TABLE airports (
	id int PRIMARY KEY,
	ident varchar(255) NOT NULL UNIQUE,
	type varchar(255) NOT NULL,
	name varchar(255) NOT NULL,
	latitude_deg float NOT NULL,
	longitude_deg float NOT NULL,
	elevation_ft float,
	continent varchar(255),
	iso_country varchar(255),
	iso_region varchar(255) NOT NULL,
	municipality varchar(255),
	scheduled_service varchar(255) NOT NULL,
	gps_code varchar(255),
	iata_code varchar(255),
	local_code varchar(255),
	home_link varchar(255),
	wikipedia_link varchar(255),
	keywords varchar(255)
);


CREATE TABLE geocities15k (
	geonameid int PRIMARY KEY,
	name varchar(255) NOT NULL,
	asciiname varchar(255) NOT NULL,
	alternatenames varchar(255),
	lat float NOT NULL,
	long float NOT NULL,
	featureclass varchar(255) NOT NULL,
	featurecode varchar(255) NOT NULL,
	country varchar(255),
	cc2 varchar(255),
	admin1code varchar(255),
	admin2code varchar(255),
	admin3code varchar(255),
	admin4code varchar(255),
	population int NOT NULL,
	elevation float,
	dem int NOT NULL,
	timezone varchar(255) NOT NULL,
	modification date NOT NULL
);

CREATE TABLE countries (
	id int NOT NULL PRIMARY KEY,
	code varchar(255) NOT NULL UNIQUE,
	name varchar(255) NOT NULL UNIQUE,
	continent varchar(255),
	wikipedia_link varchar(255),
	keywords varchar(255),
	UNIQUE (code, name)
);