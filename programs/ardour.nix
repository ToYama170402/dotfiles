{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ardour
    lsp-plugins
    calf
    rnnoise
  ];

  home.sessionVariables = {
    LV2_PATH = "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2";
    VST3_PATH = "$HOME/.vst3:$HOME/.nix-profile/lib/vst3:/run/current-system/sw/lib/vst3";
    CLAP_PATH = "$HOME/.clap:$HOME/.nix-profile/lib/clap:/run/current-system/sw/lib/clap";
    LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa";
    DSSI_PATH = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi";
  };
}
