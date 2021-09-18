/*
 * NM_dis.c
 */

 /*
  * Author: Alfy Benny
  * Module: Normal mode displacement
  * Arguments: Nw (nth frequency), A (Amplitude of displacement), S (Steps of displacement)
  * Data required (Gaussian): Eigenvector matrix, Initial coordinates
  * Operations:
  */

#include <stdio.h>
#include <math.h>

/*
struct INPUT
{
  int Nw;
  double A;
  int S;
}
*/

double NMeigenvec(int N)
{
  double disp[N][3] //N: Number of atoms.
}

void CLA(int argc)
{
  argc = argc;

  const int ARGUMENTS = 3;

  if(argc != ARGUMENTS) {
     printf("Please input the driving frequency omega and the number of time steps N\n");
	 exit(99);

  }
 }

int main(int argc, char *argv[])
{
  CLA(argc);

}
