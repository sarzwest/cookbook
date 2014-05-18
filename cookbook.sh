#!/bin/bash
#Usage: cookbook.sh --insert recipes < input-recipes.txt
#Usage: cookbook.sh --insert fridge < input-fridge.txt
#       cookbook.sh --query recipes <author>
#       cookbook.sh --query shortest <date>
#       cookbook.sh --query buy <recipe>
#       cookbook.sh --variant
#       cookbook.sh --debug

pass="contain";
db="jakesjan";
user="jakesjan";


if [ "$1" = "--insert" ];
then
    #
    # Pridani receptu
    #
    if [ "$2" = "recipes" ];
    then
	while read lineData 
	do
	    echo "---------------------------------------------";
	    echo "$lineData";
	    let count=0;
	    OIFS=$IFS;   # !!! NEMAZAT !!!!
	    IFS=",";
	    parseLine="$lineData";
	    for x in $parseLine
	    do
		x=`echo "$x" | sed 's/ *//'`;
		if [ "$count" -eq  0 ];
		then
		    recept="$x";
		elif [ "$count" -eq 1 ];
		then
		    autor="$x";
		    exist=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT id FROM Autor WHERE autor_jmeno = '$autor';");
		    #
		    #Kontrola zda Autor uz existuje;
		    #
		    if [ "$exist" = "" ];
		    then
		    #
		    # Pokud neexistuje pridam do databaze.
		    #
			maxAutor=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Autor;"); #vrati nejvyssi id
			idAutor=$(echo "$maxAutor" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
			let idAutor=idAutor+1;
			echo "Novy Autor: $autor  id: $idAutor"
			mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Autor(id, autor_jmeno) VALUES (\"$idAutor\", \"$autor\");";
		    else
		    #
		    # Autor existuje.
		    #
			idAutor=$(echo "$exist" | tr -d "id\n ");
			echo "Existujici autor: $autor  id: $idAutor";
		    fi;
		    #
		    # Pridani receptu do databaze.
		    #
		    maxRecept=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Recept;"); #vrati hodnotu max id
		    idRecept=$(echo "$maxRecept" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
		    let idRecept=idRecept+1;
		    echo "Novy recept: $recept  id: $idRecept  idAutor: $idAutor";
		    mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Recept(id, jmeno_pokrmu, Autorid) VALUES (\"$idRecept\",\"$recept\", \"$idAutor\");"
		else
		    if [ $(($count % 2)) -eq 0 ];
		    then
			ingredience="$x";
			existIng=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT id FROM Ingredience WHERE nazev_ingredience = '$ingredience';");
			#
			# Kontrola zda existuje Ingredience
			#
			if [ "$existIng" = "" ];
			then
			    #
			    # Ingredience neni v databazi tak ji pridam.
			    #
			    maxIng=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Ingredience;"); #vrati nejvyssi id
			    idIngredience=$(echo "$maxIng" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
			    let idIngredience=idIngredience+1;
			    mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Ingredience(id, nazev_ingredience) VALUES (\"$idIngredience\", \"$ingredience\");";
			else
			    #
			    # Ingredience je v databazi
			    #
			    idIngredience=$(echo "$existIng" | tr -d "id \n ");
			fi;
		    else
			#
			# Pridani poctu ingredienci do Recept_Ingredience
			#
			pocetIng="$x";
			maxReceptIng=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Recept_Ingredience;"); #vrati hodnotu max id
			idReceptIng=$(echo "$maxReceptIng" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
			let idReceptIng=idReceptIng+1;
			mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (\"$idReceptIng\",\"$pocetIng\", \"$idRecept\", \"$idIngredience\");"
		    fi;
		fi;
		let count++;
	    done
	    IFS=$OIFS;
	done


    #
    # Pridani veci do lednice
    #
    elif [ "$2" = "fridge" ];
    then
	while read lineData
	do
	    #echo "$lineData";
	    OIFS=$IFS;   ## !!!! NEMAZAT  !!!!
	    IFS=",";
	    let count=0;
	    parseLine=$lineData;
	    for x in $parseLine
	    do
		x=`echo "$x" | sed 's/ *//'`;
		if [ "$count" -eq 0 ];
		then
		    surovina=$x;
		elif [ "$count" -eq 1 ];
		then
		    pocetIng=$x;
		elif [ "$count" -eq 2 ];
		then
		    datum=$x;
		elif [ "$count" -eq 3 ];
		then
		    prodejna=$x;
		fi;
		let count++;
	    done
	    #
	    # Kontrola zda existuje obchod
	    #
	    existProdejna=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT id FROM Prodejna WHERE misto_nakupu = '$prodejna';");
	    if [ "$existProdejna" = "" ];
	    then
	    #
	    # Pridam prodejnu do databaze
	    #
		maxProdejna=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Prodejna;"); #vrati nejvyssi id
		idProdejna=$(echo "$maxProdejna" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
		let idProdejna=idProdejna+1;
		mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Prodejna(misto_nakupu, id) VALUES (\"$prodejna\", \"$idProdejna\");";
	    else
	    #
	    # Najdu prodejnu v databazi
	    #
		idProdejna=$(echo "$existProdejna" | tr -d "id \n ");
	    fi;
	    
	    #
	    # Kontrola zda existuje Ingedience
	    #
	    existIng=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT id FROM Ingredience WHERE nazev_ingredience = '$surovina';");
	    if [ "$existIng" = "" ];
	    then
	    #
	    # Pridam Ingredienci do databaze
	    #
		maxIng=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Ingredience;"); #vrati nejvyssi id
		idIng=$(echo "$maxIng" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
		let idIng=idIng+1;
		mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Ingredience(id, nazev_ingredience) VALUES (\"$idIng\", \"$surovina\");";
	    else
	    #
	    # Najdu Ingredienci v databazi
	    #
		idIng=$(echo "$existIng" | tr -d "id \n ");
	    fi;
	    
	    
	    #
	    # Pridani suroviny
	    #
	    maxSurovina=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Surovina;"); #vrati hodnotu max id
	    idSurovina=$(echo "$maxSurovina" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
	    let idSurovina=idSurovina+1;
	    mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (\"$idSurovina\",\"$pocetIng\", \"$datum\", \"$idIng\");"
	
	    #
	    # Pridani Surovina_Prodejna
	    #
	    maxSurovinaProdejna=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Surovina_Prodejna;"); #vrati hodnotu max id
	    idSurovinaProdejna=$(echo "$maxSurovinaProdejna" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
	    let idSurovinaProdejna=idSurovinaProdejna+1;
	    mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (\"$idSurovinaProdejna\",\"$idSurovina\", \"$idProdejna\");"
	    
	    
	    
	    IFS=$OIFS;
	done
    else
	exit 1;
    fi;



#
# Parametry query
#
elif [ "$1" = "--query" ];
then
    if [ "$2" = "recipes" ];
    then
	jmeno="$3";
	a=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT Autor.autor_jmeno, Recept.jmeno_pokrmu FROM Autor, Recept WHERE Autorid = Autor.id AND autor_jmeno = '$jmeno'";);
	if [ "$a" = "" ];
	then
	    exit 2;
	else
	    echo "$a";
	fi;
    elif [ "$2" = "shortest" ];
    then
	datum="$3";
	b=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT result.jmeno_pokrmu FROM ( SELECT jmeno_pokrmu, count(jmeno_pokrmu) AS pocetSurovin FROM Recept, Recept_Ingredience, Ingredience, Surovina WHERE Recept_Ingredience.Ingredienceid = Ingredience.id AND Recept.id = Receptid AND Ingredience.id = Surovina.Ingredienceid AND trvanlivost <= '$datum' group by jmeno_pokrmu order by jmeno_pokrmu asc) AS result order by pocetSurovin desc limit 1";);
        if [ "$b" = "" ];
        then
	    exit 2;
	else
	    echo "$b";
        fi;
    elif [ "$2" = "buy" ];
    then
	recept="$3";
	c=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT Autor.autor_jmeno, Recept.jmeno_pokrmu FROM Autor, Recept WHERE Autorid = Autor.id AND autor_jmeno = '$jmeno'";);
#
#
#dodelat !!!!!!!
#
#
		    
	else
	exit 1;
    fi;


elif [ "$1" = "--variant" ];
then
    echo "2";
elif [ "$1" = "--debug" ];
then
    echo "debug";
else
    exit 1;
fi;

