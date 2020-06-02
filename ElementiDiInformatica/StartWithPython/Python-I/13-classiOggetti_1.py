'''

CLASSI E OGGETTI

---> una classe e' un tipo composto. La sua sintassi e':

class Nome:
    pass

N = Nome() #assegniamo il riferimento ad un nuovo oggetto Nome. La funzione Nome e' detta costruttore

---> un oggetto o istanza e' un membro di una classe. Si creano mediante istanziazione.

'''

class Punto:
    pass #signica che non passa nulla, creiamo solo la classe Punto


#classi e attributi
P1 = Punto()
P1.x = 3.0 #.x e' detto attributo ---> con la notazione punto identifichiamo la variabile a cui ci si riferisce
P1.y = 4.0

print(P1, P1.x, P1.y)

#la classe Punto ha due attributi, la coordinata x e y

class Rettangolo:
    pass

Rett = Rettangolo()
Rett.h = 100.0 #alla classe retangolo aggiungiamo due attributi, altezza h e base ---> nuovo oggetto con due attributi
Rett.b = 200.0

Rett.posizione = Punto() #in questo modo insieriamo un oggetto all'interno di un altro oggetto
Rett.posizione.x = 0.0 #letteralmente ---> vai all'oggetto a cui si riferisce rett e seleziona l'attributo posizione... a questo punto vai all'oggetto a cui si riferisce posizione
Rett.posizione.y = 0.0

#classi e funzioni
#supponiamo di voler scrivere una funzione che trova il centro di un ipotetico quadrato
def centro(Quadrato):
    Coordinate = Punto()
    Coordinate.x = Quadrato.pos.x + Quadrato.lato/2.0
    Coordinate.y = Quadrato.pos.y + Quadrato.lato/2.0
    return Coordinate

class Quadrato:
    pass

Square = Quadrato() #definiamo l'oggetto quadrato
Square.pos = Punto() #definiamo l'oggetto pos dell'oggetto square

Square.lato = 200 #float(input("immetti lato: ")) #importante definire il tipo di dato da immettere
Square.pos.x = 0.0 #posizione nel piano x
Square.pos.y = 0.0 #posizione nel piano y

PuntoCentrale = centro(Square)
print("x = ", PuntoCentrale.x, "|",  "y = ", PuntoCentrale.y)

#classi e metodi
class Tempo:
    def printTime(Orario): #questo e' un metodo che possiamo invocare con la notazione punto
        print("sono le: %d:%d:%d" %(Orario.ore, Orario.min, Orario.sec))


Ora = Tempo()
Ora.ore = 13
Ora.min = 25
Ora.sec = 59

Ora.printTime() #invochiamo il metodo printTime sull'oggetto Ora


#metodo di inizializzazione __init__
class Triangolo:
    def __init__(self, base=0, altezza=0): #inizializzazione ---> costruttore ---> ponendo gli argomenti con =0 significa che sono opzionali 
        self.base = base
        self.altezza = altezza

    def area(self): #metodo ---> calcolo dell'area
        return(self.base * self.altezza)/2

#quando invochiamo il costruttore Triangolo, gli argomenti che indichiamo passano direttamente alla funzione __init__
triangolo1 = Triangolo(50, 20)
print(triangolo1.area())

#riscriviamo allora anche la classe Tempo... la chiamiamo Time
class Time:
    def __init__(self, ore=0, min=0, sec=0):
        self.ore = ore
        self.min = min
        self.sec = sec

    def showTime(self):
        stampa = "sono le: ---> " + str(self.ore) + ":" + str(self.min) + ":" + str(self.sec)
        print(stampa)


OraOra = Time(16, 25, 59)
OraOra.showTime() #metodo visualizza ora
