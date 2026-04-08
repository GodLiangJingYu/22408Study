//
// Created by 86180 on 2026/4/4.
//
#include <limits.h>
#include <stdio.h>

int main() {
    int len,max=-INT_MAX,sum=0;
    scanf("%d",&len);
    int a[len];
    for (int i=0;i<len;i++) {
        scanf("%d",&a[i]);
        sum+=a[i];
    }
    int left=0,right=len-1;
    while (left<right) {
        sum-=(a[left]<a[right] ? a[left++] : a[right--]);
        if (max<sum) {
            max=sum;
        }
    }
    printf("%d",max);
    return 0;
}

//部分正确