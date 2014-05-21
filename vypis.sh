#!/bin/bash

pass="contain";
db="jakesjan";
user="jakesjan";

if [ "$OSD_DB" != "" ]; then
	db="$OSD_DB";
	user="$OSD_USERNAME";
	pass="$OSD_PASSWORD";
fi


autor=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT * FROM Autor;");
recept=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT * FROM Recept;");
receptI=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT * FROM Recept_Ingredience;");
ingredience=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT * FROM Ingredience;");
prodejna=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT * FROM Prodejna;");
surovinaP=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT * FROM Surovina_Prodejna;");
surovina=$(mysql -D "$db" -u "$user" -p"$pass" -e "SELECT * FROM Surovina;");


if [ "$1" = "-r" ];
then
echo "$autor";
echo "------------------------------";
echo "$recept";
echo "------------------------------";
echo "$receptI";
echo "------------------------------";
echo "$ingredience";
echo "------------------------------";

elif [ "$1" = "-f" ];
then
echo "$prodejna";
echo "------------------------------";
echo "$surovinaP";
echo "------------------------------";
echo "$surovina";
echo "------------------------------";
echo "$ingredience";
echo "------------------------------";
 
fi;
