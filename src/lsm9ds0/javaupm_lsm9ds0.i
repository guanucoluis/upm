%module javaupm_lsm9ds0
%include "../upm.i"
%include "cpointer.i"
%include "typemaps.i"
%include "arrays_java.i";

%feature("director") IsrCallback;

%ignore generic_callback_isr;
%include "../IsrCallback.h"

%apply int {mraa::Edge};
%apply float *INOUT { float *x, float *y, float *z };
%apply unsigned char[] {uint8_t *buf};

%{
    #include "lsm9ds0.h"
%}

%typemap(jni) float* "jfloatArray"
%typemap(jstype) float* "float[]"
%typemap(jtype) float* "float[]"

%typemap(javaout) float* {
    return $jnicall;
}

%typemap(out) float *getAccelerometer {
    $result = JCALL1(NewFloatArray, jenv, 3);
    JCALL4(SetFloatArrayRegion, jenv, $result, 0, 3, $1);
}

%typemap(out) float *getGyroscope {
    $result = JCALL1(NewFloatArray, jenv, 3);
    JCALL4(SetFloatArrayRegion, jenv, $result, 0, 3, $1);
}

%typemap(out) float *getMagnetometer {
    $result = JCALL1(NewFloatArray, jenv, 3);
    JCALL4(SetFloatArrayRegion, jenv, $result, 0, 3, $1);
}

%ignore getAccelerometer(float *, float *, float *);
%ignore getGyroscope(float *, float *, float *);
%ignore getMagnetometer(float *, float *, float *);

%include "lsm9ds0.h"
