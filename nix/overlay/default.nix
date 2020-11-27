self: prev: 
rec
{ openssl = prev.openssl.override { static = true; };
  postgresql = (prev.postgresql.overrideAttrs (oldAttrs: { dontDisableStatic = true; })).override { enableSystemd = false; };
  libpq = postgresql;
}
