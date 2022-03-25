CREATE TABLE Bruker (
   BrukerId    INTEGER NOT NULL UNIQUE,
   Fornavn   VARCHAR(30) NOT NULL,
   Etternavn   VARCHAR(30) NOT NULL,
   Epost   VARCHAR(30) NOT NULL UNIQUE,
   Passord   VARCHAR(30) NOT NULL,
   CONSTRAINT Bruker_PK PRIMARY KEY (BrukerId));

CREATE TABLE Kaffesmak (
   SmakId    INTEGER NOT NULL UNIQUE,
   Notater   VARCHAR(8000),
   Poeng     INTEGER CHECK (Poeng > 0 AND Poeng <= 10),
   Dag     INTEGER(2),
   Maaned  INTEGER(2),
   Aar INTEGER(4),
   BrukerId INTEGER NOT NULL,
   KaffeId INTEGER NOT NULL,
   CONSTRAINT Kaffesmak_PK PRIMARY KEY (SmakId),
   CONSTRAINT Kaffesmak_FK1 FOREIGN KEY (BrukerId) REFERENCES Bruker(BrukerId)
      ON UPDATE CASCADE
      ON DELETE NO ACTION,
   CONSTRAINT Kaffesmak_FK2 FOREIGN KEY (KaffeId) REFERENCES Kaffe(KaffeId)
      ON UPDATE CASCADE
      ON DELETE NO ACTION );

CREATE TABLE Kaffe (
   KaffeId    INTEGER NOT NULL UNIQUE,
   Brenningsgrad  VARCHAR(30) CHECK(Brenningsgrad = 'Lys' OR Brenningsgrad = 'Medium' OR Brenningsgrad = 'Mørk'),
   Dag     INTEGER(2),
   Maaned  INTEGER(2),
   Aar INTEGER(4),
   Navn VARCHAR(30),
   Beskrivelse VARCHAR(8000),
   Kilopris INTEGER(10),
   PartiId  INTEGER NOT NULL,
   BrenneriId  INTEGER NOT NULL,
   CONSTRAINT Kaffe_PK PRIMARY Key (KaffeId),
   CONSTRAINT Kaffe_FK1 FOREIGN KEY (PartiId) REFERENCES KaffeParti(PartiId)
       ON UPDATE CASCADE
       ON DELETE NO ACTION,
   CONSTRAINT Kaffe_FK2 FOREIGN KEY (BrenneriId) REFERENCES KaffeBrenneri(BrenneriId)
       ON UPDATE CASCADE
       ON DELETE NO ACTION);

CREATE TABLE Kaffebrenneri (
   BrenneriId   INTEGER NOT NULL UNIQUE,
   Navn    VARCHAR(30),
   Sted VARCHAR(30),
   CONSTRAINT KaffeBrenneri_PK PRIMARY Key (BrenneriId)
);

CREATE TABLE Kaffeparti (
   PartiId    INTEGER NOT NULL UNIQUE,
   Aar INTEGER(4), 
   BetalingUSD INTEGER(7),
   GaardId INTEGER NOT NULL,
   MetodeId INTEGER NOT NULL,
   CONSTRAINT Kaffeparti_PK PRIMARY Key (PartiId),
   CONSTRAINT Kaffeparti_FK1 FOREIGN Key (GaardId) REFERENCES KaffeParti(PartiId)
       ON UPDATE CASCADE
       ON DELETE NO ACTION,
   CONSTRAINT Kaffeparti_FK2 FOREIGN Key (MetodeId) REFERENCES Foredlingsmetode(MetodeId)
       ON UPDATE CASCADE
       ON DELETE NO ACTION

);
CREATE TABLE Foredlingsmetode(
   MetodeId INTEGER NOT NUll UNIQUE,
   Navn VARCHAR(30),
   Beskrivelse VARCHAR(8000),
   CONSTRAINT Foredlingsmetode_PK PRIMARY Key (MetodeId)

);
CREATE TABLE Gaard (
   GaardId INTEGER NOT NULL UNIQUE,
   Moh INTEGER(4),
   Navn VARCHAR(30),
   Land VARCHAR(30) NOT NULL,
   Region VARCHAR(30) NOT NULL,
   CONSTRAINT Gaard_PK PRIMARY Key (GaardId)
);

CREATE TABLE Kaffebonne (
   BonneId INTEGER NOT NULL UNIQUE,
   Art VARCHAR(30) CHECK(Art = 'coffea arabica' OR Art = 'coffea robusta' OR Art='coffea liberica') NOT NULL ,
   CONSTRAINT Kaffebonne_PK PRIMARY Key (BonneId),
   CONSTRAINT Kaffebonne_FK FOREIGN Key (Art) REFERENCES Art(Navn)
            ON UPDATE CASCADE
            ON DELETE NO ACTION

);

CREATE TABLE DyrkesAv(
   BonneId INTEGER NOT NULL,
   GaardId INTEGER NOT NULL,
   CONSTRAINT DyrkesAv_PK PRIMARY Key (BonneId, GaardId),
   CONSTRAINT DyrkesAv_FK1 FOREIGN Key (BonneId) REFERENCES Kaffebonne(BonneId)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
   CONSTRAINT DyrkesAv_FK2 FOREIGN Key (GaardId) REFERENCES Gaard(GaardId)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

INSERT INTO Bruker VALUES (1, 'Test', 'Testesen', 'Test@gmail.com', 'passord123');
INSERT INTO Bruker VALUES (2, 'Test2', 'Testesen2', 'Test2@gmail.com', 'passord1');

INSERT INTO Gaard VALUES (1, 1500, 'Nombre de Dios', 'El Salvador', 'Santa Ana');
INSERT INTO Gaard VALUES (2, 700, 'Rwandias', 'Rwanda', 'Butare');
INSERT INTO Gaard VALUES (3, 200, 'Colombos', 'Colombia', 'Meta');


INSERT INTO Foredlingsmetode VALUES (1, 'bærtørket Bourbon', 'gir fyldig smak' );
INSERT INTO Foredlingsmetode VALUES (2, 'vasket', 'gjør kaffen svakere');

INSERT INTO Kaffebrenneri VALUES (1, 'Jacobsen & Svart', 'Trondheim');
INSERT INTO Kaffebrenneri VALUES (2, 'HovedBrenneriet ', 'Oslo');
INSERT INTO Kaffebrenneri VALUES (3, 'Pomple&Pilt ', 'Kristiansand');


INSERT INTO Kaffebonne VALUES (1, 'coffea arabica');
INSERT INTO Kaffebonne VALUES (2, 'coffea robusta');
INSERT INTO Kaffebonne VALUES (3, 'coffea liberica');

INSERT INTO Kaffeparti VAlUES (1, 2021, 8, 1, 1);
INSERT INTO Kaffeparti VAlUES (2, 2022, 10, 2, 2);
INSERT INTO Kaffeparti VAlUES (3, 2022, 9, 3, 1);
INSERT INTO Kaffeparti VAlUES (4, 2020, 7, 2, 1);
INSERT INTO Kaffeparti VAlUES (5, 2021, 9, 2, 2);

INSERT INTO Kaffe VALUES (1, 'Lys', 20, 01, 2022, 'Vinterkaffe 2022', 'En velsmakende og kompleks kaffe for
mørketiden', 600, 1, 1 );
INSERT INTO Kaffe VALUES (2, 'Medium', 18, 03, 2022, 'Spesialiteten', 'En god og fyldig kaffe', 550, 2, 2 );
INSERT INTO Kaffe VALUES (3, 'Lys', 23, 04, 2021, '2022 favoritt', 'Mye aroma og veldig floral', 300, 3, 1 );
INSERT INTO Kaffe VALUES (4, 'Medium', 03, 10, 2020, 'Costa de kaffe', 'Laget med kjærlighet og tålmodighet', 700, 4, 3 );
INSERT INTO Kaffe VALUES (5, 'Mørk', 21, 01, 2021, 'Fantsic', 'Godt brent og mye smak', 650, 5, 1 );



INSERT INTO Kaffesmak VALUES(1, 'Ekstremt floral', 8, 30, 01, 2022, 1, 2);
INSERT INTO Kaffesmak VALUES(2, 'Floral som en blomstereng', 6, 27, 02, 2021, 2, 3);
INSERT INTO Kaffesmak VALUES(3, 'Mest fantastiske jeg har smakt noen gang', 10, 22, 11, 2020, 2, 4);
INSERT INTO Kaffesmak VALUES(4, 'Stor på smak men litt mye', 5, 23, 02, 2022, 1, 3);
INSERT INTO Kaffesmak VALUES(5, 'Ikke veldig god', 3, 24, 10, 2022, 2, 2);


