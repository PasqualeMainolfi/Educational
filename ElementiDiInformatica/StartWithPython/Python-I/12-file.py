'''

FILE

'''

#la funzione open ti permette di aprire un file ---> e' necessario specificare il nome del file e il modo. Gli stiamo dicendo di aprire il file test.txt in scrittura ("w")
#nel caso in cui il file non esista, ne creera' uno.
file = open("test.txt", "w")

#per inserire dati nel nostro file test.txt usiamo il metodo .write()
file.write("Scrivi questo: ci stiamo occupando della scrittura in un file!\n# riga 2\nriga 3\n# riga 4\n# riga 5\n etc...")

#per chiudere il file e poterlo leggere usiamo il metodo .close()
file.close()

#a questo punto possiamo riaprire, questa volta in lettura, il file che abbiamo creato. r ---> lettura
file = open("test.txt", "r")

#il metodo .readline() legge tutti i caratteri fino al prossimo ritorno a capo
leggiLinea = file.readline()
#print(leggiLinea)

#il metodo .read() legge i dati da un file. Se non inseriamo argomenti, legge l'intero file
leggi = file.read()
#print(leggi[:])

#ricerca dentro un file. Una metodo per la ricerca in un file e' .startswith() ---> seleziona tutto cio' che ha il prefisso desiderato
f1 = open("test.txt", "r")

for l in f1:
    l = l.rstrip() #elimina gli spazi bianchi dal lato destro di una stringa
    if(l.startswith("# ")): #startswith ci dice se la condizione e' vera o falsa, se vera allora...
        print(l)

print("\n")

#utilizzo di continue nella ricerca
f2 = open("test.txt")
for k in f2:
    k.rstrip()
    if(k.find("riga") == -1): #la condizione per saltare e' che la stringa riga non esista
        continue #salta e continua a cercare
    print(k)


#elaborazione file 1: scriviamo una funzione che ci permetta di copiare un file, o parte di esso in un nuovo file
def copiaTesto(sorgente, copia):
    file1 = open(sorgente, "r") #il file da copiare lo apriamo in lettura
    file2 = open(copia, "w") #...quello in cui copiare, in scrittura
    count = 0

    while(True):
        testo = file1.read() #senza argomento copiera' tutto il file
        lenTesto = len(testo) #ci interessa sapere quanto e' lungo il file

        if(count > lenTesto - 1): #quando avremo raggiunto l'intera lunghezza
            break #stoppa tutto
        count += 1 #incrementa il contatore per il confronto
        file2.write(testo) #scrivi il nuovo file

    file1.close()
    file2.close()
    return

copiaTesto("test.txt", "provaCopia.txt")

#elaborazione file 2: filtriamo un file di testo e copiamo solo le righe che cominciamo con un certo carattere
def filtraFile(sorgente, copia, carattere):
    f1 = open(sorgente, "r")
    f2 = open(copia, "w")

    while(True):
        linea = f1.readline() #legge ogni linea
        if(linea == ""): #se la riga e' vuota, stoppa tutto
            break
        if(linea.startswith(carattere)): #se la linea comincia con il carattere allora...
            f2.write(linea) #scrivi nel nuovo file

    f1.close()
    f2.close()
    return

filtraFile("test.txt", "provaCopia2.txt", "#")


##################################################
##################################################
##################################################

#scittura delle variabili ---> funzione str()
g = 50
toString = str(g)
print("%s" %(toString))

#altro modo e' usare l'operatore modulo in stringa % ---> in una stringa identifica l'operatore formato ---> proprio come abbiamo fatto in print
#creiamo un dizionario che contiene nome e numero di telefono e stampiamo formattando

def rubrica(agenda):
    nomi = agenda.keys() #ritorna la chiave in dizionario
    nomi.sort() #ordiniamo in ordine alfabetico
    for nome in nomi:
        print("%-12s %10d" %(nome, agenda[nome])) #il valore dopo l'operatore formato % indica il numero minimo di caratteri che occupera' il nostro dato da convertire ---> negativo = spazi dopo; positivo = spazi prima

agenda = {"Mario" : 325, "Luca" : 782, "Roberto" : 111, "Vincenzo" : 954}
rubrica(agenda)

##################################################
##################################################
##################################################

#try/except ---> gestione delle eccezioni
#immaginiamo di chiedere di inserire il nome di un file da aprire. Il caso piu' comune d'errore e' quello in cui si inserisce il nome di un file che potrebbe non esistere.
#vediamo come risolvere

def apriFile():
    fname = input("inserisci il nome del file da aprire: ")
    try:
        f = open(fname) #apre solo se il file esiste
    except:
        print("il file non esiste!") #se non esiste...
        exit() #esce subito dal programma

    leggi = f.read()
    print(leggi)

apriFile() #proviamo la funzione!

#e' possibile usare blocchi multipli di except per gestire piu' eccezioni
