{...}: {
  flake.nixosModules.core-locale = {
    config,
    lib,
    ...
  }: {
    options.mySystem.core.locale.enable = lib.mkEnableOption "Core Locale & Time";
    config = lib.mkIf config.mySystem.core.locale.enable {
      time.timeZone = "Africa/Nairobi";
      i18n.defaultLocale = "en_US.UTF-8";
    };
  };
}
