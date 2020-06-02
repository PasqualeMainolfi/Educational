#time complexity

'''

O(1) ---> a tempo costante: il tempo di esecuzione non dipende dalla dimensione dei dati
O(log(n)) ---> a tempo logaritmico: dimezza la dimensione dei dati input ad ogni passo
O(√n) ---> a tempo radice quadrata: più lento di O(log(n)) ma più veloce di O(n)
O(n) ---> a tempo lineare: attraverla l'input un numero costante di volte. Probabilmente la migliore, perchè accede ad ogni elemento del dato
O(n·log(n)) ---> a tempo n·log(n): utile negli algoritmi di sorting
O(n^2) ---> a tempo al quadrato: due loop annidati, scorre tutti gli elementi in input in O(n^2)
O(n^3) ---> a tempo cubico: tre loop annidati
O(2^n) ---> a tempo 2^n: scorre tutti i sottoinsiemi dei dati in input.
O(n!) ---> a tempo n!: scorre attraverso tutte le permutazioni dei dati in input

'''

#...qualche esempio

#O(n)
for i in range(100):
    pass
    #print(i)

#O(n^2)
for i in range(50):
    for j in range(30):
        pass
        #print(i, j)


#O(n^3)
for i in range(50):
    for j in range(30):
        for k in range(10):
            pass
            #print(i, j, k)

#Maximum subarray sum (sottoarray di somma massima) ---> dato un array di interi cercare il sottoarray di somma massima


a = [-1, 2, 4, -3, 5, 2, -5, 2]
new = []

#soluzione 1 ---> non una buona soluzione ---> O(n^3) a tempo cubico ---> brute force
win = 0
i = 0
while(i < len(a)):
    j = i
    while(j < len(a)):
        somma = 0
        k = i
        while(k <= j):
            somma += a[k]
            k += 1
        win = max(win, somma)
        j += 1
    i += 1

print(win)

#soluzione 2 ---> non una buona soluzione ---> O(n^2) a tempo quadratico. Rendiamo più efficiente semplicemente eliminando un loop
win = 0
i = 0
while(i < len(a)):
    somma = 0
    j = i
    while(j < len(a)):
        somma += a[j]
        win = max(win, somma)
        j += 1
    i += 1

print(win)


#soluzione 3 ---> una ottima soluzione ---> O(n) time
#per ogni posizione dell'array calcoliamo la somma massima del subarray n ---> n che termina in quella posizione. Alla fine torna il valore massimo tra tutte le somme
win, somma = 0, 0
for i in a:
    somma = max(i, somma + i)
    win = max(win, somma)

print(win)
