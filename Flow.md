___________________________________________________________
___________________________________________________________ 

## THE FLOW :


You can either give a distance list, or get some random points in the unitary square

		Points = rand(2,N)

##### 1 Rotina.m

	Rotina(Points,Dist0)

This script finds the distances with "DistFinder(Points)" or just takes a given list under "Dist"

##### 2 DistCoreArranjo (k, n, p, s, l, L, Dist)

k = the position of the entries ; n=number of distances; p = number of points; s= combinations/possibilities ; l = answer/return; L = variable used in the recursion; Dist = distance list
  
Creates a triplet l=[1,2,3] and defines the distances to be used Dist1

##### 3 BuildCore (Dist1, n)

Tries out if chosen distances satisfies the triangle inequality, if they do builds a Core with them

calls DistCoreArranjo once more

##### 4 DistcoreArranjo

Deletes used distances from list ,sets fwd=0.

##### 5 DistcombNewAtom

Once again builds a triplet as in DistCoreArranjo, but this time for the new point.

##### 6 ShuffleNewPoint (L, flag, Dist2, Core)

L= triplet, Dist2 = Distances we will now use

Shuffles our triplet, so all possibilities are tested.

Ex: turns 123 to 312, 231, 132, 213, 321.

##### 7 NewPoint (Dist2, Core, L)

Dist2= updated distances, Core= up to date Core, L = distances to be used

Builds a system of linear equations and verifies if the determinant is not zero, for the system matrix. Then tests for the last unused equation.

set the number of points to
		p = p-1
Updates the core in
		Build <- Core
and sets fwd=0

##### 8 DistcombNewAtom 
 
Makes a triplet of distances and calls itself with fwd=1

Makes a triplet of points

##### 9 ShuffleNewPoint2

Does basically the same as ShuffleNewPoint, but there are more parameters

##### 10 Newpoint2

Selects the previously defined 3 distances and 3 points.
Unselected points goes to "NotCore" variable
As in Newpoint, builds a linear system and tests the same conditions.


##### 10.1 CheckDist (x4, NotCore, Dist3)

Tries to fit the remaining distances in "Dist3" between the remaining points "NotCore" and the new point "x4".

Updates Dist3 to new Value (without used distances).
return to Newpoint2

sets 
		p=p-1

If there are still distances left calls DistCombNewAtom again with the new values of Build, Dist3, and fwd=1

Else 
		print(Build)
		PlotESave(Build)


##### 10.2 PlotESave (Build)

See Observation 2
return 


Return Build

