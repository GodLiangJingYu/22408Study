//
// Created by 86180 on 2026/2/11.
//
//
// Created by 86180 on 2026/2/9.
//
#include <stdio.h>
#define MAX 100

typedef struct {
    int data[MAX];
    int length;
}SQList;

void deleteX(SQList *l ,int x) {
    int left=0,right=0;
    while (right<l->length) {
        if (left==right&&l->data[right]!=x) {
            ++left;
            ++right;
        }
        if (l->data[right]==x) {

        }
    }
}


int main() {
    SQList list;
    int n, i, getNum;
    printf("enter num:");
    scanf("%d",&getNum);
    printf("Enter the number of elements (max %d): ", MAX);
    scanf("%d", &n);
    if (n > MAX || n < 0) {
        printf("Invalid number of elements.\n");
        return 1;
    }
    printf("Enter %d elements:\n", n);
    for (i = 0; i < n; i++) {
        scanf("%d", &list.data[i]);
    }
    list.length = n;
    deleteX(&list,getNum);
    printf("The elements in the list are:\n");
    for (i = 0; i < list.length; i++) {
        printf("%d ", list.data[i]);
    }
    printf("\n");
    return 0;
}