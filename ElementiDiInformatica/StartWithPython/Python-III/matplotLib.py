#matplotlib ---> libreria di plottaggio

import matplotlib.pyplot as plt
import numpy as np


#example 1 ---> simple plot
time = np.arange(8.0)
price1 = np.random.uniform(0.0, 100.0, size=8)
price2 = np.random.uniform(0.0, 30.0, size=8)

plt.plot(time, price1)
plt.scatter(time, price2)
plt.xlabel("time") #titolo asse x
plt.ylabel("random numbers") #titolo asse y
plt.show()


#example 2 ---> simple subplot
# print(plt.style.available) #guarda tutti gli stili possibili per i grafici
plt.figure("esempio 2")
plt.style.use("fast") #set stile grafico
t1 = np.arange(0.0, 5.0, 0.01)
f = np.exp(-t1) * np.sin(2 * np.pi * t1)
fc = np.cos(2 * np.pi * t1)

plt.subplot(311) #righeColonneIndice
plt.plot(t1, f, "k")

plt.subplot(312)
plt.plot(t1, fc, "y")

plt.subplot(313)
plt.bar(price1, price2)
plt.show()

#example 3 ---> figure
figura = plt.figure(1, figsize=(25, 5))

g1 = figura.add_subplot(121)
g2 = figura.add_subplot(122)

g1.plot(t1, f, "k")
g2.bar(price1, price2)
plt.show()
