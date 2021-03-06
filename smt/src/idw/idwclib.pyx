from libcpp.vector cimport vector
from cpython cimport array
import numpy as np
cimport numpy as np


cdef extern from "idw.hpp":
  cdef cppclass IDW:
    IDW() except +
    void setup(int nx, int nt, double p, double * xt)
    void compute_jac(int n, double * x, double * jac)
    void compute_jac_derivs(int n, int kx, double* x, double* jac)


cdef class PyIDW:

    cdef IDW *thisptr
    def __cinit__(self):
        self.thisptr = new IDW()
    def __dealloc__(self):
        del self.thisptr
    def setup(self, int nx, int nt, double p, np.ndarray[double] xt):
        self.thisptr.setup(nx, nt, p, &xt[0])
    def compute_jac(self, int n, np.ndarray[double] x, np.ndarray[double] jac):
        self.thisptr.compute_jac(n, &x[0], &jac[0])
    def compute_jac_derivs(self, int n, int kx, np.ndarray[double] x, np.ndarray[double] jac):
        self.thisptr.compute_jac_derivs(n, kx, &x[0], &jac[0])
