{ nativePkgs ? (import ./default.nix {}).pkgs,
crossBuildProject ? import ./cross-build.nix {} }:
nativePkgs.lib.mapAttrs (_: prj:
with prj.postgrest;
let
  executable = postgrest.components.exes.postgrest;
  binOnly = pkgs.runCommand "postgrest-bin" { } ''
    mkdir -p $out/bin
    cp ${executable}/bin/postgrest $out/bin
    ${nativePkgs.nukeReferences}/bin/nuke-refs $out/bin/postgrest
  '';
in pkgs.dockerTools.buildImage {
  name = "postgrest";
  contents = [ binOnly pkgs.cacert pkgs.iana-etc ];
  config.Entrypoint = "postgrest";
}) crossBuildProject
