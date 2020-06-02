'''
TUPLE

una tupla e' una lista di valori separati da una virgola, immutabili
'''

tup = ('a', 'b', 'c', 'd', 'e') #questa e' una tupla

#non poche volte sara' necessario i valori di due variabili ---> a = b; b = a. In ogni caso dovremmo porre una variabile temporanea in cui memorizzare un valore e poi scalbiare

a = 1
b = 2

#...scambiamo
temp = a #memorizziamo il valore di a prima di riassegnare
a = b #assegniamo il valore di b ad a
b = temp #assegniamo il valore memorizzato in temp a b

#...con una tupla questo procedimento diventa molto piu' semplice, basta fare
a = 1
b = 2
print("a = ", a, "\tb = ", b)

a, b = b, a #a sinista una tupla di variabili, a destra una tupla di valori ---> ogni valore e' assegnato alla rispettiva variabile. Ricorda che il numero di variabili deve corrispondere al numero di valori sulla destra
print("a = ", a, "\tb = ", b)
