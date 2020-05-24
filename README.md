# bcrypt
bcrypt for c.
add: char* getsalt(unsigned int rand_num)
     char* bcrypt_output(unsigned char* input, unsigned int rounds, unsigned int rand_num)
     int checkpw(unsigned char* input, char* bcrypt_output)
     char* bcrypt_output_sure(unsigned char* input, unsigned int rounds, unsigned int rand_num, unsigned int times)
