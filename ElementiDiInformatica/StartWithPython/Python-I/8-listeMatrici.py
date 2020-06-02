'''
LISTE E MATRICI

sequenza ordinata di valori; ogni valore e' identificato da un indice
'''

#il metodo piu' veloce per creare una lista e' quello di racchiudere i suoi elementi tra le parentesi quadre [elementi]

listaVuota = [] #crea una lista vuota
lista1 = [1, 2, 3, 4, 5, 10] #lista di sei interi
lista2 = ["cane", 1, 3.6, [0.1, 0.3, 0.5]] #una lista dentro una lista si chiama lista annidata

#funzione range ---> permette di creare una lista a partire da un valore di inizio (incluso) e uno di fine (escluso)
i = range(1, 10, 2) #il terzo argomento indica il valore di incremento
for element in i:
    print(element, " ", end = " ")
print()

#N.B. ---> l'operatore booleano in ci potrebbe anche dire se un elemento esiste o no nella lista. Ritorna 1 se vero, 0 se falso

#per accedere agli elementi di una lista si usa l'operatore [n] con n intero
j = 0
while(j < len(i)): #len ci dice quanto e' lunga la lista i
    print("indice = [%d] \tvalore contenuto = [%.3f]" %(j, i[j]))
    j += 1

#per concatenare due liste si usa l'operatore matematico +; per ripetere un elemento di una lista, l'operatore *
print(lista1 + lista2) #concatenazione
print([lista1[1]] * 3) #ripetizione

#le liste sono mutabili!!!
listaNomi = ["antonio", "marianna", "john"]
print(listaNomi)
listaNomi[-1] = "Roberto" #il valore -1 indica l'ultimo elemento presente nella lista, -2 il penultimo... e cosi' via. In questo caso cambiamo l'ultimo elemento con il nome Roberto
print(listaNomi)

listaNumeri = [1, 2, 3, 4, 5, 6]
print(listaNumeri)
listaNumeri[0:3] = [0, 0] #usiamo l'operatore porzione per sostituire i primi due elementi con due zeri
print(listaNumeri)
listaNumeri[2:] = [] #usiamo l'operatore lista vuota per rimuovere gli elementi dalla posizione 2 sino alla fine
print(listaNumeri)
listaNumeri[1:1] = [10, 9, 8, 7, 6] #in questo modo aggiungiamo elementi nella lista, proprio al centro tra il primo ed il secondo zero
print(listaNumeri)

#del ---> funzione pratica per la cancellazione di elementi da una lista
del listaNumeri[1:-1]
print(listaNumeri)

#clonare una lista
listaForme = ["triangle", "circle", "square"]
listaFormeClonata = listaForme[:]
print(listaForme, "\tlista clonata --->", listaFormeClonata)


############################################
############################################
############################################

#metodi per gli elenchi: append, extend, sort, pop, remove, del, remove

elenco = [1, 41, 3, 5, 1, 0]
elenco.append(3) #aggiunge in coda ad elenco l'argomento
estendi = [10, 25]
elenco.extend(estendi) #aggiunge un elenco
elenco.sort() #ordina gli elementi
print(elenco)

elenco.pop(1) #elimina l'elemento in elenco all'indice indicato in argomento e restiuisce l'elemento rimosso. Senza argomenti rimuove l'ultimo elemento
del elenco[1] #elimina l'elemento in elenco e restituisce la lista modificata
elenco.remove(41) #elimina l'elemento indicato come argomento
print(elenco)


############################################
############################################
############################################

#matrici. Una lista annidata e' spesso usata per creare matrici... in questo caso l'operatore per accedervi sara' [riga][colonna]
'''
proviamo a rappresentare la matrice

    1 2 3
    4 5 6
    7 8 9

'''

matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

for s in range(len(matrix)):
    for a in range(len(matrix[s])):
        print(matrix[s][a], "\t", end = "")
    print()

#le due istruzioni fanno la stessa!!!
print("\n")

for s in matrix:
    for a in s:
        print(a, "\t", end = "")
    print()

print("\n")

#di matrix possiamo estrarre le singole righe
valMatrixRighe = matrix[1]

#e, le colonne
valMatrixColonne = matrix[1][2] #accediamo alla prima lista annidata alla posizione 2
print(valMatrixRighe, valMatrixColonne)

print("\n")

#scriviamo una funzione che definisca una matrice di n-righe ed m-colonne
def emptyMatix(rows, cols):
    mat = [[0] * cols for i in range(rows)] #definiamo la matrice di rows righe e cols colonne usando l'operatore * per la ripetizione
    i = 0
    while(i < rows):
        j = 0
        while(j < cols):
            mat[i][j] = i * j
            print(mat[i][j], "\t", end = "")
            j += 1
        print("")
        i += 1

m = emptyMatix(5, 5) #matrice di 5righe e 5colonne
