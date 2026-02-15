{pkgs, lib, ...}: let
  # Helper function to set all keys to noop
  allNoop = keys: lib.foldl (acc: key: acc // {${key} = "noop";}) {} keys;

  # Key groups
  letters = lib.stringToCharacters "abcdefghijklmnopqrstuvwxyz";
  numbers = map toString (lib.range 0 9);
  fKeys = map (n: "f${toString n}") (lib.range 1 12);
  modifierKeys = ["esc" "tab" "capslock" "leftshift" "rightshift" "leftcontrol" "rightcontrol" "leftalt" "rightalt" "leftmeta" "rightmeta"];
  navKeys = ["space" "enter" "backspace" "insert" "delete" "home" "end" "pageup" "pagedown"];
  arrowKeys = ["up" "down" "left" "right"];
  symbolKeys = ["`" "-" "=" "[" "]" "\\" ";" "'" "," "." "/" "ro" "kpjpcomma" "yen"];

  mainLayerKeys = letters ++ numbers ++ fKeys ++ modifierKeys ++ navKeys ++ arrowKeys ++ symbolKeys;
in {
  services.keyd = {
    enable = true;
    keyboards = {
      internal = {
        ids = ["0001:0001:d651c513"];
        settings = {
          main = allNoop mainLayerKeys;
        };
      };
      external = {
        ids = ["1a2c:0b2a:c4da6b8e"];
        settings = {
          main = {
            numlock = "f11";
            pause = "f12";
          };
        };
      };
    };
  };
}
