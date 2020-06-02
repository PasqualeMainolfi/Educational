'''

- scrivere una funzione istogramma che prende una lista di valori ed un numero totale di intervalli da considerare e ritorna l'istogramma della distribuzione dei valori per ciascun intervallo

a. lista di lunghezza L = 1000 di numeri a virgola mobile generati casualmente in un range 0.0 - 1.0;
b. N = 10 intervalli.

'''

import random


#SOLUZIONE

#step 1: definiamo una lista di lunghezza L = 1000
L = 1000
lista = L * [0]

#step 2: riempiamo la lista con valori casuali... usiamo il modulo random
for i in range(L):
    lista[i] = random.random()

#step 3: definiamo una funzione che ci possa dire in che intervallo cade un certo valore della lista
def intervallo(lista, minimo, massimo):
    count = 0
    for val in lista:
        if(minimo < val < massimo): #se il valore e' compreso tra il limite superiore e quello inferiore
            count += 1 #count ritorna il numero di volte in cui e' vera la condizione, ovvero, il numero di volte in cui il valore cade nell'intervallo definito

    return count

#step 4: definiamo il numero di intervalli e, l'ampiezza di ciascun intervallo
N = 10
ampIntervallo = 1.0/N #sappiamo che il valore massimo generato e' 1.0, quindi dividiamo lo spazio da 0.0 a 1.0 in N intervalli

#step 5: definiamo il limite inferiore e quello superiore di ciascun intervallo e la lista dei conteggi, quindi calcoliamo
listaConteggi = N * [0]

for j in range(N):
    limiteInferiore = j * ampIntervallo #moltiplichiamo l'indice per l'ampiezza dell'intervallo, in modo da spostarci lungo tutto l'asse 0.0 - 1.0... questo e' il limite inferiore di ciascun intervallo
    limiteSuperiore = limiteInferiore + ampIntervallo #per il limite superiore, basta sommare al valore del limite inferiore l'ampiezza dell'intervallo
    listaConteggi[j] = intervallo(lista, limiteInferiore, limiteSuperiore) #usiamo la funzione intervallo per determinare il numero di volte in cui un valore cade in quel determinato intervallo

#print(listaConteggi)

'''
note alla soluzione:
Anche se potrebbe apparire una buona soluzione, in realta' questa non e' una buona soluzione, a causa dell'elevato numero di calcoli che abbiamo detto di fare!
Di fatto, di volta in volta, la nostra funzione intervallo imporra' di scorrere tutta la lista prima di passare all'indice successivo e duqnue al successivo intervallo.
Ciò che vorremmo e' un singolo attraversamento in modo da ridurre drasticamente il carico computazionale. Per poterlo fare e' importante intercettare l'indice della nostra listaConteggi, senza dover
prima trovare l'intervallo di appartenenza...
1. attraversa la lista
2. moltiplica il il valore in lista per il numero totale di intervalli e arrotonda all'intero
3. il punto due genera l'indice di scrittura per la nostra listaConteggi, ovvero, l'intervallo che ci interssa considerare
4. incrementa il valore in listaConteggi di +1 ---> funzione count
5. fine
'''

#variazione allo step 5 ---> riscriviamo tutto in modo da avere O(1)
for k in lista:
    indx = int(k * N) #moltiplicando un valore presente in lista da 0.0 a 1.0, per il numero totale di intervalli cio' che otteniamo e' un numero compreso tra 0.0 ed N, se arrotondiamo all'intero quello che otteniamo e' proprio l'indice di scrittura
    listaConteggi[indx] = listaConteggi[indx] + 1 #incrementiamo il contatore... il precedente count

print(listaConteggi)
