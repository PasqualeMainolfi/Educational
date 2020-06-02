'''

TDA PILA

tipo di dato astratto ---> una collezione, struttura dati che contiene elementi multipli
un TDA e' definito dalle operazioni che possono essere effettuate su di esso ---> interfaccia


__init__ ---> inizializza pila vuota

aggiungi ---> aggiunge elemento alla pila

rimuovi ---> rimuove e ritorna un elemento dalla pila. L'elemento tornato e' sempre l'ultimo inserito

controlla ---> controlla se la pila e' vuota

'''

class Pila:
    def __init__(self):
        self.lista = []

    def aggiungi(self, elemento):
        self.lista.append(elemento)

    def rimuovi(self):
        return(self.lista.pop())

    def controlla(self):
        return(self.lista == [])


dati = Pila()
dati.aggiungi(36)
dati.aggiungi(5)
dati.aggiungi(74)
dati.aggiungi("cane")
dati.aggiungi("gatto")
dati.aggiungi("lupo")

while not dati.controlla():
    print(dati.rimuovi()) #cio' che fa e' rimuovere gli elementi della lista a partire dall'ultimo aggiunto... ritornera' proprio questo
    if(dati.controlla()): #quando la condizione e' vera...
        print("ora la lista e' vuota!")
