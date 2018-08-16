#include <cstdlib>

void f() {
    int *x = new int[10];
    x[10] = 0;
}

int main(int, char **) {
    f();
    return 0;
}
