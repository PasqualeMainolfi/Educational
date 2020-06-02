'''
ESECUZIONE CONDIZIONALE ED OPERATORI LOGICI

ESPRESSIONE BOOLEANA: e' un'espressione che puo' essere vera (1) o falsa (0)
'''
import math
import random

#operatore MODULO %

num1 = 5.0 #riconosce tipo float
num2 = 2.0
quoz = num1/num2 #quoziente
mod = num1%num2 #modulo ---> restituisce il resto della divisione

print(quoz, mod) #guarda la differenza tra quoziente e resto

#espressioni booleane

a = num1 == num2 #l'operatore booleano == confronta due valori e ci dice se sono uguali ---> vero, allora uguale 1; falso, allora uguale 0. N.B. non confondere l'operatore di assegnazione = con l'operatore booleano ==
b = num1 != num2 #l'operatore booleano != confronta due valori e ci dice se il primo e' diverso dal secondo ---> vero, allora uguale 1; falso, allora uguale 0
c = num1 > num2 #l'operatore booleano > confronta due valori e ci dice se il primo e' maggiore del secondo ---> vero, allora uguale 1; falso, allora uguale 0
d = num1 < num2 #l'operatore booleano < confronta due valori e ci dice se il primo e' inferiore del secondo ---> vero, allora uguale 1; falso, allora uguale 0
e = num1 >= num2 #l'operatore booleano >= confronta due valori e ci dice se il primo e' maggiore o uguale del secondo ---> vero, allora uguale 1; falso, allora uguale 0
f = num1 <= num2 #l'operatore booleano <= confronta due valori e ci dice se il primo e' inferiore o uguale del secondo ---> vero, allora uguale 1; falso, allora uguale 0
print("la prima e' %r, la seconda e' %r, la terza e' %r, la quarta e' %r, la quinta e' %r ed infine, la sesta e' %r" %(a, b, c, d, e, f)) #stampa Vero o Falso
print("la prima e' %i, la seconda e' %i, la terza e' %i, la quarta e' %i, la quinta e' %i ed infine, la sesta e' %i" %(a, b, c, d, e, f)) #stampa 1 o 0


#operatori logici ---> and, or e not

numCasuale = random.randint(0, 10)
op_and = (numCasuale < num1) and (numCasuale > num2) #questa espressione e' vera solo se il numero casuale generato e' inferione a num1 e (and) superiore a num2
op_or = (numCasuale < num1) or (numCasuale > num2) #questa espressione e' vera se si verifica una delle due condizioni (or)
op_not = not (numCasuale < num1) #l'operatore logico not nega il valore di una espressione booleana. Trasforma vero in falso
print("numero generato: %d. La prima e' %r, la seconda e' %r e, la terza e' %r" %(numCasuale, op_and, op_or, op_not))


#espressioni condizionali ---> if... else
#la sintassi di una istruzione condizionale e':
#INTESTAZIONE:
#PRIMA ISTRUZIONE
#...
#ULTIMA ISTRUZIONE

#esempio 1
val1 = random.random()
val2 = random.random()
if(val1 < val2):
    print("%.3f e' minore di %.3f" %(val1, val2)) #se e solo se il valore assegnato alla variabile val1 e' inferiore a quello in val2
else:
    print("%.3f e' maggiore di %.3f" %(val1, val2)) #caso contrario


#esempio 2
val3 = random.randint(0, 10)
if(val3%2 == 0):
    print("il numero generato %d e' pari" %val3)
else:
    print("il numero generato %d e' dispari" %val3)


#esempio 3 ---> condizioni annidate
if(val1 == val2):
    print("sono uguali")
else:
    if(val1 > val2):
        print("%.3f e' maggiore di %.3f" %(val1, val2))
    else:
        print("%.3f e' minore di %.3f" %(val1, val2))


#esempio 3.2 ---> condizioni in serie
if(val1 < val2):
    print("%.3f e' minore di %.3f" %(val1, val2))
elif(val1 > val2):
    print("%.3f e' maggiore di %.3f" %(val1, val2))
else:
    print("sono uguali")


#istruzione RETURN ---> permette di terminare l'esecuzione prima che lo stesso raggiunga la fine
def calcolaLogaritmo(x):
    if(x <= 0):
        print("errore: puoi inserire solo numeri positivi!!!")
        return #in questo caso l'istruzione return blocca l'esecuzione senza passare al al calcolo del logaritmo

    risultato = math.log(x)
    print("risultato = %.3f" %risultato)

calcolaLogaritmo(30)
