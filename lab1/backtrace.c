#include <stdio.h>
#include <stdint.h>

void lookup_frames(uint32_t* frame_addr, uint32_t deepness){
    uint32_t* previous_frame = *frame_addr;
    printf("#%d [%p] %p ( %p )\n",deepness, frame_addr, 4+frame_addr, NULL);
    if(previous_frame)
        lookup_frames(previous_frame, deepness +1);
}
void backtrace(){
    uint32_t* this_frame_addr  = __builtin_frame_address(0);
    lookup_frames(this_frame_addr, 0);
}
void bar(int paramAB){
    backtrace();
}

void foo(int paramA,int paramB){
    bar(paramA);
}

int main(){
    foo(100,200);
}
