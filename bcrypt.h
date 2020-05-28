#ifndef _BCRYPT_DLL_H_
#define _BCRYPT_DLL_H_

#ifdef BUILD_DLL
#define DLL_EXPORT __declspec(dllexport)
#else
#define DLL_EXPORT //__declspec(dllimport)
#endif

DLL_EXPORT char* getsalt(unsigned int rand_num);
DLL_EXPORT char* bcrypt_output(unsigned char* input, unsigned int rounds, unsigned int rand_num);
DLL_EXPORT int checkpw(unsigned char* input, char* bcrypt_output);
DLL_EXPORT char* bcrypt_output_sure(unsigned char* input, unsigned int rounds, unsigned int rand_num, unsigned int times);

#endif