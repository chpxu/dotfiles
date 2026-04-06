{
  inputs,
  den,
  ...
}: {
  # Create "my" namespace (not exported to flake outputs)
  # imports = [ (inputs.den.namespace "my" false) ];

  # Or create and export "eg" namespace
  imports = [(inputs.den.namespace "hardware" true)];
}
