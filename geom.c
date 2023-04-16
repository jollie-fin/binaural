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

  outputinfo.channels = 2;

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
  
  for (j = 0; j < total; j++)
  {
	  inputtab[2*j] = inputtab[2*j] * inputtab[2*j+1] / sqrt(inputtab[2*j] * inputtab[2*j] + inputtab[2*j+1] * inputtab[2*j+1]);
  }
  
  double max = 0.;
  for (j = 0; j < total; j++)
  {
	if (max  < inputtab[2*j])
	  max = inputtab[2*j];
	if (max < -inputtab[2*j])
	  max = -inputtab[2*j];
  }
  
  for (j = 0; j < total; j++)
  {
	inputtab[2*j] /= max;
  }
  


  sf_writef_double(outputsnd, inputtab, total);

  sf_write_sync(outputsnd);
  sf_close(outputsnd);
  sf_close(inputsnd);

  free (inputtab);
  free (croise);
  free (carre);
   free (output);
  return 0;
}
