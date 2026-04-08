//
// Created by 86180 on 2026/4/5.
//
#include <stdio.h>

#define MAX_LEN 10005
#define MAX_STACK 10005

typedef struct {
    int data[MAX_STACK];
    int top;
} Stack;

int pushInt(const char str[], int* i) {
    int num = 0;
    while (str[*i] >= '0' && str[*i] <= '9') {
        num = num * 10 + (str[*i] - '0');
        (*i)++;
    }
    return num;
}

int jiSuan(int left, int right, char sm) {
    switch (sm) {
        case '+':
            return left + right;
        case '-':
            return left - right;
        case '*':
            return left * right;
        case '/':
            return left / right;
        default:
            return 0;
    }
}

int main() {
    char str[MAX_LEN];
    int top1, top2;
    Stack stack;

    if (fgets(str, sizeof(str), stdin) == NULL) {
        return 0;
    }

    stack.top = -1;
    for (int i = 0; str[i] && str[i] != '\n' && str[i] != '@'; i++) {
        if (str[i] >= '0' && str[i] <= '9') {
            if (stack.top + 1 < MAX_STACK) {
                stack.data[++stack.top] = pushInt(str, &i);
            }
        } else if (str[i] == '*' || str[i] == '-' || str[i] == '+' || str[i] == '/') {
            if (stack.top >= 1) {
                top2 = stack.data[stack.top--];
                top1 = stack.data[stack.top--];
                stack.data[++stack.top] = jiSuan(top1, top2, str[i]);
            }
        }
    }

    if (stack.top >= 0) {
        printf("%d", stack.data[stack.top]);
    }
    return 0;
}