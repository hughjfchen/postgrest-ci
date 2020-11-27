self: prev: 
rec
{ openssl = prev.openssl.override { static = true; };
  libssh2 = (prev.libssh2.overrideAttrs (oldAttrs: { dontDisableStatic = true; 
    configureFlags = [ "--disable-examples-build" ]; }));
  postgresql = (prev.postgresql.overrideAttrs (oldAttrs: { dontDisableStatic = true; })).override { enableSystemd = false; };
  libpq = postgresql;
}
