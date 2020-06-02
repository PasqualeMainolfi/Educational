'''

PRINCIPALI METODI DI CLASSE ED EREDITARIETA'

__str__, __add__, __mul__, __sub__, __bool__

'''

#__str__ ---> ritorna una rappresentazione dell'oggetto
#__add__ ---> addizione tra due oggetti. Ci consente di usare l'operatore +
#__mul__ ---> moltiplicazione tra due oggetti. Ci consente di usare l'operatore *
#__sub__ ---> sottrazione tra due oggetti. Ci consente di usare l'operatore -
#__bool__---> restituisce vero o falso in base alle nostre indicazioni

#ovviamente... nulla ci vieta di scrivere un nostro metodo con la funzione sopra

class Punto:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __str__(self):
        rappresentazione = f"punto x = {self.x} \tpunto y = {self.y}"
        return(rappresentazione)

    def __add__(self, other):
        try: #l'aggiunta di try/except fa si che se sommiamo con un oggetto... allora try
            return(self.x + other.x, self.y + other.y)
        except: #altrimenti... sommiamo con un valore che non e' un oggetto
            return(self.x + other, self.y + other)

    def __mul__(self, other):
        return(self.x * other.x, self.y * other.y)

    def __sub__(self, other):
        return(self.x - other.x, self.y - other.y)


p1 = Punto(3.1, 5.0)
p2 = Punto(5.0, 4.3)
print(p1, "\taddizione: ", p1 + p2, "addizione senza oggetto: ", p1 + 3, "\tmoltiplicazione: ", p1 * p2, "\tsottrazione: ", p1 - p2)


#definiamo ancora una classe... una lista spesa ad esempio
class ListaSpesa:
    def __init__(self):
        self.lista = [] #una lista vuota per ora

    def aggiungi(self, a):
        self.lista.append(a)

    def __bool__(self):
        return(True if len(self.lista) != 0 else False) #operatore ternario se la lista non e' vuota ritorna vero, caso contrario ritorna falso

    def __len__(self):
        return(len(self.lista))

    def stampaLista(self):
        print(self.lista)


listaOggi = ListaSpesa()
listaOggi.aggiungi("latte")
listaOggi.stampaLista()
print(bool(ListaSpesa), len(listaOggi))

#ereditarieta'
#supponiamo di avere una classe che ci permette di gnerare una scheda studente
class Studente:
    def __init__(self, nome, cognome, anni):
        self.nome = nome
        self.cognome = cognome
        self.anni = anni

    def stmp(self): #metodo per stampare a vista
        print(f"\n\nNome: {self.nome}\nCognome: {self.cognome}\nAnni: {self.anni}\n")

#se volessimo creare una nuova classe, ad esempio Professore, ci basterebbe ereditare la classe studente ---> la classe Studente in questo caso si dice classe madre, Professore classe figlio
class Professore(Studente): #eredita tutto da Studente
    pass

studente = Studente("Carlo", "Romano", 18).stmp()
professore = Professore("Mario", "Rossi", 57).stmp()
