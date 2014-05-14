select result.jméno_pokrmu from ( select jméno_pokrmu, count(jméno_pokrmu) as pocetSurovin from Recept, Recept_Ingredience, Ingredience, Surovina where Recept_Ingredience.Ingredienceid = Ingredience.id and Recept.id = Receptid and Ingredience.id = Surovina.Ingredienceid and trvanlivost <= '2014-10-12' group by jméno_pokrmu order by jméno_pokrmu asc) as result order by pocetSurovin desc limit 1

-- Nejvíc surovin se bere jako nejvíc druhů
