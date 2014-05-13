cookbook
========

A3B33OSD: Semestrální práce D - požadavky
========

Databáze a SQL - implementace databázové aplikace v bash

UPOZORNĚNÍ: Zadání úlohy D bude v průběhu semestru upraveno !!!

Tuto úlohu můžete řešit jednotlivě nebo ve dvojicích (dvojice je nutné vytvořit při výběru varianty zadání).

Vyberete si jednu z následujících variant a rezervujte si úlohu v odevzdávacím systému.

Vaším úkolem je navrhnout a vytvořit databázi uchovávající požadovaná data. Nakreslete dva E-R diagramy:

    diagram v Chenově notaci bez atributů (pouze entity a relace) a
    diagram v Crow's Foot notaci (s rozkreslenými relacemi, vč. atributů).

Napište sql skript, který vytvoří prázdnou databázi (tzn. v existující prázdné databázi vytvořte prázdné tabulky. Tento skript tedy bude obsahovat jen příkazy CREATE TABLE, příp. DROP TABLE). Implementujte bash skript umožňující:

    naplnit databázi daty z textových souborů (formát je předepsán v zadání jednotlivých variant)
    parametr: --insert ...
    odpovědět na požadované dotazy (podle varianty zadání).
    parametr: --query ... 

Při řešení respektujte následující společné požadavky platící pro všechny varianty zadání:

    Pro svou úlohu si připravte dostatečně objemná testovací data (alespoň 10 záznamů na nejobsáhlejší tabulku nebo více, nezapomeňte postihnout všechny speciální případy).
    Dodržujte 3. normální formu. (to mj. znamená nutnost zavést umělé klíče pro realizaci relací mezi tabulkami)
    Dotazovací části úlohy (kde máte zjistit nějaké informace z databáze) řešte jediným SQL dotazem pro každý bod zadání.
    Využívejte efektivně funkcionalit, které vám databáze nabízí. (např. výpočty)
    Formát vstupních souborů musí být dodržen. Jedná se vždy o hodnoty oddělené čárkou, před a za čárkou může být libovolný počet mezer. Předpokládejte, že žádný řetězec nebude obsahovat znak čárky.
    Skript pro plnění databáze bude číst soubory přes standardní vstup! (tedy např. databaze_objednavek.sh --insert orders < objednavky.txt) To umožní použít skript i pro "ruční" vkládání dat.
    Databáze musí uchovávat všechna data z předepsaných souborů. Další atributy přidávejte dle vlastního uvážení s ohledem na možné využití aplikace.
    Nekonzistence ve vstupních souborech nepředpokládejte (resp. řešte je dle vlastního uvážení).
    Datum ve vstupním souboru má formát YYYY-MM-DD.
    Název databáze, uživatelské jméno a heslo načítejte z proměnných prostředí OSD_DB, OSD_USERNAME a OSD_PASSWORD.
    V každém skriptu vyplňte hlavičku obsahující účel skriptu, jména a e-maily autorů a aktuální semestr.
    Dodržujte požadované parametry vašich skriptů (možnost automatické kontroly).
    Společné parametry: --insert --query --variant (výpis čísla varinaty zadání na stdout) a --debug (více ladících výpisů)
    Připravte si testovací skript, který ověří správnou funkci vašeho skriptu. V rámci tohoto skriptu zinicializujte tabulky, naplňte je daty a proveďte sadu dotazů (alespoň 10) se známým výsledkem a porovnejte skutečný výsledek s očekávaným.
    Dobře zvažte co vypisovat na stdout a stderr a co pouze při parametru --debug.
    Vracejte následující návratové hodnoty:
    0 - vše v pořádku
    1 - špatné parametry
    2 - prázdná odpověď z SQL serveru (popř. jiné neočekávané chování)
    3 - chyba připojení k databázi / k serveru
    10 a více - další vámi definované chybové stavy 

Pro vypracování úlohy byste měli dále dodržovat stejné obecné zásady jako platí pro úlohy bash (B).
Nedodržení požadavků může vést k bodové penalizaci nebo odmítnutí úlohy podle uvážení cvičícího.

V případě jakýchkoliv nejasností v zadání se včas poraďte s vaším cvičícím. Včas řešte i případné problémy při implementaci úlohy. 

Kuchařka
========

Navrhněte databázi kuchařských receptů. Každý recept se skládá z definovaného množství několika surovin. Udržujte také informaci o aktuálním stavu surovin v lednici a jejich trvanlivosti a místu nákupu.

Recepty se vkládají s parametrem --insert recipes a suroviny v lednici --insert fridge.
Formát vstupu pro zadávání receptů: jméno_pokrmu, autor_receptu, surovina1, množství1, surovina2, množství2, ..... Formát vstupu pro zadávání surovin v lednici: surovina, množství, datum trvanlivosti, místo nákupu

Vytvořte bash skript, který najde v databázi:

    recepty daného autora
    (parametr --query recipes <autor>)
    recept který spotřebuje nejvíc surovin s trvanlivostí do zadaného data (včetně). V případě shody počtu surovin u více receptů vytiskněte ten z nich abecedně první.
    (parametr --query shortest <datum>)
    co musím dokoupit na daný recept. Vypište názvy surovin spolu s množstvím k dokoupení
    (parametr --query buy <recept>) 

poznámka: jméno pokrmu, surovin i prodejen mohou obsahovat mezery.
Jedna surovina může být prodávána ve více prodejnách a prodejna může prodávat více surovin. Datum ve vstupních souborech má formát YYYY-MM-DD. Jméno autora se skládá ze jména a příjmení. 
