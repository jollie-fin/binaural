#include <complex.h>
#include <stdio.h>
#include <stdlib.h>
#include <sndfile.h>
#include <fftw3.h>
#include <string.h>
#include <unistd.h>
#include <math.h>
#include <omp.h>
#define PI 3.14159265358979323846
//#define MULTIPLIE 1

int main(int argc, char **argv)
{
  SF_INFO inputinfo = {0};
  SF_INFO outputinfo = {0};
  memset(&inputinfo,sizeof(inputinfo),0);
  memset(&outputinfo,sizeof(outputinfo),0);

  if (argc != 3)
    return 1;
  SNDFILE *inputsnd = sf_open(argv[1], SFM_READ, &inputinfo);
  #ifdef MULTIPLIE
  outputinfo.channels = 2;
  #else
  outputinfo.channels = 1;
  #endif
  outputinfo.samplerate = inputinfo.samplerate;
  outputinfo.format = inputinfo.format;
  
  SNDFILE *outputsnd = sf_open(argv[2], SFM_WRITE, &outputinfo);

  long total = inputinfo.frames;
  
  double T = 1.;
  double lag = T*4.;
  int N = inputinfo.samplerate * lag;
  int echanti = inputinfo.samplerate;
  double *inputtab = (double *) malloc (sizeof(double) * inputinfo.frames * inputinfo.channels);
  double *croise = (double *) malloc (sizeof(double) * inputinfo.frames);
  double *carre = (double *) malloc (sizeof(double) * inputinfo.frames);
  double *output = (double *) malloc (sizeof(double) * inputinfo.frames);

  sf_readf_double(inputsnd, inputtab, total);
  int k;
  int j;
  
  for (j = 0; j < N; j++)
  {
	  output[j] = 0.;
  }
  
  for (j = 0; j < total; j++)
  {
	  croise[j] = inputtab[2*j]*inputtab[2*j+1];
	  carre[j] = inputtab[2*j]*inputtab[2*j]+inputtab[2*j+1]*inputtab[2*j+1];
  }
  double f = inputinfo.samplerate;
  double coeffi = pow(.5,1./f/T);
  
  for (j = 0; j < N; j++)
  {
	  output[j] = 0.;
  }



  double accumul = 0.;
  double normalise = 0.;
  
  for (j = total-1; j >= total - N; j--)
  {
	accumul = accumul*coeffi+croise[j];
	normalise = normalise*coeffi+carre[j];
  }
  for (j = total-N-1; j >= 0; j--)
  {
	accumul = accumul*coeffi+croise[j];
	normalise = normalise*coeffi+carre[j];
	output[j+N] = accumul / normalise;
  }

#define NORMALISE
#ifdef NORMALISE  
  double max = 0.;
  for (k = 0; k < total; k++)
  {
	if (max  < output[k])
	  max = output[k];
	if (max < -output[k])
	  max = -output[k];
  }
    
  for (k = 0; k < total; k++)
  {
	 output[k] /= max;
  }
 #endif

#ifdef MULTIPLIE
  for (j = 0; j < total; j++)
  {
	inputtab[2*j] *= output[j];
	inputtab[2*j+1] *= output[j];
  }
    
  sf_writef_double(outputsnd, inputtab, total);
#else
  sf_writef_double(outputsnd, output, total);
#endif

  sf_write_sync(outputsnd);
  sf_close(outputsnd);
  sf_close(inputsnd);

  free (inputtab);
  free (croise);
  free (carre);
   free (output);
  return 0;
}
