if isunix()
  cd mex_unix
  % use one of the following depending on your setup
  % 1 is fastest, 3 is slowest 
  % 1) multithreaded convolution using blas
  %mex -O fconvblas.cc -lmwblas -o fconv
  %mex fconvblas.cc -lmwblas -o fconv
  % 2) mulththreaded convolution without blas
  % mex -O fconvMT.cc -o fconv
  mex fconvMT.cc -o fconv  
  % 3) basic convolution, very compatible
  % mex -O fconv.cc -o fconv
elseif ispc()
  cd mex_pc;
  %mex -O fconv.cc
  mex fconv.cc
end

%mex -O resize.cc
mex resize.cc
%mex -O reduce.cc
mex reduce.cc
%mex -O dt.cc
mex dt.cc
%mex -O shiftdt.cc
mex shiftdt.cc
%mex -O features.cc
mex features.cc



cd ..;
