INSERT INTO Autor(id, autor_jmeno, autor_prijmeni) VALUES (?, ?, ?);
INSERT INTO Recept(id, jméno_pokrmu, Autorid) VALUES (?, ?, ?);
INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (?, ?, ?, ?);
INSERT INTO Prodejna(id, místo_nákupu) VALUES (?, ?);
INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (?, ?, ?);
INSERT INTO Ingredience(id, název_ingredience, Receptid) VALUES (?, ?, ?);

