'''
FUNZIONE: una funzione accetta un argomento e restituisce un risultato.
1. prima di poter usare una funzione di un modulo dobbiamo passare all'interprete il nome del modulo che contiene la funzione;
2. possiamo liberamente definire una funzione.
'''

import math #importiamo il modulo math

#PUNTO 1)

numero = 3
a = id(numero) #id(arg) e' una funzione che restituisce la posizione in memoria dell'argomento

val = 32
funFloat = float(val) #funzione che converte in virgola mobile
funStringa = str(val) #funzione che converte in stringa

minuti = 59
div = float(minuti)/60 #divisione tra interi. Per evitare che restituisca sempre zero, convertiamo la variabile minuti in virgola mobile

print(div)


#Usiamo una qualche funzione contenuta nel modulo importato.
#Per usare la funzione contenuta nel modulo, la sintassi e': nomemodulo.funzione ---> notazione punto

sogliaUdibile = 2 * math.pow(10, -5) #usiamo la funzione pow del modulo math, per calcolare la potenza
decibel = 20 * math.log10((2 * sogliaUdibile)/sogliaUdibile) #usiamo la funzione logaritmo del modulo math, per calcolare il livello di pressione sonora


angle = math.pi / 2 #math.pi restituisce il valore piGreco
seno = math.sin(angle) #cio' che facciamo e' calcolare il seno di un angolo di 90 gradi usando la funzione math.sin

print(decibel, seno)


#PUNTO 2)
'''
per definire una funzione, la sintassi e':

def nomeFunzione(argomenti-che-accetta):
    ISTRUZIONI DI ESECUZIONE
'''

def stampa2Volte(arg): #definiamo una semplicissima funzione che stampa due volta il valore in input
    print(arg, arg)

nomeCane = 'rambo'
stampa2Volte(nomeCane) #richiamiamo la funzione definta

def areaCerchio(radius):
    area = math.pi * math.pow(radius, 2)
    print("l'area del cerchio misura: %.3f mq" % area)

raggio = 5
areaCerchio(raggio)
