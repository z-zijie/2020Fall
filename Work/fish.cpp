#include <iostream>
#include <vector>
#include <stack>
using namespace std;

struct P
{
    int x, t;
};


int main()
{
    int N;
    cin >> N;
    int A[1000];
    for (int i=0; i<N; i++) cin >> A[i];
    stack<P> S;
    int cnt = 0;
    for(int i=N-1; i>=0; i--){
        int t = 0;
        while(!S.empty() && A[i]>S.top().x){
            t = max(S.top().t, t+1);
            S.pop();
        }
        S.push({A[i],t});
        cnt = max(cnt, t);
    }
    cout << cnt << endl;
    return 0;
}