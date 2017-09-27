#include <stdint.h>
#include <stdio.h>

void inc_p_0(uint32_t *p) {
    asm("incl %0" : : "m"(p));
}
void inc_p_1(uint32_t *p) {
    asm("incl %0" : : "m"(*p));
}
void inc_p_2(uint32_t *p) {
    asm("incl %0" : "=m"(*p) : "0"(*p));
}

int main(void) {
    uint32_t n = 0;
    inc_p_2(&n);
    printf("n = %d\n", n);
}
