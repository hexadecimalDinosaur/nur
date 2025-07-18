{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  cairo,
  gdk-pixbuf,
  gtk3,
  libz,
  pango,
  harfbuzz,
  atkmm,
  libcxx,
  mpv
}:
let
  version = "0.3.10";
  url_base = "https://github.com/alexmercerind2/harmonoid-releases/releases/download/v${version}";
  url = rec {
    x86_64-linux = "${url_base}/harmonoid-linux-x86_64.tar.gz";
    x86_64-darwin = "${url_base}/harmonoid-macos-universal.dmg";
    aarch64-darwin = x86_64-darwin;
  }.${stdenv.hostPlatform.system} or (
    throw "${stdenv.hostPlatform.system} is an unsupported platform");
  hash = rec {
    x86_64-linux = "sha256-GTF9KrcTolCc1w/WT0flwlBCBitskFPaJuNUdxCW9gs=";
    x86_64-darwin = "sha256-m2Ifm/updeGKPk7ovnSBONd2MOKbXb5aTmZFZf8FFv8=";
    aarch64-darwin = x86_64-darwin;
  }.${stdenv.hostPlatform.system};
in
stdenv.mkDerivation (finalAttrs: {
  pname = "harmonoid";
  inherit version;

  src = fetchurl {
    inherit url hash;
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    cairo
    gdk-pixbuf
    gtk3
    libz
    pango
    harfbuzz
    atkmm
    libcxx
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r bin $out
    mkdir -p $out
    cp -r share $out
    wrapProgram $out/bin/harmonoid --prefix LD_LIBRARY_PATH : $out/share/harmonoid/lib:${lib.makeLibraryPath [mpv]} 

    runHook postInstall
  '';

  meta = {
    description = "Plays & manages your music library. Looks beautiful & juicy.";
    mainProgram = "harmonoid";
    homepage = "https://harmonoid.com/";
    changelog = "https://github.com/harmonoid/harmonoid/releases/tag/v${finalAttrs.version}";
    maintainers = with lib.maintainers; [ ivyfanchiang ];
    platforms = [ "x86_64-linux" ];
    license = rec {
      fullName = "PolyForm Strict License 1.0.0";
      url = "https://polyformproject.org/licenses/strict/1.0.0/";
      free = false;
    };
  };
})
