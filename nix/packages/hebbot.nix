# For now vendored from nixpkgs
{
  lib,
  fetchFromGitHub,
  stdenv,
  rustPlatform,
  pkg-config,
  cmake,
  openssl,
  autoconf,
  automake,
  darwin,
  unstableGitUpdater,
  sqlite,
}:

rustPlatform.buildRustPackage rec {
  pname = "hebbot";
  version = "2.1-unstable-2024-09-20";

  src = fetchFromGitHub {
    owner = "a-kenji";
    # owner = "haecker-felix";
    repo = "hebbot";
    rev = "f4f0edfd2960a974467480ba15d6da3400548545";
    # hash = "sha256-y+KpxiEzVAggFoPvTOy0IEmAo2V6mOpM0VzEScUOtsM=";
    hash = "sha256-dxmIsOIDN+i1MSHwuepvuziHPg12JotL3nM+MlTw4sE=";
    # hash = lib.fakeHash;
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-QrGM02rWX+mHQc7kEdCbq7x3Y5Y9IL+XQa4VvejH4KY=";
  # cargoHash = lib.fakeHash;

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

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "Matrix bot which can generate \"This Week in X\" like blog posts ";
    homepage = "https://github.com/haecker-felix/hebbot";
    changelog = "https://github.com/haecker-felix/hebbot/releases/tag/v${version}";
    license = with lib.licenses; [ agpl3Only ];
    mainProgram = "hebbot";
    maintainers = with lib.maintainers; [ a-kenji ];
  };
}
