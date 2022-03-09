CREATE TABLE Bruker (
   BrukerId    INTEGER NOT NULL,
   Fornavn   VARCHAR(30),
   Etternavn   VARCHAR(30),
   E-post   VARCHAR(30),
   Passord   VARCHAR(30),
   CONSTRAINT Bruker_PK PRIMARY KEY (BrukerId));

CREATE TABLE Kaffesmak (
   SmakId    INTEGER NOT NULL,
   Notater     VARCHAR(30),
   Dato     VARCHAR(30),
   Poeng     INTEGER,
   BrukerId INTEGER NOT NULL,
   CONSTRAINT Kaffesmak_PK PRIMARY KEY (SmakId),
   CONSTRAINT Kaffesmak_FK FOREIGN KEY (BrukerId) REFERENCES Bruker(BrukerId)
      ON UPDATE CASCADE
      ON DELETE NO ACTION);

CREATE TABLE Kaffe (
   KaffeId    INTEGER NOT NULL,
   Brenningsgrad  VARCHAR(30),
   Navn VARCHAR(30),
   Beskrivelse VARCHAR(30),
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
   BrenneriId   INTEGER NOT NULL,
   Navn    VARCHAR(30),
   CONSTRAINT KaffeBrenneri_PK PRIMARY Key (BrenneriId)
)

CREATE TABLE Kaffeparti (
   PartiId    INTEGER NOT NULL,
   Aar INTEGER(4),
   GaardId INTEGER NOT NULL,
   CONSTRAINT Kaffeparti_PK PRIMARY Key (PartiId),
   CONSTRAINT Kaffeparti_FK FOREIGN Key (GaardId) REFERENCES KaffeParti(PartiId)
       ON UPDATE CASCADE
       ON DELETE NO ACTION,

)

CREATE TABLE Gaard (
   GaardId INTEGER NOT NULL,
   Moh INTEGER(4),
   Landskode INTEGER NOT NULL,
   RegionNavn VARCHAR(30) NOT NULL,
   CONSTRAINT Gaard_PK PRIMARY Key (GaardId),
   CONSTRAINT Gaard_FK1 FOREIGN Key (Landskode) REFERENCES Land(Landskode)
            ON UPDATE CASCADE,
            ON DELETE CASCADE,
   CONSTRAINT Gaard_FK2 FOREIGN Key (RegionNavn) REFERENCES Region(Navn)
            ON UPDATE CASCADE,
            ON DELETE CASCADE
)

CREATE TABLE Kaffebonne (
   BonneId INTEGER NOT NULL,
   Artnavn VARCHAR(30) NOT NULL,
   CONSTRAINT Kaffebonne_PK PRIMARY Key (BonneId),
   CONSTRAINT Kaffebonne_FK FOREIGN Key (Artnavn) REFERENCES Art(Navn)
            ON UPDATE CASCADE,
            ON DELETE NO ACTION

)

CREATE TABLE DyrkesAv(
   Artnavn VARCHAR(30) NOT NULL,
   GaardId INTEGER NOT NULL,
   CONSTRAINT DyrkesAv_PK PRIMARY Key (Artnavn, GaardId),
   CONSTRAINT DyrkesAv_FK1 FOREIGN Key (Artnavn) REFERENCES Art(Navn)
            ON UPDATE CASCADE,
            ON DELETE CASCADE,
   CONSTRAINT DyrkesAv_FK2 FOREIGN Key (GaardId) REFERENCES Art(Navn)
            ON UPDATE CASCADE,
            ON DELETE CASCADE
)

CREATE TABLE Art(
   Navn VARCHAR(30) NOT NULL,
   CONSTRAINT Art_PK PRIMARY Key (Navn)
)

CREATE TABLE Region(
    Landskode INTEGER NOT NULL,
    Navn VARCHAR(30) NOT NULL,
    CONSTRAINT Region_PK PRIMARY Key (Landskode, Navn),
   CONSTRAINT Region_FK FOREIGN Key (Landskode) REFERENCES Land(Landskode)
            ON UPDATE CASCADE,
            ON DELETE CASCADE,
)

CREATE TABLE Land(
    Landskode INTEGER NOT NULL,
    Navn VARCHAR(30) NOT NULL,
    CONSTRAINT Region_PK PRIMARY Key (Landskode, Navn)
)