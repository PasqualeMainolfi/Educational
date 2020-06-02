"""
TIPOLOGIE DI VALORI
"""
#..per adesso
intero = 2 #valore intero, appartiene al tipo int
virgolaMobile = 1.33 #valore reale, appartiene al tipo float
stringa = "Ciao" #stringa, appartiene al tipo string (si trovano tra le virgolette)
booleano = True #booleano

#print(type(stringa), type(intero), type(virgolaMobile), type(booleano)) #type restituisce il tipo di valore che stai usando

"""
N.B.
1. il nome assegnato ad una variabile deve cominciare con una lettera (non puo' cominciare con un numero) e, non puo' contenere caratteri non validi (ad esempio $)
2. il nome assegnato ad una variabile non puo' essere una delle parole riservate. Ci sono 28 parole riservate:
and, assert, break, class, continue, def, del, elif, else, except, exec, finally, for, from, global, if, import, in, is, lambda, not, or, pass, print, raise, return, try, while
"""

"""
ESPRESSIONE: combinazione di valori, variabili ed operatori
"""

somma = 1 + 1
differenza = 1 - 1
prodotto = 1 * 1
divisione = 1/1
potenza = 1**2

numeratore = 10 + 5 #questa e' una espressione! il simbolo + e' un operatore
denominatore = 3
espressione = numeratore/denominatore

nome = 'John'
spazio = ' '
cognome = 'Conway'
nomeCognome = nome + spazio + cognome #concatenazione
nomeRipetuto = nome * 5 #ripetizione

print(nomeCognome, nomeRipetuto)

"""
N.B.
quando piu' operatori comiono una operazione, la valutazione dipende dalle REGOLE DI PRECEDENZA

PUNTO 1)
1 ---> parentesi (hanno precedenza su tutto)
2 ---> elevamento a potenza (vengono subito dopo le parentesi)
3 ---> moltiplicazione e divisione (...poi)
4 ---> addizione e sottrazione (e, infine)

PUNTO 2)
non e' possibile effettuare operazioni matematica sulle stringhe ---> nel caso delle stringhe l'operatore + significa concatenare due stringhe e, l'operatore * ripetizione
"""

esp_a = (2 + 3)/3**2 - 1
print('prima le parentesi, poi la potenza ed infine la differenza', esp_a)
