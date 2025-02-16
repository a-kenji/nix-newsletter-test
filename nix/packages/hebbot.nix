{
  inputs,
  lib,
  stdenv,
  rustPlatform,
  pkg-config,
  cmake,
  openssl,
  autoconf,
  automake,
  darwin,
  sqlite,
}:

rustPlatform.buildRustPackage rec {
  pname = "hebbot";
  version = "2.1-unstable-2024-09-20";

  src = inputs.hebbot;

  cargoLock.lockFile = src + /Cargo.lock;

  useFetchCargoVendor = true;

  nativeBuildInputs =
    [
      pkg-config
      cmake
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      autoconf
      automake
    ];

  buildInputs =
    [
      openssl
    ]
    ++ lib.optional stdenv.hostPlatform.isDarwin [
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.SystemConfiguration
    ];

  env = {
    OPENSSL_NO_VENDOR = 1;
  };

  NIX_CFLAGS_LINK = [
    "-L${lib.getLib openssl}/lib"
    "-L${lib.getLib sqlite}/lib"
  ];

  meta = {
    description = "Matrix bot which can generate \"This Week in X\" like blog posts ";
    homepage = "https://github.com/haecker-felix/hebbot";
    changelog = "https://github.com/haecker-felix/hebbot/releases/tag/v${version}";
    license = with lib.licenses; [ agpl3Only ];
    mainProgram = "hebbot";
    maintainers = with lib.maintainers; [ a-kenji ];
  };
}
