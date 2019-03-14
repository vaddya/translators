%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>

	void format(const char *str);
	void normalize(double *value, int *power); 
%}
D [0-9]
%%
[+-]{2,}{D}*\.{D}* {
	fprintf(stderr, "Error: two or more signs!\n");
}
[+-]?{D}*\.{2,}{D}* {
	fprintf(stderr, "Error: two or more dots in number!\n");
}
[+-]?{D}*\.{D}* {
	format(yytext);
}
.|\n ;
%%

#ifndef yywrap
int yywrap() { return 1; }
#endif

void main() { while (yylex()); }

void normalize(double *value, int *power) {
    *power = 0;
    while (fabs(*value) < 0.1) {
        *value *= 10;
        *power -= 1;
    }
    while (fabs(*value) > 1) {
        *value /= 10;
        *power += 1;
    }
}

void format(const char *str) {
    static const int BUF_SIZE = 15;

    double value = atof(str);
    int power = 0;
    normalize(&value, &power);

    char buf[BUF_SIZE];
    int written = sprintf(buf, "%+.*g", BUF_SIZE - 3, value);
    memcpy(buf + 1, buf + 2, written - 1);

    printf("%sE%+03d\n", buf, power);
}

