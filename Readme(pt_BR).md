

%%%%%%		Guia do algoritmo		%%%% DATA 09/2019



##### UPDATE 05/2020 ####

Este é provavelmente meu primeiro programa com mais de 100 linhas (ele deve ter em torno de 1500 linhas) e minha primeira experiência com Matlab, aprendi muito com o processo, e olhando de novo para ele vejo hoje como evolui. De fato, não recomendo o uso deste algoritmo, mas ele pode servir como inspiração para começar do zero e fazer algo mais limpo. Pense nele como um guia de trilha que só fez a trilha uma vez. 

_____________________________________________________
_____________________________________________________ 

## INTRODUÇÃO ##

Este é um algoritmo em Matlab(feito no Octave) para construir estruturas rígidas com pouca informação, isto é somente uma lista de distancias (sem especificar os pares de pontos a que pertence).

Em jargão matemático: 
Dada uma lista de distancias D=(l_1,l_2,l_3,..,l_n) queremos construir um grafo Graph G = (V,E), onde  V = {v_1,v_2,...,v_n } é um conjunto de vértices e E={e_1,e_2,...,e_3} de arestas. Não só isso, como queremos também que o grafo G seja "rígido". Na literatura especializada existem muitas maneiras de definir isso. Mas normalmente é entendido como uma estrutura que é unica, a menos de transformações rígidas (isto é, rotações e translações). 

Porque "unassigned"/"não rotulado" ?
Bom, normalmente temos mais informação, sabemos onde as distancias devem ir. Mas esse nem sempre é o caso, como em aplicações como espectroscopia ou em resultados experimentais de nanotecnologia. Então esse algoritmo tenta adivinhar a ordem das distancias a medida que monta a estrutura. 

Isso diminui o custo computacional de sempre exponencial para "as vezes exponencial, as vezes polinomial" (é uma questão de sorte). 

## INSPIRAÇÃO ##

A inspiração para o algoritmo é um paper "Assigned and unassigned distance geometry: applications to biological molecules and nanostructures" [Simon J. L. Billinge; Phillip M. Duxbury; Douglas S. Gonçalves; Carlile Lavor; Antonio Mucherino] publicado em 2016. Em que sugerem um algoritmo TRIBOND para resolver o problema não rotulado de geometria de distâncias. 

Resolvi, conjuntamente com meu orientador, atacar esse algoritmo de uma maneira recursiva em vez de força bruta. Caso queira ver os resultados teóricos da pesquisa, e entender melhor a teoria coloquei dois arquivos .pdf no repositório em /Theory. Também pode-se assistir os seguintes vídeos:

Phil Duxbury -- Unassigned Distance Geometry, Graph Rigidity, and the Nanostructure Problem
(in english)
		https://www.youtube.com/watch?v=hujU4qDOKsM&list=PLKVCRT3MRed6Iw_GE61B2Zyl8O0XA-PLH&index=9&t=0s

Meus (em portugues)
	Rigidez de Grafos e Estruturas
		https://www.youtube.com/watch?v=9wk-_pPEdnY&t=10s
	Problema não rotulado de geometria de distâncias
		https://www.youtube.com/watch?v=0zdywAzeuIM





________________________________________


A entrada da função é usando a função Rotina(), ou voce pode diretamente usar a função DistCoreArranjo, apesar de ela ter muitas entradas. Já a função Rotina() só tem duas

	Rotina(Points, Dist0)

onde Points é uma matriz 2xn e Dist0 é uma lista de distâncias. Você pode (e deve) fornecer somente um dos dois. Nas primeiras linhas temos alguns exemplos comentados, descomente algum para ver em ação. 

Importante ressaltar, devido ao fim precoce do projeto, o algoritmo só funciona para uma lista completa de distâncias, isso quer dizer que o grafo resultante deve ser totalmente conectado. Isto é, o número de distancias deve ser 

	N = |V|(|V|-1)/2

onde |V| é a cardinalidade de V, o conjunto dos vértices do grafo.


_______________________________________

### *obs1: ###
 O código parece ter problemas para configurações com mais de 5 pontos. Apesar de funcionar para o hexágono (6 pontos). Ao fazer os testes para mais de 5 pontos em geral criava uma de 5 pontos e então aplicava rotações para duplicar a estrutura em outro ângulo pela função Rotate. Da seguinte maneira:

	Pontos1 = rand(2,5)
	Pontos2 = [Pontos1, Rotate(Pontos1, angulo)]

Assim, Pontos2 tem 10 pontos. Por alguma razão, estas estruturas sempre funcionaram. 


### *obs2: ###
Para plotar a estrutura encontrada, vá em NewPoint2, lá tem uma função comentada "PlotESave". Essa função faz um plot de um grafo de maneira muito inteligente e salva em um diretório específico. Ele plota por meio de uma matriz de adjacência (aqui a variável é "Adj"). Como nossos grafos são completos a matriz é somente uma matriz de ums com zeros na diagonal. 
A idéia era posteriormente trabalhar com grafos não completos e ir montando a matriz de adjacência junto com a estrutura, e então possibilitar o plot de maneira mais inteligente. 

Há um problema que não tive tempo de resolver. Não sei como plotar uma só estrutura e então plotar novamente somente quando for diferente. Também, sendo o código recursivo, não consegui fazer com que o código parasse assim que plotasse. Em geral eu colocava um breakpoint depois de PlotESave e rodava o código em modo debug. Se não imprime as estruturas sem parar.

No estado atual a função de PlotESave está comentada. 



### *obs3: ###
 
Dentro dos scripts de todas as funções, o que cada variável de entrada é está escrito no cabeçalho


### *obs4: ###

Dentro da função Rotina.m temos algumas configurações interessantes comentadas. Basta descomentá-las para rodar, e chamar Rotina().

Dentre elas, Pentagrama, Pipa e trapézio (Homométricos), Hexágono, Pentagrama estendido (6 pontos). 






___________________________________________________________
___________________________________________________________ 




#%%%%%%%%%%%          PASSO A PASSO 		%%%%%%%%%%%





Construa um conjunto de pontos no quadrado unitário
 
	Points = rand(2,N)


Explicação de cada função em ordem de aparecimento:

_____1 Excecute o script Rotina.m

	Rotina(Points)

esse script tem nele a definição das distâncias em "Dist"
e chama o algoritmo principal "DistcoreArranjo"

Nele a função "DistFinder(Points)" define a lista de distâncias a partir dos pontos de entrada na função Rotina

ver observação 4

_____2 DistCoreArranjo (k, n, p, s, l, L, Dist)

  Aquias variaveis são:
 k = posição nas entradas ; n=n0 de distancias; p = n0 de pontos; s= combinações ; l = resposta; L = resposta da função que usaremos de argumento para recursão; Dist = lista de distâncias
  
Cria uma tripla por combinação [1,2,3]
Chama a função BuildCore com as distancias associadas a tripla [1,2,3], "Dist1"

______3 BuildCore (Dist1, n)

Recebe as 3 distancias
Testa a desigualdade triangular, se vale então monta um Core

retorna para DistCoreArranjo

______4 DistcoreArranjo

Apaga as distancias já usadas e chama DistCombNewAtom com flag "fwd=0"

______5 DistcombNewAtom

#PRIMEIRA RODADA
monta uma tripla como em foi feito em DistCoreArranjo, mas dessa vez para o novo ponto. Chama a função ShuffleNewPoint 

______6 ShuffleNewPoint (L, flag, Dist2, Core)

L= tripla, flag = sinalizador , Dist2 = Distancias a serem usadas, Core= nosso Core atual, 

Esta função vai combinar a nossa tripla para testar todas as possibilidades de distancias para o novo ponto. Ela monta uma e testa chamando a função NewPoint. 

Ex: Pega 123 e faz 312, 231, 132, 213, 321.

______7 NewPoint (Dist2, Core, L)

Dist2= distancias atuais, Core= Nosso Core atual, L = escolha de distancias a serem usadas

Esta função monta nosso sistema linear, testa o determinante da matriz do sistema, e depois testa a ultima equação não usada no sistema.

###comentado
#Se passa ambos testes, então printa "FOUND:" e dá o estado atual da nossa realização.

subtrai o numero de pontos p=p-1

Chama a Função DistcomNewAtom com o Core atual na variavel "Build" e com "fwd=0"

______8 DistcombNewAtom 
 
 #PRIMEIRA RODADAA

Monta uma combinação de 3 distâncias e chama novamente a função com "fwd=1",

 #SEGUNDA RODADA 

Monta uma combinação dos pontos da estrutura Build e chama a função ShuffleNewPoint2

______9 ShuffleNewPoint2

funciona exatamente como ShuffleNewPoint porém tem Newpoint2 no final em vez de NewPoint

______10 Newpoint2

Seleciona as três distâncias definidas anteriormente da lista em ShuffleNewPoin2, e os três pontos da estrutura. 

Os pontos que não estão selecionados ficam na variável "NotCore"

Monta um sistema linear como em Newpoint, verifica as mesmas condições



	________ 10.1 CheckDist (x4, NotCore, Dist3)

		
		Testa as distâncias remanescentes "Dist3" com os pontos	
		remanescentes "NotCore" e o ponto novo "x4"
		
		Atualiza Dist3


Retira um ponto do contador p=p-1

se ainda houverem distâncias então chama DistcombNewAtom novamente com a Build, Dist3, atualizadas e fwd=1.

Se não houverem mais distâncias então printa a Build

Para Plotar basta descomentar a função de plot PlotESave aqui



	_________ 10.2 PlotESave (Build)

		Faz um plot da estrutura montada. Ver observação 2.


Return Build














