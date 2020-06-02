#bit manipulation

x = 22 #10110
y = 26 #11010

#and operation ---> & ---> produce un numero che ha un bit in tutte quelle posizioni in cui a e b hanno un bit
andOperation = x & y

#  1 0 1 1 0 ---> 22
#& 1 1 0 1 0 ---> 26
#------------
#= 1 0 0 1 0 ---> 18

#or operation ---> | ----> produce un numero che ha un bit nelle posizioni in cui almeno uno tra a e b hanno un bit
orOperation = x | y

#  1 0 1 1 0 ---> 22
#| 1 1 0 1 0 ---> 26
#------------
#= 1 1 1 1 0 ---> 30

#xor operation ---> ^ ----> produce un numero che ha un bit nelle posizioni in cui solo uno dei due ha un bit
xorOperation = x ^ y

#  1 0 1 1 0 ---> 22
#^ 1 1 0 1 0 ---> 26
#------------
#= 0 1 1 0 0 ---> 12

#not operation ---> ~ ----> produce un numero che ha tutti i bit invertiti ---> ~x = -x - 1 ---> ~29 = -30
notOperation = ~x

#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 1 0 ---> 22 (32bit)
#~ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 1 ---> -23

print("\n& ---> ", andOperation, "\n| ---> ", orOperation, "\n^ ---> ", xorOperation, "\n~ ---> ", notOperation, "\n")


#bit shift: left bit shift a << b aggiunge b zero bits al numero; right shift a >> b rimuove gli ultimi b bits

k = 2
leftShift = x << k #10110 ---> 1011000 ---> corrisponde al prodotto di x·2^k
rightShift = x >> k #10110 ---> 101 ---> corrisponde alla divisione x/2^k
print("\n<< ----> ", leftShift, "\n>> ----> ", rightShift, "\n")


#il numero nella forma 1<<k ha un bit precisamente nella posizione k, tutti gli altri sono zeri

lista = []
g = int(input("inserisci un numero intero... converto in binario a 32bit: "))
for i in range(31, 0, -1):
    if(g & (1 << i) != 0): #quando diverso da zero, g ha uno bit in posizione i
        lista.append(1) #...dunque aggiungi 1 alla lista
    else:
        lista.append(0) #caso contrario g ha uno zero

print("%d in binario a 32bit corrisponde a: " %g, lista)

#allo stesso modo:
# x | (1 << k) ---> setta il kth bit a uno
# x & ~(1 << k) ---> setta il kth bit a zero
# x ^ (1 << k) ---> inverte il kth bit di x
# x & (x - 1) ---> setta l'ultimo bit di x a zero
# x & -x ---> setta tutti gli uno a zero, eccetto l'ultimo
# x | (x - 1) ---> inverte tutti i bit seguenti all'ultimo
# x & (x - 1) = 0 ---> quando un numero positivo x è potenza di 2
