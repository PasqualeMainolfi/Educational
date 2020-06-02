#numpy ---> libreria fondamentale per la manipolazione deglia array

import numpy as np #importiamo la libreria. La chimiamo np
import random as rnd

#1. creazione di array con array
a = np.array([4, 5, 7, 9, 10]) #---> creazione di array da lista. Possiamo anche inserire il tipo
b = np.array((4, 5, 7, 9, 10)) #---> creazione di array da tupla

#2. creazione di array con arange
c = np.arange(21) #simile a range()
d = np.arange(3, 10) #start, end
e = np.arange(0, 15, 2) #start, stop, step

#3. ndim, shape, size, copy, fill
ndim = a.ndim #restituisce il numero di dimensioni
shape = a.shape #ritorna il numero di elementi per dimensione
size = a.size #ritorna il numero di elementi totali

f = a.copy() #crea una copia di a

fill1 = a.fill(5) #imposta tutti gli elementi con lo stesso valore passato
a[:] = 5 #identico comportamento di fill

#4. zeros e ones
g1 = np.zeros(10) #crea un array di lunghezza pari all'argomento passato, di soli zeri ---> monodimensionale
g2 = np.zeros((5, 5)) #crea un array bidimensionale di n righe ed m colonne, di soli zeri ---> multidimensionale
h1 = np.ones(10) #crea un array di lunghezza pari all'argomento passato, di soli uno
h2 = np.ones((5, 5)) #crea un array bidimensionale di n righe ed m colonne, di soli uno ---> multidimensionale

#5. operazioni sugli array
somma1 = a.sum() #somma tutti gli elementi
somma2 = h2.sum(axis=1) #somma tutti gli elementi asse 1
prod1 = h1.prod() #prodotto tra tutti gli elementi
prod1 = h2.prod(axis=-1) #prodotto tra tutti gli elementi ultimo asse
min = a.min() #ritorna il valore minore
max = a.max() #ritorna il valore maggiore
argmin = a.argmin() #ritorna l'indice dell'elemento di valore minimo
argmax = a.argmax() #ritorna l'indice dell'elemento di valore massimo

mat1 = np.random.uniform(0.0, 1000, size=(5, 5)) #generiamo una matrice con valori randomici
mat2 = np.random.uniform(0.0, 1000.0, size=(5, 5))

somma = np.add(mat1, mat2)
differenza = np.subtract(mat1, mat2)
prodotto = np.multiply(mat1, mat2)
modulo = np.remainder(mat1, mat2)
divisione = np.divide(mat1, mat2)
prodScalare = np.dot(mat1, mat2)
