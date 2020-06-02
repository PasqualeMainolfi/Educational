'''
ITERAZIONE E TABELLE

- ciclo while
- incapsulamento

'''

import math

#iterazione = ripetizione

'''
x = x + 1 ---> comune schema nelle istruzioni di assegnazione: il nuovo valore dipende da quello vecchio ---> letteralmente, prendi il vecchio valore e aggiungi 1

x = 0 #inizializzazione della variabile
x = x + 1 #incremento
'''


#conto alla rovescia con il ciclo while
def contoAllaRovescia(n):
    while(n >= 0): #letteralmente: fino a che n e' maggiore o uguale a zero esegui cio' che segue
        print(n)
        n -= 1

    print("fine del conto alla rovescia!") #stampa quando la condizione e' falsa

#ancora un esempio... stampiamo la sequenza di Collatz
def seqCollatz(n):
    while(n != 1): #fino a che n e' diverso da 1 stampa n
        print(n)
        if((n%2) == 0): #controlla se n e' pari ---> se pari allora dividi per 2
            n /= 2
        else:
            n = n * 3 + 1 #se non e' pari, moltiplica n per 3 e aggiungi 1


#tabelle monodimensionali
# p = 1.0 #contatore, indice del ciclo
# maxCicli = 10
# while(p < maxCicli):
#     l = math.log2(p)
#     print(p, "\t", l) #la stringa "\t" rappresenta e' un carattere di tabulazione, il backslash "\" indica l'inizio di una sequenza di escape; la p sara' il nostro puntatore
#     p += 1


#break e continue
#iterazioni infinite e istruzione break
#supponiamo di voler ricevere dati in ingresso per un tempo indefinito, fino a quando si digita la parola stop
while(True): #la condizione del ciclo e' True ---> genera una iterazione infinita
    ins = input("esempio istruzione break: > ")
    if(ins == "stop"):
        break #l'istruzione break blocca esce ci permette di bloccare il processo iterativo
    print(ins)
print("HAI FERMATO IL PROCESSO!")

#ferma le iterazioni con l'istruzione continue
while(True):
    ins = input("esempio istruzione continue: > ")
    if(ins == "#"):
        continue #salta alla successiva iterazione senza terminare il corpo per l'iterazione corrente
    if(ins == "stop"):
        break
    print(ins)
print("HAI FERMATO IL PROCESSO")



#tabelle bidimensionali ed incapsulamento
n = 1
while(n < 6):
    val = n * 2
    print(val, '\t', end = "") #ci permette di stampare su di una riga singola l'intero ciclo
    n += 1
print("\n")

#incapsulamento
def moltTab(valore, grandezza):
    i = 1
    while(i < grandezza):
        val = valore * i
        print(val, "\t", end = "")
        i += 1
    print()

size = 7
i = 1
while(i <= size):
    moltTab(i, size)
    i += 1
