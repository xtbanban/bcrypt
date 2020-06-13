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
extern __declspec(dllexport) int checkpw(unsigned char* input, char* bcrypt_output);
extern __declspec(dllexport) char* bcrypt_output_sure(unsigned char* input, unsigned int rounds, unsigned int times);

#------------use mingw64 gcc for windows7----------------
#------------use mingw32 gcc for windows7----------------
#------------use mingw64 gcc for windows10---------------
#------------use gcc for ubuntu---------------
# make for exe 
gcc bcrypt.c test.c -o test.exe 

#------------use mingw32 gcc for windows7---------------
# make for bcrypt.o (-DBUILD_DLL = define BUILD_DLL)
gcc -c -DBUILD_DLL bcrypt.c
# link for bcrypt.dll libbcrypt.a
gcc -shared -o bcrypt.dll bcrypt.o -Wl,--kill-at,--out-implib,libbcrypt.a

# make exe with dll use libbcrypt.a (-lbcrypt = libbcrypt.a)
gcc -o testdll.exe test.c -L./ -lbcrypt
<<<<<<< HEAD
(testdll.exe with bcrypt.dll)
=======
>>>>>>> 1769373aa659b6b268e46ce04bf6050ff8a5077a
