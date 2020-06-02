
import math

#input ---> 10 20 ciao
a, b, c = input("pronto per l'insrimento ---> ").split(" ") #inserisci una serie di tipi ---> split divide ogni volta che incontra uno spazio ed inserisce nelle variabili che abbiamo dichiarato
print(a, b, c)

#...with map
def square(n): #restituisce la il quadrato di un intero
    return(n*n)

a, b = map(int, input("pronto per l'insrimento ---> ").split(",")) #splitta ogni volta che incontra una virgola e mappa come intero
a, b = map(square, (a, b)) #i valori converiti sono mappati dalla funzione square()
print(a, b)


#insiemi
a = set([1, 2, 3, 4, 5])
b = set([5, 3, 4])
c = set([5, 4, 5, 4, 5])

#intersezione ---> ritorna l'insieme di elementi comuni ai due insiemi
#unione ---> ritorna un insieme che contiene gli elementi dei due insiemi considerati, senza ripetizioni
#differenza ---> set a - set b ---> esegue la differenza tra gli elementi di a presenti in b e ritorna gli elementi non presenti in b

print(a.intersection(b), a.union(b), a.difference(c))


#min e max
lista1 = [1, 2, 5, 10, 6]
lista2 = [3, 5, 7, 8, 9, 50]

print(min(lista1), max(lista2)) #min restituisce il più piccolo valore presente, max il più grande
