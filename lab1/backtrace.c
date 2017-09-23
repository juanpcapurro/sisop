#include <stdio.h>
#include <stdint.h>

void lookup_frames(uint32_t* frame_addr, uint32_t deepness){
    void* arg1 = frame_addr ? *(frame_addr+2) : NULL;
    void* arg2 = frame_addr ? *(frame_addr+3) : NULL;
    void* arg3 = frame_addr ? *(frame_addr+4) : NULL;
    uint32_t* previous_frame = *frame_addr;

    printf("#%d [%p] %p ( %p %p %p )\n",deepness, frame_addr,*(frame_addr+1), arg1, arg2, arg3);
    if(previous_frame){
        lookup_frames(previous_frame, deepness +1);
    }
}
void backtrace(){
    lookup_frames(*(uint32_t*)__builtin_frame_address(0), 0);
}
void my_write(int fd, const void *msg, size_t count) {
    backtrace();
    fprintf(stderr, "=> write(%d, %p, %zu)\n", fd, msg, count);
    write(fd, msg, count);
}

void recurse(int level) {
    if (level > 0)
        recurse(level - 1);
    else
        my_write(2, "Hello, world!\n", 15);
}

void start_call_tree() {
    recurse(5);
}

int main(void) {
    start_call_tree();
}
