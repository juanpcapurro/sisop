int inc(int x) {
    asm("incl %1" : "=g"(x) : "0"(x));
    return x;
}
int inc2(int x) {
    int ret;
    asm("inc %1; movl %1, %0" : "=r"(ret) : "m"(x));
    return ret;
}
