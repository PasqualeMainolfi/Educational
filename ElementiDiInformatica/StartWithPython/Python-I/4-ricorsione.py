'''
RICORSIONE ED INSERIMENTO DA TASTIERA
'''

#una funzione ricorsiva e' una funzione che richiama se stessa
#una funzione ricorsiva che non raggiunge mai il suo stato di base e' detta RICORSIONE INFINITA

def contoRovescia(x):
    if(x == 0):
        print("siamo a zero... mi fermo")
    else:
        print(x)
        contoRovescia(x - 1) #richiama se stessa, all'argomento si sottrae 1 fino a che l'espressione booleana e' vera

n = 10
contoRovescia(n)


#inserimento da tastiera
prompt = "Come ti chiami? "
nome = input(prompt) #ci chiede di inserire da tastiera il nostro nome
print("Ciao %s!" %(nome))
