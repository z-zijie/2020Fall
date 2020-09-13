#include <iostream>
#include <string>
#include <vector>
using namespace std;


string manacher(string s){
    string s1("#");
    for(auto ch:s) s1+=ch, s1+="#";
    int sl1(s1.length()), index(0), mlen(1);
    vector<int> pv(sl1,0);
    for(int k1(1), kd(1), kt; k1 < sl1;){
        while (0<=k1-kd && k1+kd < sl1 && s1[k1-kd]==s1[k1+kd]) ++kd;
        pv[k1] = kd-1;
        for(kt =1; kt<=pv[k1] && pv[k1-kt] < pv[k1]-kt; ++kt) pv[k1+kt]= pv[k1-kt];
        k1+=kt;
        kd=kd-kt;
    }
    for (int k1(1); k1<sl1; ++k1){
        if(mlen<pv[k1]) {
            mlen=pv[k1];
            index = k1;
        }
    }
    return s.substr((index-mlen)/2, mlen);
}


int main()
{
    string s;
    cin >> s;
    string ans;
    ans = manacher(s);
    cout << ans << endl;
    return 0;
}