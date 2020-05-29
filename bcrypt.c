#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <time.h>

#include "bcrypt.h"

#include "base64.c"
#include "const.c"

#define BLOWFISH_F(x) \
	(((ctx->sbox[0][x >> 24] + ctx->sbox[1][(x >> 16) & 0xFF]) \
	^ ctx->sbox[2][(x >> 8) & 0xFF]) + ctx->sbox[3][x & 0xFF])

typedef struct blowfish_context_t_ {
	unsigned int pbox[256];
	unsigned int sbox[4][256];
} blowfish_context_t;

unsigned int get_word(unsigned char* text, int bytes, int* offset){
	unsigned word = 0;
	int i, j;
	j = *offset;
	for (i = 0; i < 4; i++, j++) {
		if (j >= bytes)
			j = 0;
		word = (word << 8) | text[j];
	}
	*offset = j;
	return word;
}

void blowfish_encryptblock(blowfish_context_t *ctx, unsigned int *hi, unsigned int *lo){
	int i, temp;

	for(i = 0; i < 16; i++) {
		*hi ^= ctx->pbox[i];
		*lo ^= BLOWFISH_F(*hi);
		temp = *hi, *hi = *lo, *lo = temp;
	}
	temp = *hi, *hi = *lo, *lo = temp;

	*lo ^= ctx->pbox[16];
	*hi ^= ctx->pbox[17];
}

void expand_key(blowfish_context_t* ctx,  unsigned char* salt, unsigned char* key,  int saltbytes, int keybytes) {
	int i, j, k;
	for(i = 0, j = 0; i < 18; i++) {
		ctx->pbox[i] ^= get_word(key, keybytes, &j);
	}
	unsigned int hi = 0, lo = 0;
	for (i = 0, j = 0; i < 18; i += 2) {
		if (saltbytes > 0) {
			hi ^= get_word(salt, saltbytes, &j);
			lo ^= get_word(salt, saltbytes, &j);
		}
		blowfish_encryptblock(ctx, &hi, &lo);
		ctx->pbox[i] = hi;
		ctx->pbox[i + 1] = lo;
	}
	for(i = 0; i < 4; i++) {
		for(k = 0; k < 256; k += 2) {
			if (saltbytes > 0) {
				hi ^= get_word(salt, saltbytes, &j);
				lo ^= get_word(salt, saltbytes, &j);
			}
			blowfish_encryptblock(ctx, &hi, &lo);
			ctx->sbox[i][k] = hi;
			ctx->sbox[i][k + 1] = lo;
		}
	}
}

void eks_blowfish_setup(blowfish_context_t* ctx, int rounds, unsigned char* salt, unsigned char* key) {
	int i;
	int saltbytes = strlen((char*)salt);
	int keybytes = strlen((char*)key) + 1;
	
	for(i = 0; i < 4; i++)
		memcpy(ctx->sbox[i], ORIG_S[i], 256 * sizeof(int));
	
	memcpy(ctx->pbox, ORIG_P, 18 * sizeof(int));
	
	expand_key(ctx, salt, key, saltbytes, keybytes);
	
	for (i = 0; i < (1<<rounds); i++) {
		expand_key(ctx, (unsigned char*)"", key, 0, keybytes);
		expand_key(ctx, (unsigned char*)"", salt, 0, saltbytes);
	}
}

void encrypt_ecb(blowfish_context_t* ctx, unsigned int* cdata) {
	int i;
	for (i = 0; i < 6; i += 2) {
		blowfish_encryptblock(ctx, cdata+i, cdata+i+1);
	}
}

char* bcrypt(unsigned int rounds, unsigned char* salt, unsigned char* input) {
	int i;
	char* output = (char *)malloc(61 * sizeof(char)); 	// 60 * sizeof(char)
	unsigned int cdata[16];
	unsigned char ctext[25];
	memcpy(cdata, CIPHER_TEXT, 6 * sizeof(int));  		// 16 * sizeof(int)

	blowfish_context_t *ctx = (blowfish_context_t *)malloc(sizeof(blowfish_context_t));
	eks_blowfish_setup(ctx, rounds, salt, input);
	for (i = 0; i < 64; i++) {
		encrypt_ecb(ctx, cdata);
	}
	for (i = 0; i < 6; i++) {
		ctext[4 * i + 3] = cdata[i] & 0xff;
		cdata[i] >>= 8;
		ctext[4 * i + 2] = cdata[i] & 0xff;
		cdata[i] >>= 8;
		ctext[4 * i + 1] = cdata[i] & 0xff;
		cdata[i] >>= 8;
		ctext[4 * i + 0] = cdata[i] & 0xff;
	}
	ctext[23] = '\0';
	snprintf(output, 8, "$2a$%2.2u$", rounds);
	memcpy(output + 7, base64_encode(salt), 22);
	memcpy(output + 29, base64_encode(ctext), 31);
	output[60] = '\0';									// output[61] = '\0'
	
	free(ctx);

	return output;
}

/*  -----------below is myself ------------  */

char* getsalt(unsigned int rand_num, _Bool debug) {
	char* CODE = "./ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

	char* orig = (char *)malloc(sizeof(char) * 17);
	char* salt = (char *)malloc(sizeof(char) * 23);
	
	srand(time(NULL) + rand_num);
	
	for (int i = 0; i < 16; i++)
		orig[i] = CODE[rand()%64];
	
	orig[16] = '\0';

	if (debug)
		printf("orig = %s       len = %lu\n", orig, strlen(orig));

	salt = base64_encode(orig);
	
	salt[22] = '\0';
	
	if (debug)	
		printf("salt = %s len = %lu\n", salt, strlen(salt));

	free(orig);
	
	return salt;	
}

char* bcrypt_output(unsigned char* input, unsigned int rounds, unsigned int rand_num, _Bool debug) {
	char* salt = getsalt(rand_num, debug);
	unsigned char* csalt = base64_decode(salt);
	
	if (rounds < 8 || rounds > 32) rounds = 8;
	
	char* output = bcrypt(rounds, csalt, input);
	
	free(salt);
	free(csalt);
	
	return output;
}

DLL_EXPORT int checkpw(unsigned char* input, char* bcrypt_output) {
	int ok = 0, rounds;
	char* salt = (char *)malloc(sizeof(char) * 23);

	if (strlen(bcrypt_output) == 60) {		
		strncpy(salt, bcrypt_output + 4, 2);
		salt[2] = '\0';
		int rounds = atoi(salt);

		if (rounds > 7 && rounds < 32) {	
			strncpy(salt, bcrypt_output + 7, 22);	
			salt[22] = '\0';

			unsigned char* csalt = base64_decode(salt);
			char* output = bcrypt(rounds, csalt, input);
			
			if (strcmp(bcrypt_output, output) == 0) 
				ok = 1;
			
			free(csalt);
			free(output);
		}
	}
	free(salt);
	
	return ok;
}	

DLL_EXPORT char* bcrypt_output_sure(unsigned char* input, unsigned int rounds, unsigned int rand_num, unsigned int times, _Bool debug) {
	char* output;
	if (times < 1) times = 1;
	unsigned int i = times;
again:
	output = bcrypt_output(input, rounds, rand_num + i * 10, debug);
	if (!checkpw(input, output)) {
		i--;
		if (i) {
			goto again;
		} else {
			goto next;
		}	
	}	
next:
	if (debug)
		printf("trys = %d / %d\n", (times - i + 1), times);

	return output;	
}	

#ifndef BUILD_DLL

int main(int argc, char* argv[]) {	
	int k = 0, count;
	char* input;
	_Bool debug = 0;
	
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
		char* output = bcrypt_output_sure(input, 10, 0, 10, 0);
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
				char* output = bcrypt_output_sure(input, 10, j, 10, 1);
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
				char* output = bcrypt_output_sure(input, 10, j, 10, 0);
				printf("%s\n", output);		
			}
		}	
	}
	
	//system("pause");
	
	return 0;	
}	

#endif