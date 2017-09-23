
#define LARGO_LINEA 80
#define CANT_LINEAS 25
#define GREEN_ON_GREEN 0x2a
#define DOS_BSOD_COLORS 0x1f
#define BLACK_ON_YELLOW 0xe0

#include<stdbool.h>
#include<stdint.h>

volatile void* const VGABUF = (volatile char*) 0xb8000;

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
