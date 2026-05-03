int minNum(Sqlist Q) {
    int res=INT_MIN;
    for (int i=0;i<Q.size;i++) {
        if (Q.data[i]>res) {
            res=Q.data[i];
        }
    }
    return res;
}