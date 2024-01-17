-- F1  Hány diák tanul az osztályban?
SELECT count(*)
FROM J2;
-- f2 Hány lány tanul az osztályban?
SELECT Count(*)
FROM J2
WHERE nem = 0
;
--F3  Kik az egykék? (Akiknek nincs testvérük?)
SELECT nev
FROM J2
WHERE testver = 0
;
--F4 Hány egyke van?
SELECT count(*)
FROM J2
WHERE testver = 0
;
--F5 Kik tanulnak a kettes angol csoportban? (Csak annyit tehetünk fel, hogy az angolcsoportok neve számmal kezdődik, ez alapján kell megtalálni!)
SELECT *
FROM J2
WHERE ancsop like "2*"
;
--F6 Add meg az olasz második nyelvi csoport tanulóinak névsorát (ábécé-sorrendben!)
select  nev
from j2 
where mnyelv = "olasz"
order by nev
;
--F7 Hány fiú tanul az alfa matematika-informatika csoportban?
SELECT COUNT(*)
FROM j2
WHERE matcsop="alfa" AND nem=-1
;
--F8 Mekkora a legnagyobb család az osztályban? 
SELECT max(együtt)
FROM J2
;

--F9 Adj meg egy diákot, akinek a legtöbb testvére van!
SELECT nev
FROM J2
Where testver = (SELECT max(testver) from j2)
;
--F10 Viszonylag kevés azon családok száma, ahol az együttlakók száma és a testvérek száma között nem három a különbség. Adja meg a számukat!
SELECT COUNT(id) 
FROM J 
WHERE NOT ABS(egyuttlakok - testverek) = 3
;
--F11 Hát Izsák hiányzott a legutóbbi angol órán, szeretné bepótolni a hiányzást. Adja meg azon tanulók nevét, akik vele azonos angol csoportba járnak.
SELECT *
FROM J
where ancsop = (select ancsop from J where nev = "Hát Izsák") and nev <>"Hát Izsák"
;
--F12 Melyik második nyelvet hányan tanulják az osztályban?
SELECT count(mnyelv)
FROM J
GRoUP BY mnyelv
;
--F13 Hány éves a legidősebb és legfiatalabb diák, illetve mennyi köztük a korkülönbség? (Egy lekérdezéssel!)

SELECT Int((Date()-Max(szul))/365) AS Kif1, Int((Date()-Min(szul))/365) AS Kif2, Max(szul)-Min(szul) AS Kif3
FROM J;

--F14 Hány különböző angolcsoport van?
SELECT count(*)
FROM (select distinct ancsop from j)
;
--F15 Melyik a leggyakrabban előforduló testvérszám?
SELECT TOP 1 testver
FROM J
GROUP BY testver
ORDER BY COUNT(*) DESC
--F16 Add meg mindegyik második nyelvi csoportra, hogy az adott csoportban átlagosan hány testvérrel rendelkeznek a tanulók!
SELECT (COUNT(testver))/(COUNT(nev))
FROM J
GROUP BY mnyelv
;
--F17 Add meg angolcsoportonként a névsorban első és utolsó diák nevét!
SELECT ancsop, COUnT(*), max (nev), min(nev)
FROM J
GROUP by ancsop
;
--F18 Add meg, hogy hányan húzták a karácsonyi húzás során önmagukat!
SELECT count(*)
FROM J
WHERE id = huzuttid
;
--F19 Add meg, hogy hány olyan pár van az osztályban, akik egymást húzták!
SELECT J.nev,J3.nev
FROM J,J as J3
WHERE J.id = J3.huzuttid AND J3.id = J.huzuttid AND J.id <> J3.id
;
--F20 Add meg, hogy hány olyan tanulónégyes van az osztályban, akik "körbehúzták" egymást!
SELECT Count(*)
FROM J as egyik ,J as masik, J as harmadik, J as sokadik
Where egyik.id = masik.huzuttid and masik.id = harmadik.huzuttid and harmadik.id = sokadik.huzuttid and sokadik.id = egyik.huzuttid and egyik.id <> harmadik.id
;
--F21 Felmerült, hogy esetleg elrontották (meghamisították?) a karácsonyi húzást. Add meg, hogy hány olyan tanuló van az osztályban, akit többen is húztak!
SELECT Count(*)
FROM J as egyik ,J as masik, J as harmadik
Where egyik.id = masik.huzuttid and egyik.id = harmadik.huzuttid and masik.id <> harmadik.id
;
--F22 Add meg, hogy hány olyan tanuló van az osztályban, akit senki sem húzott!

SELECT count(*)
FROM J 
where not id in (SELECT huzuttid FROM J)
;


















