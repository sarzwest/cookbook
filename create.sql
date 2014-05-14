-- remove relationships
ALTER TABLE Recept DROP FOREIGN KEY FKRecept63372;
ALTER TABLE Surovina_Prodejna DROP FOREIGN KEY FKSurovina_P759736;
ALTER TABLE Surovina_Prodejna DROP FOREIGN KEY FKSurovina_P295292;
ALTER TABLE Surovina DROP FOREIGN KEY FKSurovina493040;
ALTER TABLE Recept_Ingredience DROP FOREIGN KEY FKRecept_Ing442947;
ALTER TABLE Recept_Ingredience DROP FOREIGN KEY FKRecept_Ing999432;
-- remove tables
DROP TABLE IF EXISTS Ingredience;
DROP TABLE IF EXISTS Surovina_Prodejna;
DROP TABLE IF EXISTS Prodejna;
DROP TABLE IF EXISTS Surovina;
DROP TABLE IF EXISTS Recept;
DROP TABLE IF EXISTS Autor;
DROP TABLE IF EXISTS Recept_Ingredience;
-- create tables
CREATE TABLE Ingredience (id int(10) NOT NULL AUTO_INCREMENT, název_ingredience varchar(20), Receptid int(10) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB;
CREATE TABLE Surovina_Prodejna (id int(10) NOT NULL, Surovinaid int(10) NOT NULL, Prodejnaid int(10) NOT NULL, PRIMARY KEY (id, Surovinaid, Prodejnaid)) ENGINE=InnoDB;
CREATE TABLE Prodejna (místo_nákupu varchar(20), id int(10) NOT NULL AUTO_INCREMENT, PRIMARY KEY (id)) ENGINE=InnoDB;
CREATE TABLE Surovina (id int(10) NOT NULL AUTO_INCREMENT, kusuVLednici int(10), trvanlivost date, Ingredienceid int(10) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB;
CREATE TABLE Recept (id int(10) NOT NULL AUTO_INCREMENT, jméno_pokrmu varchar(20), Autorid int(10) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB;
CREATE TABLE Autor (id int(10) NOT NULL AUTO_INCREMENT, autor_jmeno varchar(20), autor_prijmeni varchar(20), PRIMARY KEY (id)) ENGINE=InnoDB;
CREATE TABLE Recept_Ingredience (id int(10) NOT NULL, Receptid int(10) NOT NULL, Ingredienceid int(10) NOT NULL, PRIMARY KEY (id, Receptid, Ingredienceid)) ENGINE=InnoDB;
-- create foreign keys and constraints
ALTER TABLE Recept ADD INDEX FKRecept63372 (Autorid), ADD CONSTRAINT FKRecept63372 FOREIGN KEY (Autorid) REFERENCES Autor (id);
ALTER TABLE Surovina_Prodejna ADD INDEX FKSurovina_P759736 (Surovinaid), ADD CONSTRAINT FKSurovina_P759736 FOREIGN KEY (Surovinaid) REFERENCES Surovina (id);
ALTER TABLE Surovina_Prodejna ADD INDEX FKSurovina_P295292 (Prodejnaid), ADD CONSTRAINT FKSurovina_P295292 FOREIGN KEY (Prodejnaid) REFERENCES Prodejna (id);
ALTER TABLE Surovina ADD INDEX FKSurovina493040 (Ingredienceid), ADD CONSTRAINT FKSurovina493040 FOREIGN KEY (Ingredienceid) REFERENCES Ingredience (id);
ALTER TABLE Recept_Ingredience ADD INDEX FKRecept_Ing442947 (Receptid), ADD CONSTRAINT FKRecept_Ing442947 FOREIGN KEY (Receptid) REFERENCES Recept (id);
ALTER TABLE Recept_Ingredience ADD INDEX FKRecept_Ing999432 (Ingredienceid), ADD CONSTRAINT FKRecept_Ing999432 FOREIGN KEY (Ingredienceid) REFERENCES Ingredience (id);

