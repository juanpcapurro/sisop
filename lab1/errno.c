#include <errno.h>
#include <stdio.h>   // perror(3)
#include <unistd.h>  // write(2)

const char msg[] = "Escribiendo a nadie\n";

int main(void) {
    ssize_t ret = write(17, msg, sizeof msg - 1);
    if (ret == -1)
        perror("Falló write");

    return (ret >= 0) ? 0 : errno;
}
