'''
STRINGHE, CICLI FOR E VARIABILI LOCALI E GLOBALI
'''

import string

#una stringa e' un tipo di dato composto da altri dati, i caratteri

nomeCane = "Rambo" #dato composto da singoli caratteri

'''
indice --->  0   1   2   3   4 ---> posizione occupata (la numerazione comincia da 0!!!)
stringa ---> R   a   m   b   o ---> dato alla n-posizione
'''

letteraInStringa = nomeCane[1] #l'operatore [] ci permette di selezione il singolo carattere nella stringa scrivendo l'indice di posizione del carattere che ci interessa
lunghezzaStringa = len(nomeCane) #la funzione len() ritorna la lunghezza della stringa inserita
#print(nomeCane, "\t", letteraInStringa, "\t", lunghezzaStringa)

#ciclo for ---> usare un indice per attraversare un insieme di valori. La sintassi e': for n in []
for lettera in nomeCane: #lettera assume il valore del carattere successivo nella stringa nomeCane ---> attraversiamo la stringa
    print(lettera)

sufx = "ane"
prefx = "ABCDFGHZ"
for c in prefx:
    nuova = c + sufx
    print(nuova)


#porzione di stringa ---> [n:m] ---> l'operatore ritorna una porzione di valori a partire dalla posizione n fino alla posizione m - 1
stringaIniziale = "Ciao come va?"
porzione1 = stringaIniziale[0:4] #in questo modo avremo solo i caratteri dalla posizione 0 fino alla 4, ovvero solo la parola Ciao
porzione2 = stringaIniziale[:4] #caratteri dall'indice 0 fino ad m - 1
porzione3 = stringaIniziale[4:] #caratteri dalla posizione 4 fino alla fine
print(porzione1, porzione2, porzione3)

#N.B. le stringhe sono immutabili! non e' possibile usare l'operatore [] per cambiare un carattere.

#scriviamo una funzione che cerca un carattere dentro una stringa e ritorna l'indice di posizione
def cercaCarattere(stringa, carattere):
    index = 0 #puntatore
    while(index < len(stringa)): #fino a che index e' inferiore alla lunghezza della stringa
        if(stringa[index] == carattere):
            return index #blocca l'esecuzione quando hai trovato il carattere
        index += 1
    return -1 #se il carattere non esiste ritorna -1

car = "i"
st = "supercalifragilistichespiralitoso"
cerca = cercaCarattere(st, car)
print("il carattere che stai cercando %s, si trova alla posizione %d" %(car, cerca))

#scriviamo una funzione che conta quante volte un carattere e' presente nella stringa
def contaCarattere(stringa, carattere):
    conta = 0
    for n in stringa:
        if(n == carattere): #ogni volta che la condizione e' vera conta incrementa di +1
            conta += 1
    return conta

conta = contaCarattere(st, car)
print("il carattere %s e' presente un numero di volte pari a = %d" %(car, conta))

#modulo string (import string) ---> modulo per lavorare sulle stringhe
#...qualche metodo del modulo string

parolaMaiuscolo = "CANE"
parolaMinuscolo = "cane"

parola1 = parolaMaiuscolo.lower() #trasforma in minuscolo
parola2 = parolaMinuscolo.upper() #trasforma in maiuscolo
parola3 = parolaMinuscolo.isdigit() #rileva se una stringa e' composta da soli numeri
#trova = parolaMaiuscolo.find(parolaMaiuscolo, "A") #cerca dentro una stringa


#cicli per contare e sommare, trovare i massimi e i minimi
listaElementi = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

#contiamo gli elementi
count = 0 #inizializzazione contatore
for e in listaElementi:
    count += 1
print("Count = ", count)

#sommiamo gli elementi
sum = 0
for s in listaElementi:
    sum += s
print("Somma = ", sum)

#troviamo il valore piu' grande
maxValue = None

for x in listaElementi:
    if(maxValue is None or x > maxValue): #se la variabile maxValue e' uguale a None o l'elemento x e' maggiore di maxValue
        maxValue = x #allora ridefinisci il valore di confronto con l'elemento
    print("sto cercando...", x, maxValue)
print("il valore piu' grande in lista e' = ", maxValue)

#troviamo il valore piu' piccolo
minValue = None

for c in listaElementi:
    if(minValue is None or c < minValue): #se la variabile maxValue e' uguale a None o l'elemento x e' maggiore di maxValue
        minValue = c #allora ridefinisci il valore di confronto con l'elemento
    print("sto cercando...", c, minValue)
print("il valore piu' piccolo in lista e' = ", minValue)

#le funzioni integrate di Python per la ricerca del minimo o massimo sono min() e max()
print(min(listaElementi), max(listaElementi))


##################################
##################################
##################################

#variabili locali e globali
#scriviamo una piccola funzione che conta quante a ci sono in una stringa

def conta_a(stringa):
    count = 0 #variabile locale
    for i in stringa:
        if(i == "a" or i == "A"):
            count += 1
    return(count)

stringa = "aaAcvbsgbncAAdhbvfhaanfnaAAAAmjvnruqnvpqgrnqanvfjbfa"
aCount = conta_a(stringa)
print("ci sono", aCount, "a")

#e se provassimo a stampare direttamente count? ci direbbe cha la variabile non e' definita, perche' count e' una variabile locale
#per evitare l'errore dovremmo creare una variabile globale

countGlobal = 0
def conta_a(stringa):
    global countGlobal #variabile globale
    for i in stringa:
        if(i == "a" or i == "A"):
            countGlobal += 1

conta_a(stringa) #eseguiamo la funzione
print(countGlobal) #stampiamo la variabile globale
