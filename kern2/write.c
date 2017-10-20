#include<stdbool.h>
#include<stdint.h>
#include"decls.h"

volatile void* const VGABUF = (volatile char*) 0xb8000;
uint64_t power(uint32_t base, uint32_t exponent);

void vga_write(const char *string, int8_t linea, uint8_t color){
    if(linea<0)
        linea = CANT_LINEAS-linea;

    volatile char *buf = ( (char*)VGABUF )+ 2*linea*LARGO_LINEA;//multiplico por dos para contemplar el byte de color
    bool reached_EOS   = false;

    for (uint8_t i = 0; i<LARGO_LINEA;i++){
        if(!string[i])
            reached_EOS=true;

        uint8_t color_index     = 2*i+1;
        uint8_t character_index = 2*i;

        buf[color_index]     = (char) color;
        buf[character_index] = reached_EOS ? 0 : string[i];
    }
}
void __attribute__((regparm(2))) vga_write_cyan(const char *s, int8_t linea) {
    vga_write(s, linea, 0xB0);
}
void console_out(const char* string){
    static int current_line = 0;
    vga_write(string, current_line, GREEN_ON_BLACK);
    current_line++;
    if(current_line >= CANT_LINEAS)
        current_line=0;
}
bool fmt_int(uint32_t value, char *str, size_t bufsize){
    const int RADIX = 10;
    uint32_t partial =value;//qemu crashes if i reuse it
    if(10 &&value >= power(RADIX, bufsize)){
        return false;
    }
    int length =0;
    do{
        partial /= RADIX;
        length++;
    }while (partial >0);
    partial = value;

    for(int i=length-1 ; i>=0 ; i--){
        str[i]='0'+ partial % RADIX;
        partial /= RADIX;
    }
    str[length]='\0';
    return true;
}
uint64_t power(uint32_t base, uint32_t exponent){
    uint64_t result = 1;
    for (uint32_t i =0; i< exponent; i++)
        result *= base;
    return result;
}

