# bcrypt
bcrypt for c.

exe:
printf("%s [password] [times] [debug]\n", argv[0]);
printf(" Get the bcrypt_output text(60bit).\n");
printf("-text:password: bcrypt passwordw;\n");
printf("-int:times: Output more result;\n");
printf("-debug: Show debug messages.\n");
printf("------------------------------;\n");
printf("%s [password] [bcrypt_output]\n", argv[0]);
printf(" Check the bcrypt_output text(60bit).\n");
printf("-text:password: bcrypt passwordw;\n");
printf("-text:bcrypt_output(60bit).\n");

dll:
extern __declspec(dllexport) char* getsalt(unsigned int rand_num);
extern __declspec(dllexport) char* bcrypt_output(unsigned char* input, unsigned int rounds, unsigned int rand_num);
extern __declspec(dllexport) int checkpw(unsigned char* input, char* bcrypt_output);
extern __declspec(dllexport) char* bcrypt_output_sure(unsigned char* input, unsigned int rounds, unsigned int rand_num, unsigned int times);

use mingw32 gcc for windows.
#make for bcrypt.o
C:\>gcc -c -DEBUG_DLL bcrypt.c
#link for bcrypt.a bcrypt.dll
C:\>gcc -shared -o bcrypt.dll bcrypt.o -Wl,--kill-at,--out-implib,bcrypt.a