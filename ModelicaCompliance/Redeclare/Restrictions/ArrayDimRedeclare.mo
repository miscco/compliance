within ModelicaCompliance.Redeclare.Restrictions;

model ArrayDimRedeclare
  extends Icons.TestCase;

  model A
    Real x[:, :] = ones(size(x, 1), size(x, 2));
  end A;

  A a(redeclare Real x[2, 3]);

  annotation (
    __ModelicaAssociation(TestCase(shouldPass = true, section = {"7.3.3"})),
    experiment(StopTime = 0.01),
    Documentation(
      info = "<html>Tests that array dimensions can be redeclared, even if the
        component is not declared as replaceable.</html>"));
end ArrayDimRedeclare;
