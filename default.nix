with import <nixpkgs> {};

let
  pico-sdk = pkgs.fetchgit {
    url = "https://github.com/raspberrypi/pico-sdk.git";
    rev = "fc10a97c386f65c1a44c68684fe52a56aaf50df0";
    sha256 = "17c1abv8m94dzi9vipq60znilfcd2shy6v4f9rycgxywcpfgpi9v";
    fetchSubmodules = true;
  };
  picotool = stdenv.mkDerivation {
    name = "picotool";
    version = "0.1";
    isExecutable = true;

    src = fetchFromGitHub {
      owner = "raspberrypi";
      repo = "picotool";
      rev = "252041279916a2a56e4e242e58ab58b4a7963ced";
      sha256 = "1p25hfbpgr2zzp4hpcviz0ayfmh9yaz10vkhhw0ca1xx3ixpgi1n";
    };

    nativeBuildInputs = [
      cmake
      pkg-config
    ];
    buildInputs = [
      libusb
    ];

    PICO_SDK_PATH = "${pico-sdk}/";

    installPhase = ''
      install -m755 -D picotool $out/bin/picotool
    '';
  };
  retry = pkgs.buildGoPackage {
    pname = "retry";
    version = "1.1.0";

    src = fetchFromGitHub {
      owner = "joshdk";
      repo = "retry";
      rev = "v1.1.0";
      sha256 = "0y8lw1b0nl3crqi3iqx8i6zcgl92vspb8qnsnfb3zsz24kgwy0hf";
    };

    goPackagePath = "github.com/joshdk/retry";
  };
  bootterm = stdenv.mkDerivation {
    name = "bootterm";
    version = "0.3";
    isExecutable = true;

    src = fetchFromGitHub {
      owner = "wtarreau";
      repo = "bootterm";
      rev = "v0.3";
      sha256 = "12aixynf39wafrxvnqn2db3zsk4qf4avpz0pdyczkgld4rr3giw2";
    };

    installPhase = ''
      install -m755 -D bin/bt $out/bin/bt
    '';
  };
in stdenv.mkDerivation rec {
  name = "rpi-pico-template";

  nativeBuildInputs = [
    bash
    bootterm
    retry
    cmake
    gcc-arm-embedded
    python3
    doxygen
    graphviz
    picotool
  ];

  PICO_SDK_PATH = "${pico-sdk}/";

  src = ./.;

  buildCommand = ''
    cmake $src
    make

    install -D -m 444 -t "$out" main.*
  '';
}
