#include <iostream>
#include <stdio.h>
#include <vector>
#include <algorithm>
#include <string>
#include <sstream>
using namespace std;

int maxsub(vector<int>& nums){
    int pre=0, maxAns = nums[0];
    for(const auto &x: nums) {
        pre = max(pre+x, x);
        maxAns = max(maxAns, pre);
    }
    return maxAns;
}

int main(){
    string s;
    vector<int> v;
    getline(cin, s);
    istringstream is(s);
    int inter;
    char ch;
    while(is >> inter){
        v.push_back(inter);
        is >> ch;
    }
    cout << maxsub(v) << endl;
    
    return 0;
}