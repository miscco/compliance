within ModelicaCompliance.Arrays.Operations.MatrixProduct;

model ArrayMatrixVectorMul1
  extends Icons.TestCase;
  
function realAlmostEq "Compare an approximation of floating-point numbers and check if they can be considered equal or not."
  input Real a,b;
  input Real absTol := 1e-10;
  input Real relTol := 1e-5;
  output Boolean almostEq;
protected
  Real diff;
algorithm
  diff := abs(a-b);
  almostEq := diff < absTol or diff <= max(abs(b),abs(a)) * relTol;
end realAlmostEq;
  
  Real  r[3] = {{1, 1, 1}, {2, 2, 2}, {3, 3, 3}} * {1, 2, 3} ;
equation 
  assert(realAlmostEq(r[1], 6.0), "The element of r[1] must be 6.0");
  assert(realAlmostEq(r[2], 12.0), "The element of r[2] must be 12.0");
  assert(realAlmostEq(r[3], 18.0), "The element of r[3] must be 18.0");
  
  annotation (
    __ModelicaAssociation(TestCase(shouldPass = true)),
    experiment(StopTime = 0.01),
    Documentation(
      info = "<html>Tests that matrix by vector multiplication of arrays with numeric elements is possible.</html>"));
end ArrayMatrixVectorMul1;
