#include "decls.h"
#include "multiboot.h"
#define BLACK_ON_WHITE 0x70
#define BUF_LEN 256

void kmain(const multiboot_info_t *mbi) {
    vga_write("kern1 loading.............", 1, BLACK_ON_WHITE);
    if (!mbi){
        vga_write("couldnt find multiboot info.", 2, BLACK_ON_WHITE);
    }else{
        if( mbi->flags & MULTIBOOT_INFO_CMDLINE ){
            char* cmdline = (char*)mbi->cmdline;
            char buf[BUF_LEN]= "cmdline: ";
            strlcat(buf, cmdline,BUF_LEN);
            vga_write(buf,2,BLACK_ON_WHITE);
        }else{
            vga_write("couldnt find bootloader parameters", 3, BLACK_ON_WHITE);
        }

    }
}
