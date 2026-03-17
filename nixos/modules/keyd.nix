{pkgs, lib, ...}: {
  services.keyd = {
    enable = true;
    keyboards.internal = {
      ids = ["0001:0001:3c78431b"];
      settings = {
        main = {
          a = "noop"; b = "noop"; c = "noop"; d = "noop"; e = "noop"; f = "noop"; g = "noop"; h = "noop"; i = "noop"; j = "noop"; k = "noop"; l = "noop"; m = "noop"; n = "noop"; o = "noop"; p = "noop"; q = "noop"; r = "noop"; s = "noop"; t = "noop"; u = "noop"; v = "noop"; w = "noop"; x = "noop"; y = "noop"; z = "noop";
          "1" = "noop"; "2" = "noop"; "3" = "noop"; "4" = "noop"; "5" = "noop"; "6" = "noop"; "7" = "noop"; "8" = "noop"; "9" = "noop"; "0" = "noop";
          f1 = "noop"; f2 = "noop"; f3 = "noop"; f4 = "noop"; f5 = "noop"; f6 = "noop"; f7 = "noop"; f8 = "noop"; f9 = "noop"; f10 = "noop"; f11 = "noop"; f12 = "noop";
          esc = "noop"; tab = "noop"; capslock = "noop"; leftshift = "noop"; rightshift = "noop"; leftcontrol = "noop"; rightcontrol = "noop"; leftalt = "noop"; rightalt = "noop"; leftmeta = "noop"; rightmeta = "noop";
          space = "noop"; enter = "noop"; backspace = "noop";
          insert = "noop"; delete = "noop"; home = "noop"; end = "noop"; pageup = "noop"; pagedown = "noop";
          up = "noop"; down = "noop"; left = "noop"; right = "noop";
          "`" = "noop"; "-" = "noop"; "=" = "noop"; "[" = "noop"; "]" = "noop"; "\\" = "noop"; ";" = "noop"; "'" = "noop"; "," = "noop"; "." = "noop"; "/" = "noop";
          ro = "noop"; kpjpcomma = "noop"; yen = "noop";
        };
      };
    };
    keyboards.external = {
      ids = ["1a2c:0b2a:c4da6b8e"];
      settings = {
        main = {
          numlock = "f11";
          pause = "f12";
        };
      };
    };
  };
}
