{
  lib,
  stdenv,
  fetchurl,
  vala,
  pkg-config,
  gtk3,
  gnome,
  adwaita-icon-theme,
  gdk-pixbuf,
  librsvg,
  wrapGAppsHook3,
  gettext,
  itstool,
  clutter,
  clutter-gtk,
  libxml2,
  appstream-glib,
  meson,
  ninja,
  python3,
}:

stdenv.mkDerivation rec {
  pname = "lightsoff";
  version = "46.0";

  src = fetchurl {
    url = "mirror://gnome/sources/lightsoff/${lib.versions.major version}/lightsoff-${version}.tar.xz";
    hash = "sha256-ZysVMuBkX64C8oN6ltU57c/Uw7pPcuWR3HP+R567i5I=";
  };

  nativeBuildInputs = [
    vala
    pkg-config
    wrapGAppsHook3
    itstool
    gettext
    appstream-glib
    libxml2
    meson
    ninja
    python3
  ];

  buildInputs = [
    gtk3
    adwaita-icon-theme
    gdk-pixbuf
    librsvg
    clutter
    clutter-gtk
  ];

  postPatch = ''
    chmod +x build-aux/meson_post_install.py
    patchShebangs build-aux/meson_post_install.py
  '';

  passthru = {
    updateScript = gnome.updateScript { packageName = "lightsoff"; };
  };

  meta = with lib; {
    homepage = "https://gitlab.gnome.org/GNOME/lightsoff";
    changelog = "https://gitlab.gnome.org/GNOME/lightsoff/-/blob/${version}/NEWS?ref_type=tags";
    description = "Puzzle game, where the objective is to turn off all of the tiles on the board";
    mainProgram = "lightsoff";
    teams = [ teams.gnome ];
    license = licenses.gpl2;
    platforms = platforms.unix;
  };
}
