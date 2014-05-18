-- Spusteni skriptu z bashe
-- mysql -D ${OSD_DB} -u ${OSD_USERNAME} -p${OSD_PASSWORD} < insert.sql

-- templates
-- INSERT INTO Prodejna(id, místo_nákupu) VALUES (?, ?);
-- INSERT INTO Autor(id, autor_jmeno, autor_prijmeni) VALUES (?, ?, ?);
-- INSERT INTO Recept(id, jméno_pokrmu, Autorid) VALUES (?, ?, ?);
-- INSERT INTO Ingredience(id, název_ingredience) VALUES (?, ?);
-- INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (?, ?, ?, ?);
-- INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (?, ?, ?, ?);
-- INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (?, ?, ?);

-- Prodejny
INSERT INTO Prodejna(id, misto_nakupu) VALUES (1, "Kaufland");
INSERT INTO Prodejna(id, misto_nakupu) VALUES (2, "Vietnamec na rohu");

-- Autori receptu
INSERT INTO Autor(id, autor_jmeno) VALUES (1, "Tomas Jiricek");
INSERT INTO Autor(id, autor_jmeno) VALUES (2, "Jan Jakes");
INSERT INTO Autor(id, autor_jmeno) VALUES (3, "Zdenek Pohlreich");

-- Recepty
INSERT INTO Recept(id, jmeno_pokrmu, Autorid) VALUES (1, "Topinky", 1);
INSERT INTO Recept(id, jmeno_pokrmu, Autorid) VALUES (2, "Palacinky", 2);
INSERT INTO Recept(id, jmeno_pokrmu, Autorid) VALUES (3, "Tatarak", 1);
INSERT INTO Recept(id, jmeno_pokrmu, Autorid) VALUES (4, "Rizek", 3);

-- Ingredience
INSERT INTO Ingredience(id, nazev_ingredience) VALUES (1, "Chleba");
INSERT INTO Ingredience(id, nazev_ingredience) VALUES (2, "Cesnek");
INSERT INTO Ingredience(id, nazev_ingredience) VALUES (3, "Olej");
INSERT INTO Ingredience(id, nazev_ingredience) VALUES (4, "Sul");
INSERT INTO Ingredience(id, nazev_ingredience) VALUES (5, "Mouka");
INSERT INTO Ingredience(id, nazev_ingredience) VALUES (6, "Mleko");
INSERT INTO Ingredience(id, nazev_ingredience) VALUES (7, "Cukr");
INSERT INTO Ingredience(id, nazev_ingredience) VALUES (8, "Maso");
INSERT INTO Ingredience(id, nazev_ingredience) VALUES (9, "Pepr");
INSERT INTO Ingredience(id, nazev_ingredience) VALUES (10, "Worcester");
INSERT INTO Ingredience(id, nazev_ingredience) VALUES (11, "Horcice");
INSERT INTO Ingredience(id, nazev_ingredience) VALUES (12, "Strouhanka");

-- Recept a Ingredience
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (1, 2, 1, 1);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (2, 2, 1, 2);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (3, 2, 1, 3);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (4, 2, 1, 4);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (5, 2, 2, 3);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (6, 1, 2, 4);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (7, 1, 2, 5);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (8, 1, 2, 6);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (9, 1, 2, 7);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (10, 1, 3, 2);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (11, 1, 3, 4);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (12, 3, 3, 8);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (13, 3, 3, 9);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (14, 3, 3, 10);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (15, 3, 3, 11);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (16, 3, 4, 3);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (17, 4, 4, 4);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (18, 4, 4, 8);
INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (19, 4, 4, 12);

-- Surovina
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (1, 1, "2014-10-15", 1);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (2, 1, "2014-10-15", 2);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (3, 2, "2014-10-12", 3);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (4, 3, "2014-11-16", 4);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (5, 1, "2014-11-16", 5);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (6, 1, "2014-10-15", 6);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (7, 1, "2014-11-16", 7);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (8, 1, "2014-10-15", 8);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (9, 2, "2014-12-17", 9);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (10, 1, "2014-10-12", 10);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (11, 1, "2014-10-15", 11);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (12, 2, "2014-10-12", 12);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (13, 3, "2014-11-16", 1);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (14, 1, "2014-11-16", 2);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (15, 1, "2014-10-15", 3);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (16, 1, "2014-11-16", 4);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (17, 1, "2014-10-15", 5);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (18, 2, "2014-12-17", 6);

-- Surovina a prodejna
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (1, 1, 1);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (2, 2, 2);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (3, 3, 1);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (4, 4, 2);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (5, 5, 1);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (6, 6, 1);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (7, 7, 1);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (8, 8, 1);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (9, 9, 2);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (10, 10, 2);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (11, 11, 2);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (12, 12, 2);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (13, 13, 1);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (14, 14, 2);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (15, 15, 1);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (16, 16, 2);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (17, 17, 2);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (18, 18, 1);

