#include "decls.h"
#include "interrupts.h"

static struct IDTR idtr;
static struct Gate idt[256];

static const uint8_t STS_IG32 = 0xE;
static const uint8_t KSEG_CODE = 8;

void idt_init(void){
    idtr.base  = (uintptr_t) idt;
    idtr.limit = 256*8-1;
    __asm__("lidt %0" : : "m"(idtr));
}

void idt_install(uint8_t n, void (*handler)(void)) {
    uintptr_t addr = (uintptr_t) handler;

    idt[n].rpl = 0;
    idt[n].type = STS_IG32;
    idt[n].segment = KSEG_CODE;

    idt[n].off_15_0 = addr & 0x0000FFFF;
    idt[n].off_31_16 = addr >> 16;

    idt[n].present = 1;
}

