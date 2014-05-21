-- Spusteni skriptu z bashe
-- mysql -D ${OSD_DB} -u ${OSD_USERNAME} -p${OSD_PASSWORD} < delete.sql

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
