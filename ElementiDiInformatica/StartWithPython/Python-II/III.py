#sorting ---> algoritmi per ordinare

#dato un array a[], ordinare in modo crescente gli elementi
a = [1, 30, 5, 2, 10, 5, 9]


#O(n^2) ---> bubble sort: se due elementi non sono nell'ordine in condizione, scambia le posizioni
for i in range(len(a)):
    for j in range(len(a) - 1):
        first = a[j]
        second = a[j + 1]
        if(first > second): #condizione di ordine (se < allora decrescrente, > crescente)
            a[j], a[j + 1] = a[j + 1], a[j] #swap with tuple

print(a)


#O(n log(n)) ---> merge sort: ordina subarray

b = [1, 30, 5, 2, 10, 5, 9]
print(b)

def mergeSort(ar):
    if(len(ar) > 1): #per bloccare la ricorsione

        r = len(ar)//2
        m1 = ar[:r] #splittiamo in due array
        m2 = ar[r:]

        mergeSort(m1) #ricorsione
        mergeSort(m2)

        i = j = k = 0

        while(i < len(m1) and j < len(m2)):
            if(m1[i] <= m2[j]):
                ar[k] = m1[i]
                i += 1
            else:
                ar[k] = m2[j]
                j += 1
            k += 1

        while(i < len(m1)):
            ar[k] = m1[i]
            i += 1
            k += 1

        while(j < len(m2)):
            ar[k] = m2[j]
            j += 1
            k += 1

mergeSort(b)
for i in b:
    print(i, "\t", end = "")
print()




#binary search ---> di ricerca
#O(log2(n)) ---> time
#si comincia dal centro:
#se il termine cercato è uguale al termine al centro, la ricerca termina;
#se è inferiore, la ricerca continua alla sua sinistra, nella prima metà;
#se è superiore, la ricerca continua alla sua destra, scartando tutti i termini nella prima metà

#binary search: iterativo
def bSearchIter(ar, p, r, x):
    while(p <= r):
        q = (p + r)//2 #continuiamo a dividere in due la zone di ricerca ---> O(log2(n))
        if(ar[q] == x):
            return(q)
        elif(ar[q] > x):
            r = q - 1
        else:
            p = q + 1

    return(-1) #nel caso in cui l'elemento non esista

c = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
x = 11
result = bSearchIter(c, 0, len(c) - 1, x)
print("iterativo ---> ", result)


#binary search: ricorsivo
def bSearchRic(ar, p, r, x):
    if(p <= r):
        q = (p + r)//2
        if(ar[q] == x):
            return(q)
        elif(ar[q] > x):
            return(bSearchRic(ar, p, q - 1, x)) #ricorsione: la funzione chiama se stessa
        else:
            return(bSearchRic(ar, q + 1, r, x))
    else:
        return(-1)

result = bSearchRic(c, 0, len(c) - 1, x)
print("ricorsivo ---> ", result)
