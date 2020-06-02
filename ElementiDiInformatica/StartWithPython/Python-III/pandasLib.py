#pandas ---> libreria per manipolazione dati

import matplotlib.pyplot as plt
import pandas as pd

exData = pd.read_csv("countries.csv") #per accedere al file desiderato
#print(exData)
#plt.plot(exData.year, exData.population, "k")

#leggere l'intestazione
intestazione = exData.columns

#leggere colonne
colonna = exData["country"] #accedo alla colonna "country"
colonne = exData[["country", "population"]] #accedo al colonne multiple

#leggere righe
riga = exData.iloc[0] #accedo alla riga 0
righe = exData.iloc[1:5] #righe multiple

#leggere una specifica posizione
pos = exData.iloc[1, 2] #accedo alla riga 1 e colonna 2

#descrizione dei dati
des = exData.describe()

#ordinare i dati
ord = exData.sort_values("population", ascending=True) #ordiniamo dal valore più piccolo a quello più grande di popolazione

#print(intestazione, "\n", colonna, "\n", colonne, "\n", riga, "\n", righe, "\n", pos, "\n", des, "\n", ord)


#se io volessi comparare la popolazione degli stati uniti con quella della cina, ad esempio...
us = exData[exData.country == "United States"] #tiro fuori dall'intero file solo united states
ch = exData[exData.country == "China"]

plt.plot(us.year, us.population/10**6, "k")
plt.plot(ch.year, ch.population/10**6, "y")
plt.legend(["United States", "China"])
plt.xlabel("YEAR")
plt.ylabel("POPULATION")
plt.show()


#apportiamo qualche modifica ai dati nel file...
exData["Totale"] = exData["year"] + exData["population"] #aggiungiamo una colonna che chiamiamo "Totale", che definiamo come il risultato di anni + popolazione
#...possiamo scrivere la stessa identica cosa con lo slice
exData["Totale"] = exData.iloc[ : , 1:3].sum(axis=1) #sommiamo di ogni riga, i valori della colonna 1 alla 3 (3 non inclusa!) ed insieriamo tutto nella nuova colonna Totale. axis=1 saltiamo l'header
print(exData)

#...per salvare il file modificato
#exData.to_csv("modificato.csv", index=False)

#per tagliare fuori una colonna...
exData = exData.drop(columns=["Totale"])
print(exData)
