#!/bin/bash
#Autor: Jan Jakes, Tomas Jiricek
#E-mail: jakesjan@fel.cvut.cz, jiricto2@fel.cvut.cz
#Skript pro obsluhu databaze kucharskych receptu.
#
#Usage: cookbook.sh [--debug] --insert recipes < input-recipes.txt
# 	cookbook.sh [--debug] --insert fridge < input-fridge.txt
#       cookbook.sh [--debug] --query recipes <author>
#       cookbook.sh [--debug] --query shortest <date>
#       cookbook.sh [--debug] --query buy <recipe>
#       cookbook.sh --variant
#       cookbook.sh -h|--help

pass="contain";
db="jakesjan";
user="jakesjan";

if [ $OSD_DB != "" ]; then
	db="$OSD_DB";
	user="$OSD_USERNAME";
	pass="$OSD_PASSWORD";
fi

p1="";		#napr --insert, --query
p2="";		#napr recipes, fridge
p3="";		#napr <Autor> <Datum>
debug=""; 	#napr --debug
help=""; 	#napr --help
variant="2";

#parsing input arguments BEGIN
args=`getopt -n "$0" -o "h" --long "help,debug,insert:,query:,variant" -- "$@" end`
eval set -- "$args"

while true ; do
	case "$1" in
		--debug) 
			debug="$1" ; 
			shift ;;
		--insert) 
			p1="$1" ;
			case "$2" in
				fridge) 
					p2="$2" ;
					shift 2 ;;
				recipes)
					p2="$2" ;
					shift 2 ;;
				*)
					echo "Input arguments error for: $2" >&2 ; exit 10;
			esac ;;
		--query) 
			p1="$1" ; 
			case "$2" in
				recipes)
					p2="$2" ;
					p3="$4" ;
					shift 2 ;;
				shortest)
					p2="$2" ;
					p3="$4" ;
					shift 2 ;;
				buy)
					p2="$2" ;
					p3="$4" ;
					shift 2 ;;
				*)
					echo "Input arguments error for: $2" >&2 ; exit 11;
			esac ;;
		-h|--help) 
			help="--help" ; 
			shift ;;
		--variant)
			echo "$variant";
			exit 0;;
		--) 	
			shift ;;
		end) 
			shift ; 
			break ;;
		*) 
			shift ;;
	esac
done

if [ "$debug" = "--debug" ]; then
	echo "Input parameters parsed succesfully.";
fi
#parsing input arguments END

if [ "$p1" = "--insert" ];
then
    #
    # Pridani receptu
    #
    if [ "$p2" = "recipes" ];
    then
	while read lineData 
	do
	    if [ "$debug" = "--debug" ];	#DEBUG vypis
	    then
		echo "---------------------------------------------";
		echo "Nacteny radek:  $lineData";
	    fi;
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
		    if [ $? -ne 0 ];
		    then
			exit 3;
		    fi;
		    #
		    #Kontrola zda Autor uz existuje;
		    #
		    if [ "$exist" = "" ];
		    then
		    #
		    # Pokud neexistuje pridam do databaze.
		    #
			maxAutor=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Autor;"); #vrati nejvyssi id
			if [ $? -ne 0 ];
			then
			    exit 3;
			fi;
			idAutor=$(echo "$maxAutor" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
			let idAutor=idAutor+1;
			mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Autor(id, autor_jmeno) VALUES (\"$idAutor\", \"$autor\");";
			if [ $? -ne 0 ];
			then
			    exit 3;
			fi;
			if [ $debug = "--debug" ];	# DEBUG vypis
			then
			    echo "Novy Autor: $autor  id: $idAutor";
			fi;
		    else
		    #
		    # Autor existuje.
		    #
			idAutor=$(echo "$exist" | tr -d "id\n ");
			if [ $debug = "--debug" ];	# DEBUG vypis
			then
			    echo "Existujici autor: $autor  id: $idAutor";
			fi;
		    fi;
		    #
		    # Pridani receptu do databaze.
		    #
		    maxRecept=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Recept;"); #vrati hodnotu max id
		    if [ $? -ne 0 ];
		    then
			exit 3;
		    fi;
		    idRecept=$(echo "$maxRecept" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
		    let idRecept=idRecept+1;
		    mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Recept(id, jmeno_pokrmu, Autorid) VALUES (\"$idRecept\",\"$recept\", \"$idAutor\");"
		    if [ $? -ne 0 ];
		    then
			exit 3;
		    fi;
		    if [ $debug = "--debug" ];	# DEBUG vypis
		    then
			echo "Novy recept: $recept  id: $idRecept  idAutor: $idAutor";
		    fi;
		else
		    if [ $(($count % 2)) -eq 0 ];
		    then
			ingredience="$x";
			existIng=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT id FROM Ingredience WHERE nazev_ingredience = '$ingredience';");
			if [ $? -ne 0 ];
			then
			    exit 3;
			fi;
			#
			# Kontrola zda existuje Ingredience
			#
			if [ "$existIng" = "" ];
			then
			    #
			    # Ingredience neni v databazi tak ji pridam.
			    #
			    maxIng=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Ingredience;"); #vrati nejvyssi id
			    if [ $? -ne 0 ];
			    then
				exit 3;
			    fi;
			    idIngredience=$(echo "$maxIng" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
			    let idIngredience=idIngredience+1;
			    mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Ingredience(id, nazev_ingredience) VALUES (\"$idIngredience\", \"$ingredience\");";
			    if [ $? -ne 0 ];
			    then
				exit 3;
			    fi;
			    if [ $debug = "--debug" ];	# DEBUG vypis
			    then
				echo "Nova ingredience: $ingredience  id: $idIngredience";
			    fi;
			else
			    #
			    # Ingredience je v databazi
			    #
			    idIngredience=$(echo "$existIng" | tr -d "id \n ");
			    if [ $debug = "--debug" ];	# DEBUG vypis
			    then
				echo "Existujici Ingredience: $ingredience  id: $idIngredience";
			    fi;
			fi;
		    else
			#
			# Pridani poctu ingredienci do Recept_Ingredience
			#
			pocetIng="$x";
			maxReceptIng=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Recept_Ingredience;"); #vrati hodnotu max id
			if [ $? -ne 0 ];
			then
			    exit 3;
			fi;
			idReceptIng=$(echo "$maxReceptIng" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
			let idReceptIng=idReceptIng+1;
			mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Recept_Ingredience(id, potrebaKusu, Receptid, Ingredienceid) VALUES (\"$idReceptIng\",\"$pocetIng\", \"$idRecept\", \"$idIngredience\");"
			if [ $? -ne 0 ];
			then
			    exit 3;
			fi;
			if [ $debug = "--debug" ];	# DEBUG vypis
			then
			    echo "Novy Recept_Ingredience id: $idReceptIng  Pocet ingredienci: $pocetIng Recept id: $idRecept Ingredience id: $idIngredience";
			fi;
		    fi;
		fi;
		let count++;
	    done
	    IFS=$OIFS;
	done


    #
    # Pridani veci do lednice
    #
    elif [ "$p2" = "fridge" ];
    then
	while read lineData
	do
	    if [ "$debug" = "--debug" ];
	    then
		echo "------------------------------------------------------";
		echo "Zadany radek: $lineData";
	    fi;
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
	    if [ $? -ne 0 ];
	    then
		exit 3;
	    fi;
	    if [ "$existProdejna" = "" ];
	    then
	    #
	    # Pridam prodejnu do databaze
	    #
		maxProdejna=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Prodejna;"); #vrati nejvyssi id
		if [ $? -ne 0 ];
		then
		    exit 3;
		fi;
		idProdejna=$(echo "$maxProdejna" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
		let idProdejna=idProdejna+1;
		mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Prodejna(misto_nakupu, id) VALUES (\"$prodejna\", \"$idProdejna\");";
		if [ $? -ne 0 ];
		then
		    exit 3;
		fi;
		if [ "$debug" = "--debug" ];
		then
		    echo "Nova prodejna: $prodejna id: $idProdejna";
		fi;
	    else
	    #
	    # Najdu prodejnu v databazi
	    #
		idProdejna=$(echo "$existProdejna" | tr -d "id \n ");
		if [ "$debug" = "--debug" ];
		then
		    echo "Existujici prodejna: $prodejna id: $idProdejna";
		fi;
	    fi;
	    
	    #
	    # Kontrola zda existuje Ingedience
	    #
	    existIng=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT id FROM Ingredience WHERE nazev_ingredience = '$surovina';");
	    if [ $? -ne 0 ];
		then
		    exit 3;
		fi;
	    if [ "$existIng" = "" ];
	    then
	    #
	    # Pridam Ingredienci do databaze
	    #
		maxIng=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Ingredience;"); #vrati nejvyssi id
		if [ $? -ne 0 ];
		then
		    exit 3;
		fi;
		idIng=$(echo "$maxIng" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
		let idIng=idIng+1;
		mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Ingredience(id, nazev_ingredience) VALUES (\"$idIng\", \"$surovina\");";
		if [ $? -ne 0 ];
		then
		    exit 3;
		fi;
		if [ "$debug" = "--debug" ];
		then
		    echo "Nova ingredience: $surovina id: $idIng";
		fi;
	    else
	    #
	    # Najdu Ingredienci v databazi
	    #
		idIng=$(echo "$existIng" | tr -d "id \n ");
		if [ "$debug" = "--debug" ];
		then
		    echo "Existujici ingredience: $surovina id: $idIng";
		fi;
	    fi;
	    
	    
	    #
	    # Pridani suroviny
	    #
	    maxSurovina=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Surovina;"); #vrati hodnotu max id
	    if [ $? -ne 0 ];
	    then
	        exit 3;
	    fi;
	    idSurovina=$(echo "$maxSurovina" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
	    let idSurovina=idSurovina+1;
	    mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Surovina(id, kusuVLednici, trvanlivost, Ingredienceid) VALUES (\"$idSurovina\",\"$pocetIng\", \"$datum\", \"$idIng\");"
	    if [ $? -ne 0 ];
	    then
		exit 3;
	    fi;
	    if [ "$debug" = "--debug" ];
	    then
		echo "Nova surovina id: $isSurovina Kusu v lednici: $pocetIng Trvanlivost: $datum idIngredience: $idIng";
	    fi;
	    #
	    # Pridani Surovina_Prodejna
	    #
	    maxSurovinaProdejna=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT MAX(id) FROM Surovina_Prodejna;"); #vrati hodnotu max id
	    if [ $? -ne 0 ];
	    then
	        exit 3;
	    fi;
	    idSurovinaProdejna=$(echo "$maxSurovinaProdejna" | tr -d "MAX(id) \n ");  #vyreze hodnotu max id
	    let idSurovinaProdejna=idSurovinaProdejna+1;
	    mysql -D "$db" -u "$user" -p"$pass" -e "INSERT INTO Surovina_Prodejna(id, Surovinaid, Prodejnaid) VALUES (\"$idSurovinaProdejna\",\"$idSurovina\", \"$idProdejna\");"
	    if [ $? -ne 0 ];
	    then
	        exit 3;
	    fi;
	    if [ "$debug" = "--debug" ];
	    then
		echo "Nova Surovina_Prodejna id: $isSurovinaProdejna idSurovina: $idSurovina idProdejna: $idProdejna ";
	    fi;


	    IFS=$OIFS;
	done
    else
	exit 1;
    fi;



#
# Parametry query
#
elif [ "$p1" = "--query" ];
then
    if [ "$p2" = "recipes" ];
    then
	jmeno="$p3";
	a=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT Autor.autor_jmeno, Recept.jmeno_pokrmu FROM Autor, Recept WHERE Autorid = Autor.id AND autor_jmeno = '$jmeno'";);
	if [ $? -ne 0 ];
	then
	    exit 3;
	fi;
	if [ "$a" = "" ];
	then
	    exit 2;
	else
	    echo "$a";
	fi;
    elif [ "$p2" = "shortest" ];
    then
	datum="$p3";
	b=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT result.jmeno_pokrmu as 'Jmeno pokrmu' FROM ( SELECT jmeno_pokrmu, count(jmeno_pokrmu) AS pocetSurovin FROM Recept, Recept_Ingredience, Ingredience, Surovina WHERE Recept_Ingredience.Ingredienceid = Ingredience.id AND Recept.id = Receptid AND Ingredience.id = Surovina.Ingredienceid AND trvanlivost <= '$datum' group by jmeno_pokrmu order by jmeno_pokrmu asc) AS result order by pocetSurovin desc limit 1";);
        if [ $? -ne 0 ];
	then
	    exit 3;
	fi;
        if [ "$b" = "" ];
        then
	    exit 2;
	else
	    echo "$b";
        fi;
    elif [ "$p2" = "buy" ];
    then
	recept="$p3";
	c=$(mysql -D "$db" -u "$user" -p"$pass" -e "select nazev_ingredience as 'Nazev', (potrebaKusu - sum(kusuVLednici)) as 'Dokoupit' from Recept, Recept_Ingredience, Ingredience, Surovina where jmeno_pokrmu = '$recept' and Recept.id = Recept_Ingredience.Receptid and Recept_Ingredience.Ingredienceid = Ingredience.id and Surovina.Ingredienceid = Ingredience.id group by nazev_ingredience having Dokoupit > 0";);
	if [ $? -ne 0 ];
	then
	    exit 3;
	fi;
	if [ "$c" = "" ];
	then
		exit 2;
	else
		echo "$c"
	fi;
    else
	exit 1;
    fi;


elif [ "$p1" = "--variant" ];
then
    echo "2";
else
    exit 1;
fi;

