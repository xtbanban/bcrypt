#ifndef _BCRYPT_DLL_H
#define _BCRYPT_DLL_H

#ifdef BUILD_DLL
	#define DLL_EXPORT __declspec(dllexport)
#else
	#define DLL_EXPORT //__declspec(dllimport)
#endif

#ifdef __cplusplus
extern "C" {
#endif

extern DLL_EXPORT int checkpw(unsigned char* input, char* bcrypt_output);
extern DLL_EXPORT char* bcrypt_output_sure(unsigned char* input, unsigned int rounds, unsigned int times, unsigned int rand_num, _Bool debug);
 
#ifdef __cplusplus
}
#endif

#endif