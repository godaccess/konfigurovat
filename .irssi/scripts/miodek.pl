# Miodek 1.0.2
#
# Lam 10-11.9.2001 + p�niejsze zmiany s�ownika (g��wnie YagoDa)
#
# Pewnie ten skrypt jest napisany �le, co prawdopodobnie wynika z faktu, �e
# to w og�le m�j pierwszy skrypt w perlu, ale c�, na pewno ludzie, kt�rych
# ten skrypt kopie s� g�upsi od niego :)
#
# S�ownik jest wynikiem nocnego przegl�dania log�w z irca (g��wnie
# grepowania po "sh" oraz "kunia") i powi�ksza si� podczas ka�dej rozmowy :)
#
# 10:32 <aska|off> hm... to u was za kopiom???????
# 10:32 <aska|off> ehhee za kcenie??????
#
# Miodek 2.0 z obs�ug� regex�w i s�ownik�w w plikach by� w
# przygotowaniu, ale po padzie dysku straci�em ochot� odzyskiwania go.
# Na jaki� czas.

use Irssi;
use strict;
use vars qw($VERSION %IRSSI);
$VERSION = "1.0.2";
%IRSSI = (
	authors => "Leszek Matok, Andrzej Jagodzi�ski",
	contact => "lam\@lac.pl",
	name => "miodek",
	description => "Simple wordkick system, with extended polish dictionary for channels enforcing correct polish.",
	license => "GPLv2",
	changed => "10.3.2002 20:10"
);


my $miodek = '
# moje w�asne dopiski :> (by yagus)

szypko          szybko
wogule          w ogole
qrva            panna lekkich obyczajow
drobiask        drobiazg
ogladash        ogl�dasz
przeciesh       przecie�
zeszycikof      zeszyt�w
widzish         widzisz
JESOOO          Jezu
jesooooooo      Jezu
jesoooooooo     Jezu
jesooooooooo    Jezu
jesoooooooooo   Jezu
jesooooooooooo  Jezu
jesoooooooooooo Jezu
zgadzash        zgadzasz
jesooo          Jezu
jesoooo         Jezu
jesooooo        Jezu
jesoooooo       Jezu
zobaczysh       zobaczysz
pokonash        pokonasz
nawidzish       nawidzisz
myslish         my�lisz
komplexof       kompleks�w
chujq           cz�onku
moofi           m�wi
umiesh          umiesz
lubish          lubisz
tilaf           T.Love
wjesz           wiesz
priff           priv
prif            priv
lukof           �uk�w
lukoof          �uk�w
kad             sk�d
k�d             sk�d
wlosoof         w�os�w
wlosof          w�os�w
dobzie          dobrze
fog�le          w og�le 
fogole          w og�le
wog�le          w og�le
wogole          w og�le
pishesz         piszesz
pishesh         piszesz
mooofish        m�wisz
uwazash         uwa�asz
slyshysh        s�yszysz
zaparofaly      zaparowa�y
wyprafiash      wyprawiasz
wyprafiasz      wyprawiasz
znof            zn�w
idziesh         idziesz
grash           grasz
moofi�          m�wi�
moofil          m�wi�
qlfa            kurwa
dopsie          dobrze
schodof         schod�w
pierdolic       kocha�
pierdoli�       kocha�
jeba�           uprawia� mi�o��
jebac           uprawia� mi�o��
pierdolec       kochanek
psyjechac       przyjecha�
kces            chcesz
przyjebal       pokocha�
przyjeba�       pokocha�
ujebal          pokocha� 
zajebal         zakocha�
ujeba�          pokocha�
zajeba�         zakocha�
chuja           cz�onka
huja            cz�onka
pierdoli        kocha
odwiezesh       odwieziesz
bedziesh        b�dziesz
mooofiles       m�wi�e�
moofiles        m�wi�e�
mofi            m�wi
dogryzash       dogryzasz
terash          teraz
tfooj           tw�j
dorosniesh      doro�niesz
pofiem          powiem
poffiem         powiem
dopla           dobra
doblam          dobra
# typowe kretynizmy (90% by Lam)
tesh            te�
tesz            te�
tysh            te�
tysz            te�
jush            ju�
jusz            ju�
ush             ju�
mash            masz
cush            c�
coosh           c�
cosh            c�
robish          robisz
jesh            jesz
# qrwa          kurwa
kurfa           kurwa
qrfa            kurwa
kofam           kocham
koffam          kocham
kofany          kochany
koffany         kochany
kofana          kochana
koffana         kochana
moofie          m�wi�
moof            m�w
moofisz         m�wisz
moofish         m�wisz
mofie           m�wi�
mof             m�w
mofisz          m�wisz
mofish          m�wisz
pofiem          powiem
gadash          gadash
wiesh           wiesz
fiesh           wiesz
fiem            wiem
# tego wprost nienawidz�!
KCE             chc�
kce             chc�
kcem            chc�
kcesz           chcesz
kcesh           chcesz
moshe           mo�e
mosze           mo�e
moshna          mo�na
# widzia�em jak jaki� czik o inteligencji ameby pisa� "moszna", ale smaczek ;)
bosh            bo�e
boshe           bo�e
boshesh         bo�e
jesu            Jezu
joosh           ju�
# no tego to ja bym nie wymy�li� :)
fokle           w og�le
psheprasham     przepraszam
# a to s�owo ma tyle wersji.. ci ludzie naprawd� si� nudz�.
dobshe          dobrze
dopshe          dobrze
dopsze          dobrze
dopsz           dobrze
topshe          dobrze
topsze          dobrze
topsz           dobrze
topla           dobra
toplanoc        dobranoc
dopry           dobry
dopra           dobra
# od tego momentu wy��cznie wy�apane na ircu
napish          napisz
palish          palisz
trafke          trawk�
trafka          trawka
slofa           s�owa
pishe           pisze
piszem          pisz�
moozg           m�zg
kref            krew
krfi            krwi
naprafde        naprawd�
zafsze          zawsze
dziendopry      dzie�dobry
snoof           sn�w
kopiom          kopi�
kcenie          chcenie
kc�             chc�
k�rfa           kurwa
k�rwa           kurwa
mooj            m�j
jesoo           Jezu
loodzie         ludzie
loodzi          ludzi
ktoora          kt�ra
ktoory          kt�ry
ktoore          kt�re
gloopi          g�upi
gloopia         g�upia
goopi           g�upi
goopia          g�upia
gupi            g�upi
gupia           g�upia
siem            si�
pshesada        przesada
booziak         buziak
booziaki        buziaki
mogem           mog�
bes             bez
spowrotem       z powrotem
poczeba         potrzeba
niepoczeba      nie potrzeba
czeba           trzeba
glofa           g�owa
glofe           g�ow�
suonce          s�o�ce
fitam           witam
fitaj           witaj
fitajcie        witajcie
slofnik         s�ownik
# usuni�te w wyniku batalii o Jerzego Owsiaka. Prawdopodobnie nied�ugo
# zobaczymy to s�owo w s�owniku. Ciekawe co napisz� pod has�em "siemanie"?
# siema         si� ma
# siemasz       si� masz
cieshysh        cieszysz
tfierdzish      twierdzisz
jezd            jest
brzytkie        brzydkie
brzytki         brzydki
brzytka         brzydka
otfarty         otwarty
otfarte         otwarte
otfarta         otwarta
leprzy          lepszy
leprze          lepsze
leprza          lepsza
lepshy          lepszy
lepshe          lepsze
lepsha          lepsza
zief            ziew
kfila           chwila
kfile           chwil�
kfilka          chwilka
kfilke          chwilk�
bendem          b�d�
lecem           lec�
pifo            piwo
pifko           piwko
pifkiem         piwkiem
bszytkie        brzydkie
bszytki         brzydki
bszytka         brzydka
goofny          g��wny
goofno          g�wno
muoda           m�oda
miaua           mia�a
miauam          mia�am
tszeba          trzeba
wporzo          w porzo
# na pro�b� Upiora troch� bluzg�w + nowe by yagoda
kurwa           dziewica orlea�ska
kurwy           panny
kurwie          pannie
kurewka         panienka
kurwo           panno
qrwa            prostytutka
# eksperymentalne wielkie litery :-)
CHUJ            cz�oneczek
HUJ             cz�oneczek
KURWA           panienka
KURWY           panny
CIPA            pochwa
PIZDA           pochwa
SKURWYSYN       Protas
chuj            cz�onek
chuje           cz�onki
chujowo         cz�onkowsko
chujowy         cz�onkowski
chujowa         cz�onkowska
chujowe         cz�onkowskie
huj             cz�onek
huje            cz�onki
hujowo          cz�onkowsko
hujowy          cz�onkowski
hujowa          cz�onkowska
hujowe          cz�onkowskie
cipa            pochwa
pizda           pochwa
pierdolony      kochany
pierdolona      kochana
pierdolone      kochane
jebany          kochany
jebana          kochana
jebane          kochane
skurwysyn       Protas
skurwysynu      synu prostytutki
skurwiel        Lam
skurwielu       z kur wielu
pierdole        kocham
jebie           kocham
pierdol         kochaj
kutas           penis
cipka           pochewka
';

my %slowa;
my $ilosc_slow = 0;

foreach my $linia (split(/\n/, $miodek)) {
	chomp $linia;
	next if ($linia =~ /^#/ || $linia eq "");

	my ($org, $popraw) = split(/\s+/, $linia, 2);
	$slowa{$org} = $popraw;
	$ilosc_slow++
}

sub server_event {
	my ($server, $data, $nick, $address) = @_;
	my ($type, $data) = split(/ /, $data, 2);
	return unless ($type =~ /privmsg/i);
	my ($target, $tekst) = split(/ :/, $data, 2);
	my $powod;

	# pozbywam si� syf�w kontrolnych, oraz ^A z CTCP
	# mo�e jest jaka� funkcja w irssi do wycinania kolor�w mircowych?
	$tekst =~ s/[]//g;

	foreach my $wyraz (split(/[\s,.;!?\/"`':()_-]/,$tekst)) {
		my $popraw = $slowa{$wyraz};
		if ($popraw) {
			if ($powod) {
				$powod = $powod . ", ";
			}
			$powod = $powod . $popraw;
		}
	}

	if ($powod && $target =~ /^[#!+&]/ ) {
		$server->command("/kick $target $nick $powod");
		Irssi::print "%Rkop%n ($target): %c$nick%n, powod: $powod";
	}
}

# Musia�em si� podczepi� pod server event zamiast event privmsg, bo irssi
# wycina CTCP z PRIVMSG (co jest dla mnie zachowaniem dziwnym).
Irssi::signal_add_last("server event", "server_event");
Irssi::print "%GMiodek%c:%n ilo�� s��w w s�owniku: $ilosc_slow";
