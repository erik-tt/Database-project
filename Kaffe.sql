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
   Brenningsgrad  VARCHAR(30),
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
   Art VARCHAR(30) NOT NULL,
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

