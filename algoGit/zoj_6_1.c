//
// Created by 86180 on 2026/4/4.
//
#include <stdio.h>
#include <stdlib.h>

typedef int ElementType;
typedef struct Node *PtrToNode;
struct Node {
    ElementType Data;
    PtrToNode   Next;
};
typedef PtrToNode List;

List Read(); /* 细节在此不表 */
void Print( List L ); /* 细节在此不表 */

List Reverse( List L );

int main()
{
    List L1, L2;
    L1 = Read();
    L2 = Reverse(L1);
    Print(L1);
    Print(L2);
    return 0;
}

List Reverse( List L ){
    if(L->Next==NULL){
        return L;
    }
    List p=(List)malloc(sizeof(List));
    List head=(List)malloc(sizeof(List));
    head->Next=p;
    while(L->Next!=NULL){
        List pp=(List)malloc(sizeof(List));
        p->Data=L->Data;
        L=L->Next;
        p=pp;
    }
    p=NULL;
    return head->Next;
}