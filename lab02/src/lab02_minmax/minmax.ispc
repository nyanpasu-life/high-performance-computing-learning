bool check_local_compare_is_done(uniform float * local_mins, uniform int size);

export uniform float parallelmin(uniform float x[], uniform int xsize)
{
    //uniform float * local_mins = new uniform float[programCount];
    uniform bool * end_flags = new uniform bool[programCount];
    end_flags[programIndex] = false;

    // assume N % programCount = 0
    //local_mins[programIndex] = x[programIndex];
    for (uniform int i=0; i<xsize; i+=programCount)
    {
        int idx = i + programIndex;

        if(x[idx] < x[programIndex]){
            x[programIndex] = x[idx];
        }
    }

    end_flags[programIndex] = true;

    if(programIndex ==0){ //0번째 gang이 각 로컬 비교 결과값의 취합비교 진행
        while(!check_local_compare_is_done(x, programCount)){} //모든 로컬 비교가 끝날때까지 대기
        for (uniform int i=1; i<programCount; i++){
        if(x[i] < x[0]){
            x[0] = x[i];
        }
    }
        return x[0];
    }


}

export uniform float parallelmax(uniform float x[], uniform int xsize)
{
    //uniform float * local_mins = new uniform float[programCount];
    uniform bool * end_flags = new uniform bool[programCount];
    end_flags[programIndex] = false;

    // assume N % programCount = 0
    //local_mins[programIndex] = x[programIndex];
    for (uniform int i=0; i<xsize; i+=programCount)
    {
        int idx = i + programIndex;

        if(x[idx] > x[programIndex]){
            x[programIndex] = x[idx];
        }
    }

    end_flags[programIndex] = true;

    if(programIndex ==0){ //0번째 gang이 각 로컬 비교 결과값의 취합비교 진행
        while(!check_local_compare_is_done(x, programCount)){} //모든 로컬 비교가 끝날때까지 대기
        for (uniform int i=1; i<programCount; i++){
        if(x[i] > x[0]){
            x[0] = x[i];
        }
    }
        return x[0];
    }


}


bool check_local_compare_is_done(uniform float * local_mins, uniform int size){
    for (int i=0;i<size;i++){
        if(local_mins[i] == false){
            return false;
        }
    }
    return true;
}