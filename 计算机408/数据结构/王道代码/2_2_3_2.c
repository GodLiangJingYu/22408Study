        //
        // Created by 86180 on 2026/2/9.
        //
        #include <stdio.h>
        #define MAX 100

        typedef struct {
            int data[MAX];
            int length;
        }SQList;

        void reverse(SQList *l) {
            int left=0,mid;
            int right=l->length-1;
            while (left<right) {
                mid=l->data[left];
                l->data[left]=l->data[right];
                l->data[right]=mid;
                left++;
                right--;
            }
        }


        int main() {
            SQList list;
            int n, i;
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
            reverse(&list);
            printf("The elements in the list are:\n");
            for (i = 0; i < list.length; i++) {
                printf("%d ", list.data[i]);
            }
            printf("\n");
            return 0;
        }