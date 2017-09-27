#include <stdio.h>

void inc_p_0(int *p) {
    asm("incl %0" : : "m"(p));
}
void inc_p_1(int *p) {
    asm("incl %0" : : "m"(*p));
}
void inc_p_2(int *p) {
    asm("incl %0" : "=m"(*p));
}

int main(void) {
    int n = 0;
    inc_p_2(&n);
    printf("n = %d\n", n);
}
