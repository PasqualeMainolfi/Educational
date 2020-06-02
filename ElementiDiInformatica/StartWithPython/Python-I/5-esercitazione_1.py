'''

1. scrivere un programma che calcoli la distanza tra due punti, dopo aver inserito le coordinate (x1, y1) ed (x2, y2) ---> teorema di Pitagora
2. scrivere un programma che calcoli il fattoriale di un valore intero n inserito dall'utente ---> n!
3. scrivere un programma che stampi n valori in sequenza di Fibonacci a partire da un valore intero x a scelta dell'utente ---> f(0) = 1; f(1) = 1; f(n - 1) + f(n - 2)

'''

import math

#SOLUZIONE ESERCIZIO 1
def calcolaDistanza(x1, y1, x2, y2):
    dx = float(x1 + x2)
    dy = float(y1 + y2)
    distanza = math.sqrt(math.fabs(dx**2 - dy**2))
    return distanza


#SOLUZIONE ESERCIZIO 2
def calcolaFattoriale(n):
    if(n == 0):
        return 1
    else:
        val = calcolaFattoriale(n - 1)
        fattoriale = (n * val)
        return fattoriale

'''
NOTE ALLA SOLUZIONE 2:
se provassimo ad inserire un valore del tipo 1.5, questa funzione diventerebbe una ricorsione infinita ---> non incontrera' mai il caso base n == 0.
Come facciamo allora a fermare la ricorsione? Per fermare la ricorsione basta applicare un controllo di tipo (funzione type)

def calcolaFattoriale(n):
    if(type(n) != type(1)): #controlla se il valore inserito e' un numero intero
        print("error... definita solo per valori interi!")
        return -1 #ferma il processo
    elif(n < 0): #controlla se il valore inserito e' un numero intero positivo
        print("error... definita solo per valori interi positivi!")
        return -1
    elif(n == 0):
        return 1
    else:
        return n * calcolaFattoriale(n - 1)
'''

#SOLUZIONE ESERCIZIO 3
def calcolaFibonacci(x):
    if((x == 0) or (x == 1)):
        return 1
    else:
        fib = calcolaFibonacci(x - 1) + calcolaFibonacci(x - 2)
        return(fib)



'''
x1 = input("insierisci punto x1: ")
y1 = input("insierisci punto y1: ")
x2 = input("insierisci punto x2: ")
y2 = input("insierisci punto y2: ")

d = calcolaDistanza(x1, y1, x2, y2)

print("la distanza che passa tra i due punti e' uguale a: %.3f metri" %(d))
'''
'''
n = int(input("inserisci il valore di cui vuoi calcolare il fattoriale: "))
f = calcolaFattoriale(n)

print("%d! = %d" %(n, f))
'''
'''
x = int(input("inserisci il numero intero di partenza: "))
fib = calcolaFibonacci(x)
print("fibonacci(%d) = %d" %(x, fib))
'''
