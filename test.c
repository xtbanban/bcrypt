#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <time.h>

#include "bcrypt.h"

_Bool debug = 1;

int main(int argc, char* argv[]) {	
	int k = 0, count;
	char* input;
	
	debug = 0;
	
	if (argc == 1) {
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
		
	} else if (argc == 2) {
		input = argv[1];
		char* output = bcrypt_output_sure(input, 10, 0, 10);
		printf("%s\n", output);
		
	} else {	
		input = argv[1];
		
		char* check = argv[2];
		if (strlen(check) == 60) {
			if (checkpw(input, check)) {
				printf("Check OK.\n");	
			} else {
				printf("Check Erro!\n");
			}			
			return 0;
		}	
		
		count = atoi(argv[2]);
		if (count <= 0)
			count = 1;

		if (argc > 3) {
			if (strcmp(argv[3], "debug") == 0) 
				debug = 1;
		}

		if (debug) {
			for (int j = 0; j < count; j++) {	
				printf("-------------------------------------------------------------------\n");
				char* output = bcrypt_output_sure(input, 10, j, 10);
				printf("---7---|---------22---------||--------------31-------------|\n");
				printf("%s\n", output);
		
				if (checkpw(input, output)) {
					k++;
					printf("Check OK.\n");
				} else {
					printf("Check Erro!\n");
				}
		
				free(output);
			}  
	
			printf("-------------------------------------------------------------------\n");
			printf("Check OK SUM = %d\n", k);
			
		} else {
			for (int j = 0; j < count; j++) {	
				char* output = bcrypt_output_sure(input, 10, j, 10);
				printf("%s\n", output);		
			}
		}	
	}
	
	//system("pause");
	
	return 0;	
}	