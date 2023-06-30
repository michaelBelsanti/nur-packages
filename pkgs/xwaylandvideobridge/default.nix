{
  lib,
  stdenv,
  fetchFromGitLab,
  wrapQtAppsHook,
  pkg-config,
  cmake,
  extra-cmake-modules,
  kpipewire,
  qtx11extras,
  ki18n,
  kwidgetsaddons,
  knotifications,
  kcoreaddons,
}: let
  xwvb-kpipewire = kpipewire.overrideAttrs (_: _: {
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "plasma";
      repo = "kpipewire";
      rev = "refs/merge-requests/27/head";
      hash = "sha256-KhmhlH7gaFGrvPaB3voQ57CKutnw5DlLOz7gy/3Mzms=";
    };
  });
in
  stdenv.mkDerivation {
    name = "xwaylandvideobridge";
    version = "unstable";

    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "davidedmundson";
      repo = "xwaylandvideobridge";
      rev = "b876b5f3ee5cc810c99b08e8f0ebb29553e45e47";
      hash = "sha256-gfQkOIZegxdFQ9IV2Qp/lLRtfI5/g6bDD3XRBdLh4q0=";
    };

    nativeBuildInputs = [wrapQtAppsHook pkg-config cmake extra-cmake-modules];
    buildInputs = [xwvb-kpipewire qtx11extras ki18n kwidgetsaddons knotifications kcoreaddons];

    meta = with lib; {
      description = "A tool to make it easy to stream wayland windows and screens to Xwayland applicatons that don't have native pipewire support.";
      homepage = "https://invent.kde.org/davidedmundson/xwaylandvideobridge";
      license = licenses.gpl2Plus;
      maintainers = with maintainers; [michaelBelsanti];
    };
  }
