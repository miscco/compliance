within ModelicaCompliance.Classes.Balancing;

model CorrectBalance3
  extends Icons.TestCase;

  partial package BaseMedium
    constant Integer nXi = 0 "Number of independent mass fractions";

    partial model BaseProperties 
      "Interface of medium model for all type of media"
      parameter Boolean preferredMediumStates=false;
      InputAbsolutePressure p(start = 1e6);
      InputSpecificEnthalpy h(start = 4e5);
      InputMassFraction Xi[nXi];
      Real T;
      Real d;
      Real u;
      connector InputAbsolutePressure = input Real;
      connector InputSpecificEnthalpy = input Real;
      connector InputMassFraction = input Real;
    end BaseProperties;
  end BaseMedium;

  package OtherMedium
    extends BaseMedium(nXi = 0);
  end OtherMedium;

  model SimpleAir 
    "Medium model of simple air. Independent variables: p,T"
    extends OtherMedium.BaseProperties(
       p(stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default),
       T(stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default));

    constant Real R = 287;
    constant Real cp = 1005.45;
    constant Real T0 = 298.15;
  equation
    d = p / (R*T);
    u = h - R*T;
    T = T0 + h/cp;
  end SimpleAir;

  extends SimpleAir;
  
  annotation (
    __ModelicaAssociation(TestCase(shouldPass = true, section = {"4.7"})),
    experiment(StopTime = 0.01),
    Documentation(info = "<html>Checks that a balanced model works fine.</html>"));
end CorrectBalance3;
