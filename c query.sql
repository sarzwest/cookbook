SELECT id, nazev_ingredience, potrebaKusu FROM (SELECT Ingredienceid, potrebaKusu FROM Recept_Ingredience WHERE (SELECT id FROM Recept WHERE jmeno_pokrmu = 'Palacinky' group by jmeno_pokrmu) = Receptid) AS R, Ingredience WHERE Ingredience.id = R.Ingredienceid;


-- Tabulka ingredienci potrebna na recept
