
# IN A NUTSHELL #

This is a Matlab algorithm (developed using Octave) to build rigid structures with little information, by 'little' I mean only a list of distances (without specifying the points they are connected).

##### UPDATE 05/2020 ####

This is probably my first program with more than 100 lines (it has probably around 1500 lines) and also my first contact with Matlab. I've learned a lot with the whole process, and reading the code I realize how much my skills evolved.

## DISCLAIMER ##

I do not recommend the use of this algorithm for its initial purpose (see more in the INSPIRATION tab). But it may serve as a guide for fresh start on a new code from zero. Think of it as a travel guide that has only once visited the city he is presenting. 

This is a result of 2 years of research. 1 and 1/2 years in purely theoretical research, and 1/2 a year coding. All with help from my supervisor at my home university and a research scholarship financed by CNPq.

_____________________________________________________
_____________________________________________________ 


## INTRODUCTION ##

This is a Matlab algorithm (developed using Octave) to build rigid structures with little information, by 'little' I mean only a list of distances (without specifying the points they are connected).

In Mathematical Jargon, We want to solve the Unassigned distance Geometry problem:

Given a list of distances D=(l_1,l_2,l_3,..,l_n) we wish to build a graph G = (V,E), where  V = {v_1,v_2,...,v_n } is the set of vertices and E={e_1,e_2,...,e_3} of edges. We also so want to build a graph that is "Rigid". In the specialized literature, there are many subtle definitions of "Rigid". But it is usually understood as a structure that is unique, up to rigid transformations (rotations and translations).

Why "unassigned"?
Well, usually we have more information, we know which distances goes where. But this is not always the case, as people that deal with Spectoscropy and nanotecnology may know very well. So this alg tries to guess the right order of distances while it builds. Of course there may be more than one "right order" which leads to diferent structures (something that never happens in the "assigned problem").

This guessing and building at the same time, reduces the computational cost form ALWAYS exponential to SOMETIMES exponential (its a matter of luck, of better guessing).


## INSPIRATION ##

The initial inspiration for the algorithm came from the paper "Assigned and unassigned distance geometry: applications to biological molecules and nanostructures" [Simon J. L. Billinge; Phillip M. Duxbury; Douglas S. Gonçalves; Carlile Lavor; Antonio Mucherino] published in 2016. In this paper the authors sugest a algorithm called TRIBOND to solve the unassigned geometry problem.

Together with my supervisor, we tried a recursive version of the TRIBOND (which was a brute force one). If you have interest (and also speaks portuguese), I've attached the theoretical embasement of this algorithm in a directory called "/Theory" in .pdf format. There are some experimental results as well. Also the following videos are available

Phil Duxbury -- Unassigned Distance Geometry, Graph Rigidity, and the Nanostructure Problem
(in english)
		https://www.youtube.com/watch?v=hujU4qDOKsM&list=PLKVCRT3MRed6Iw_GE61B2Zyl8O0XA-PLH&index=9&t=0s

Mine (in portuguese)

	Rigidez de Grafos e Estruturas
	
		https://www.youtube.com/watch?v=9wk-_pPEdnY&t=10s
		
	Problema não rotulado de geometria de distâncias
	
		https://www.youtube.com/watch?v=0zdywAzeuIM




________________________________________
________________________________________

## INPUT ##

The input is on the "Rotina" function, as such

	Rotina(Points, Dist0)

Where Points is a 2xn matrix and Dist0 is a distances list. You should only give one of them, if you give both, the algorithm will give preference to Points. In the first lines of the Rotina script there are some commented examples for you to try out. 

Because of the premature end of the research project, this code only works for a complete set of distances, this means that the resulting graf must be completely connected (Yes, you have to know this in advance, im sorry for that). Which means you must have N distances such that:
	
		N = |V|(|V|-1)/2

where |V| is the cardinality of V, the set of vertices.

_______________________________________
_______________________________________

## SOME PRELIMINARIES ## 

### *obs1: ### MORE THAN 6 POINTS

 The algorithm seem to have some trouble with configurations with 6 up points (it works fine for the Hexagon). While testing for more than 5, I usually created a copy of the 5-graph, rotated it, and added it to the original structure, adding up to 10 points. 

		Pontos1 = rand(2,5)
		Pontos2 = [Pontos1, Rotate(Pontos1, angulo)]

For some reason, these structures always worked.


### *obs2: ### PLOTTING GRAPHS

There is a plotting function for graphs, in the NewPoint2 Script, it's called "PlotESave". This function plots in a very smart way, and saves the plot in a specified directory. It plots by the graphs Adjancy matrix (in the code it is given by "Adj"). Since our graphs are complete, Adj has no zero entries, except for its diagonal. Originally, I would later work with incomplete graphs and for each step update the Adj matrix and plotting, so the user could visualize the process. 

Another issue with plotting. I could not make it plot only when a new strucutre appeared, so, there is A LOT of plotting. As a newbie I would open the debugger and set a breakpoint on the PlotESave function, and runned the code under my control (yes, bad choices, but I had to deliver!). For this reason PlotESave is commmented out.


___________________________________________________________
___________________________________________________________ 

## THE FLOW ##


You can either give a distance list, or get some random points in the unitary square

		Points = rand(2,N)

_____1 Rotina.m

	Rotina(Points,Dist0)

This script finds the distances with "DistFinder(Points)" or just takes a given list under "Dist"

_____2 DistCoreArranjo (k, n, p, s, l, L, Dist)

k = the position of the entries ; n=number of distances; p = number of points; s= combinations/possibilities ; l = answer/return; L = variable used in the recursion; Dist = distance list
  
Creates a triplet l=[1,2,3] and defines the distances to be used Dist1

______3 BuildCore (Dist1, n)

Tries out if chosen distances satisfies the triangle inequality, if they do builds a Core with them

calls DistCoreArranjo once more

______4 DistcoreArranjo

Deletes used distances from list ,sets fwd=0.

______5 DistcombNewAtom

Once again builds a triplet as in DistCoreArranjo, but this time for the new point.

______6 ShuffleNewPoint (L, flag, Dist2, Core)

L= triplet, Dist2 = Distances we will now use

Shuffles our triplet, so all possibilities are tested.

Ex: turns 123 to 312, 231, 132, 213, 321.

______7 NewPoint (Dist2, Core, L)

Dist2= updated distances, Core= up to date Core, L = distances to be used

Builds a system of linear equations and verifies if the determinant is not zero, for the system matrix. Then tests for the last unused equation.

set the number of points to
		p = p-1
Updates the core in
		Build <- Core
and sets fwd=0

______8 DistcombNewAtom 
 
Makes a triplet of distances and calls itself with fwd=1

Makes a triplet of points

______9 ShuffleNewPoint2

Does basically the same as ShuffleNewPoint, but there are more parameters

______10 Newpoint2

Selects the previously defined 3 distances and 3 points.
Unselected points goes to "NotCore" variable
As in Newpoint, builds a linear system and tests the same conditions.


______ 10.1 CheckDist (x4, NotCore, Dist3)

Tries to fit the remaining distances in "Dist3" between the remaining points "NotCore" and the new point "x4".

Updates Dist3 to new Value (without used distances).
return to Newpoint2

______
sets 
		p=p-1

If there are still distances left calls DistCombNewAtom again with the new values of Build, Dist3, and fwd=1

Else 
		print(Build)
		PlotESave(Build)


_______ 10.2 PlotESave (Build)

See Observation 2
return 


Return Build














