#graph representation

#node n = nodi o vertici;
#edge v = archi o collegamenti;
# grafo diretto
# grafo non diretto
# weight w = costo
# neighbors nb
# degree dg

#i grafi possono essere rappresentati in due modi:
# 1. mediante liste di adiacenza:
# 2. mediante matrici di adiacenza.


#liste di adiacenza
adjList = {
    "A" : ["B", "C"],
    "B" : ["A", "D"],
    "C" : ["A", "D"],
    "D" : ["C", "E"],
    "E" : ["C", "D"]
    }

for nodes in adjList:
    print(nodes, "---> ", adjList[nodes])

print("\n")


#step 1: definiamo una classe Grafo
class GrafoWithList:
    def __init__(self, nodi, direct=False): #l'argomento da passare è una lista di nodi e, se il grafo è un grafo diretto o no
        self.adjList = {} #definimao la lista di adiacenza
        self.nodi = nodi
        self.direct = direct

        for node in self.nodi:
            self.adjList[node] = [] #per ogni nodo nella lista nodi, creiamo una lista vuota associata alla chiave node

    def addEdges(self, n, v): #aggiungiamo gli archi
        self.adjList[n].append(v)

        if not self.direct: #se l'argomento direct=False allora il grafo è un grafo indiretto
            self.adjList[v].append(n)

    def degree(self, nodo):
        grado = len(self.adjList[nodo])
        return(grado)

    def show(self):
        for u in self.nodi:
            print(u, "---> ", self.adjList[u])


nodi = ["A", "B", "C", "D", "E"]
archi = [("A", "B"), ("A", "C"), ("B", "D"), ("D", "C"), ("D", "E"), ("E", "C")] #lista archi
gl = GrafoWithList(nodi, False)


for n, v in archi:
    gl.addEdges(n, v)

gl.show()
print("grado del nodo selezionato ---> ", gl.degree("D"))


#matrici di adiacenza
class GrafoWithMatrix:
    def __init__(self, nodi, archi, direct=False):
        self.nodi = nodi
        self.archi = archi
        self.direct = direct
        self.matrix = [len(self.nodi) * [0] for i in range(len(self.nodi))] #importante per definire array 2d

        for h, k in self.archi:
            self.matrix[h][k] = 1
            if not self.direct:
                self.matrix[k][h] = 1

    def show(self):
        for i in self.matrix:
            for j in i:
                print(j, "", end="")
            print()

nodi = [0, 1, 2, 3, 4]
archi = [[0, 1], [0, 2], [1, 3], [3, 2], [3, 4], [4, 3]] #lista archi
gm = GrafoWithMatrix(nodi, archi, False)
gm.show()
