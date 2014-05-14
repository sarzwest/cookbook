-- templates
-- INSERT INTO Autor(id, autor_jmeno, autor_prijmeni) VALUES (?, ?, ?);
-- INSERT INTO Recept(id, jméno_pokrmu, Autorid) VALUES (?, ?, ?);
-- INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (?, ?, ?, ?);
-- INSERT INTO Prodejna(id, místo_nákupu) VALUES (?, ?);
-- INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (?, ?, ?);
-- INSERT INTO Ingredience(id, název_ingredience, Receptid) VALUES (?, ?, ?);
-- INSERT INTO Recept_Ingredience(id, Receptid, Ingredienceid) VALUES (?, ?, ?);

-- Prodejny
INSERT INTO Prodejna(id, místo_nákupu) VALUES (1, "Kaufland");
INSERT INTO Prodejna(id, místo_nákupu) VALUES (2, "Vietnamec na rohu");

-- Recepty
INSERT INTO Recept(id, jméno_pokrmu, Autorid) VALUES (1, "Topinky", 1);
INSERT INTO Recept(id, jméno_pokrmu, Autorid) VALUES (2, "Palacinky", 2);
INSERT INTO Recept(id, jméno_pokrmu, Autorid) VALUES (3, "Tatarak", 1);
INSERT INTO Recept(id, jméno_pokrmu, Autorid) VALUES (4, "Rizek", 3);

-- Autori receptu
INSERT INTO Autor(id, autor_jmeno, autor_prijmeni) VALUES (1, "Tomas", "Jiricek");
INSERT INTO Autor(id, autor_jmeno, autor_prijmeni) VALUES (2, "Jan", "Jakes");
INSERT INTO Autor(id, autor_jmeno, autor_prijmeni) VALUES (3, "Zdenek", "Pohlreich");

-- Ingredience
INSERT INTO Ingredience(id, název_ingredience, Receptid) VALUES (1, ?, ?);
INSERT INTO Ingredience(id, název_ingredience, Receptid) VALUES (2, ?, ?);
INSERT INTO Ingredience(id, název_ingredience, Receptid) VALUES (3, ?, ?);
INSERT INTO Ingredience(id, název_ingredience, Receptid) VALUES (4, ?, ?);
INSERT INTO Ingredience(id, název_ingredience, Receptid) VALUES (5, ?, ?);
INSERT INTO Ingredience(id, název_ingredience, Receptid) VALUES (6, ?, ?);
INSERT INTO Ingredience(id, název_ingredience, Receptid) VALUES (7, ?, ?);
INSERT INTO Ingredience(id, název_ingredience, Receptid) VALUES (?, ?, ?);




