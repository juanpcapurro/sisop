#include "decls.h"
#include "multiboot.h"
#include "./lib/string.h"
#define BUF_LEN 256
#define SHORT_BUF_LEN 16

void kmain(const multiboot_info_t *mbi) {
    //print bootloader parameters
    console_out("kern1 loading.............");
    if (!mbi){
       console_out("couldnt find multiboot info.");
    }else{
        if( mbi->flags & MULTIBOOT_INFO_CMDLINE ){
            char* cmdline = (char*)mbi->cmdline;
            char buf[BUF_LEN]= "cmdline: ";
            strlcat(buf, cmdline,BUF_LEN);
            console_out(buf);
        }else{
            console_out("couldnt find bootloader parameters");
        }
    }
    //print aviable memory
    uint32_t low_mem  = mbi->mem_lower;//in kb
    uint32_t high_mem = (mbi->mem_upper)>>10;//in kb, converted to mb
    char buf[BUF_LEN] = "low memory: ";
    char num_as_str[SHORT_BUF_LEN];
    fmt_int(low_mem, num_as_str, SHORT_BUF_LEN);
    strlcat(buf,num_as_str,BUF_LEN);
    strlcat(buf," KiB",BUF_LEN);
    console_out(buf);

    strlcpy(buf,"high memory: ", BUF_LEN);
    fmt_int(high_mem, num_as_str, SHORT_BUF_LEN);
    strlcat(buf,num_as_str,BUF_LEN);
    strlcat(buf," MiB",BUF_LEN);
    console_out(buf);
}
