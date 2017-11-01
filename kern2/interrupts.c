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

#define outb(port, data) \
    __asm__("outb %b0,%w1" : : "a"(data), "d"(port));

static void irq_remap() {
    outb(0x20, 0x11);
    outb(0xA0, 0x11);
    outb(0x21, 0x20);
    outb(0xA1, 0x28);
    outb(0x21, 0x04);
    outb(0xA1, 0x02);
    outb(0x21, 0x01);
    outb(0xA1, 0x01);
    outb(0x21, 0x0);
    outb(0xA1, 0x0);
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

void irq_init() {
    irq_remap();
    idt_install(T_TIMER, timer_asm);
    idt_install(T_KEYBOARD, ack_irq);

    __asm__("sti");
}
