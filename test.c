#include <complex.h>
#include <stdio.h>
#include <stdlib.h>
#include <sndfile.h>
#include <fftw3.h>
#include <string.h>
#include <unistd.h>
#include <math.h>
#define PI 3.14159265358979323846


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
  int N = inputinfo.samplerate;
  int echanti = inputinfo.samplerate;
  double *inputtab = (double *) malloc (sizeof(double) * N * inputinfo.channels);
  complex *gauchet = (complex *) malloc (sizeof(complex) * N);
  complex *droitet = (complex *) malloc (sizeof(complex) * N);
  complex *gauchef = (complex *) malloc (sizeof(complex) * N);
  complex *droitef = (complex *) malloc (sizeof(complex) * N);
  complex *outputfg = (complex *) malloc (sizeof(complex) * N);
  complex *outputtg = (complex *) malloc (sizeof(complex) * N);
  complex *outputfd = (complex *) malloc (sizeof(complex) * N);
  complex *outputtd = (complex *) malloc (sizeof(complex) * N);
  
  double *output = (double *) malloc (sizeof(double) * N * 2);
  fftw_plan pf = fftw_plan_dft_1d(N, gauchet, gauchef, FFTW_FORWARD, FFTW_ESTIMATE);
  fftw_plan pb = fftw_plan_dft_1d(N, gauchef, gauchet, FFTW_BACKWARD, FFTW_ESTIMATE);




  while (total >= N)
  {
    total -= N;

    sf_readf_double(inputsnd, inputtab, N);

    int i;
    for (i = 0; i < N; i++)
    {
      gauchet[i] = inputtab[i*inputinfo.channels];
      droitet[i] = inputtab[i*inputinfo.channels+1];
    }

    fftw_execute_dft(pf, droitet, droitef);
    fftw_execute_dft(pf, gauchet, gauchef);

	for (i = 0; i < N; i++)
	{
		outputfg[i] = gauchef[i];
		outputfd[i] = droitef[i];
	}
#define ANGLE
#define AMPLI
#ifdef ANGLE
	{
		double c = 340.;
		double D = .17;
		double max_freq = c/D/2.;
		double conversion = (double) N / echanti;
		for (i = 0; i < max_freq * conversion; i++)
		{
		  double delta = cos(carg(gauchef[i]/droitef[i]));
		  double f = (double) i * conversion;
		  
		  double sintheta = c / D / f * delta / (2. * PI);
		  if (sintheta > 1.) printf("f = %lf sin=%lf deltaphi=%lf\n", f, sintheta, delta / (2. * PI));
		  if (sintheta < -1.) printf("f = %lf sin=%lf deltaphi=%lf\n", f, sintheta, delta / (2. * PI));
		  if (sintheta > 1.) sintheta = 1.;
		  if (sintheta < -1.) sintheta = -1.;
		 
		  double costheta = sqrt(1-sintheta*sintheta);
		  costheta = costheta;
		  //c=1.;
		  outputfg[i] *= costheta;
		  outputfd[i] *= costheta;
		  //outputf[i] = gauchef[i];     
		}
	}
#endif
#ifdef AMPLI
    for (i = 0; i < N; i++)
    {
      double ng = cabs(gauchef[i]);
      double nd = cabs(droitef[i]);
      if (ng < nd)
      {
        outputfd[i] *= ng / nd;
      }
      else
      {
        outputfg[i] *= nd / ng;
      }
    }
#endif
#if DB
    for (i = 0; i < N; i++)
		printf ("%d : %lfdb %lfdb\n", i, 10*log(cabs(outputfg[i]/gauchef[i])), 10*log(cabs(outputfd[i]/droitef[i])));   
#endif
		
    fftw_execute_dft(pb, outputfg, outputtg);
    fftw_execute_dft(pb, outputfd, outputtd);

    for (i = 0; i < N; i++)
    {
      output[i*2] = creal(outputtg[i]);
      output[i*2+1] = creal(outputtd[i]);
    }

/*    for (i = 0; i < 44100; i++)
    {
      double cg = cabs(gauchef[i])/cabs(droitef[i]);
      double cd = cabs(droitef[i])/cabs(gauchef[i]);
      if (cg < cd)
        output[i] = cg;
      else
        output[i] = cd;
    }*/

    for (i = 0; i < N * 2; i++)
    {
      output[i] /= N;
    }

    sf_writef_double(outputsnd, output, N);
    
    printf("ok\n");

  }
  sf_write_sync(outputsnd);
  sf_close(outputsnd);
  sf_close(inputsnd);

  free (inputtab);
  free (gauchet);
  free (gauchef);
  free (droitet);
  free (droitef);
  free (outputtg);
  free (outputfg);
  free (outputtd);
  free (outputfd);
   free (output);
  fftw_destroy_plan(pf);
  fftw_destroy_plan(pb);
  fftw_cleanup();
  return 0;






}
