//
// Created by 86180 on 2026/4/5.
//
#include <stdio.h>

int main() {
    int numStd,askNum;
    scanf("%d %d",&numStd,&askNum);
    int std[numStd],ask[askNum];
    std[0]=-1;
    for (int i=1;i<=numStd;i++) {
        scanf("%d",&std[i]);
    }
    for (int i=1;i<=askNum;i++) {
        scanf("%d",&ask[i]);
    }
    for (int i=1;i<=askNum;i++) {
        printf("%d\n",std[ask[i]]);
    }
    return 0;
}