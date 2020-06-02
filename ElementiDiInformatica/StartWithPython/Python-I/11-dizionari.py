'''

DIZIONARI

Simili agli altri tipi di dati composti (stringhe, liste e tuple). A differenza di questi ultimi che usano interi per indice, i dizionari usano qualsiasi tipo di dato immutabile come indice.
Un indice in un dizionario si chiama "chiave", un elemento "coppia chiave-valore"; un dizionario si definisce con l'operatore {}

'''

dizInglese = {} #genera un dizionario vuoto
dizInglese["one"] = "uno" #associamo alla parola inglese "one", la traduzione italiana uno
dizInglese["two"] = "due"

print(dizInglese)

#operazioni sui dizionari
magazzino = {"chiodi" : 500, "rondelle" : 1000, "dadi" : 2500}
print(magazzino)

#funzione del ---> rimuove coppia chiave-valore dal dizionario
del magazzino["chiodi"] #rimuove chiave e valore associato
print(magazzino)

#possiamo cambiare il valore associato ad una chiave, semplicemente riassegnando
magazzino["rondelle"] = 1200
print(magazzino)

#funzione del ---> ritorna il numero di coppie presente nel dizionario
print(len(magazzino))


#metodi dei dizionari: un metodo e' simile ad una funzione, cambia il modo di chiamata ---> si usa la notazione punto ---> si specifica la funzione e il nome dell'oggetto a cui applicare la funzione
#metodo keys ---> ritorna la lista delle sue chiavi
a = magazzino.keys()
print(a)
#metodo values ---> ritorna la lista dei valori
b = magazzino.values()
print(b)
#metodo items ---> ritorna chiavi e valori in una lista di tuple, una per ogni coppia
c = magazzino.items()
print(c)
#metodo has_key ---> accetta una chiave e ci dice se questa e' presente o meno nel dizionario 1 vero, 0 falso
d = magazzino.has_key("dadi")
e = magazzino.has_key("trapano")
print(d, e)

#alias e copia
nomiAnimali = {"cane" : "Rambo", "gatto" : "Lilli", "cavallo" : "Furia"}
alias = nomiAnimali #alias
copia = nomiAnimali.copy() #copia

#se cambiamo un valore in alias, cambia anche nel dizionario...
alias["gatto"] = "Deby" #cambiamo il valore in alias
print(nomiAnimali["gatto"]) #cambiera' anche il valore in nomiAnimali

#se cambiamo un valore usando la sua copia, nomiAnimali restera' immutato
copia["gatto"] = "Susan"
print(nomiAnimali["gatto"])


#suggerimenti ---> valore memorizzato per un suo uso successivo
#riscriviamo la sequenza di Fibonacci usando proprio dei suggerimenti, in modo da abbattere il tempo di calcolo del valore successivo

prec = {0:1, 1:0} #definiamo un dizionario in cui associamo alla chiave 0 il valore 1 e alla chiave 1 il valore 1... i primi due numeri in sequenza di Fibonacci

def fibSuggerita(n):
    if(prec.has_key(n)): #controlliamo se la chiave esiste
        return(prec[n]) #se esiste ritorna il valore associato
    else: #se non esiste...
        nextValue = fibSuggerita(n - 1) + fibSuggerita(n - 2) #calcola il nuovo valore
        prec[n] = nextValue #ed inseriscilo nel dizionario
        #print(prec)
        return(nextValue) #ritorna il valore calcolato

fib = fibSuggerita(10)
print(fib)

#un possibile problema puo' venire fuori quando si usano numeri interi troppo grandi OVERFLOW PROBLEM ---> la soluzione e' usare il tipo long int ---> permette di usare interi di qualsiasi grandezza
long(1) #---> long intero ---> in python 3 tutti gli interi sono illimitati

fibErr = fibSuggerita(100)

#per risolvere il problema possiamo semplicemente definire i valori in tipo long ---> in python 3 tutti gli interi sono illimitati
prec = {0:1L, 1:0L}
fibCorr = fibSuggerita(100) #in python 3 lo fa automaticamente

print(fibErr, fibCorr)



###############################
###############################
###############################

#proviamo a scrive una funzione che produca un istogramma di una stringa che mostra la frequenza con cui una lettera appare
stringa = "supercalifragilistichespiralitoso"

lettereInStringa = {}
for lettera in stringa:
    lettereInStringa[lettera] = lettereInStringa.get(lettera, 0) + 1  #il metodo get() ritorna il valore associato ad una chiave se questa esiste, nel nostro caso ritorna 0 se la lettera non esiste

print(lettereInStringa)

#istogramma in ordine alfabetico
lettereInStringa = lettereInStringa.items()
lettereInStringa.sort() #...in ordine alfabetico
print(lettereInStringa)
