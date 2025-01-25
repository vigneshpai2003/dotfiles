{ lib, packages, config, ... }:
{
  services.fprintd.enable = true;

  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  security.pam.services = {
    login.fprintAuth = false;
    gdm-fingerprint = lib.mkIf (config.services.fprintd.enable) {
      text = ''
        auth       required                    pam_shells.so
        auth       requisite                   pam_nologin.so
        auth       requisite                   pam_faillock.so      preauth
        auth       required                    ${packages.fprintd}/lib/security/pam_fprintd.so
        auth       optional                    pam_permit.so
        auth       required                    pam_env.so
        auth       [success=ok default=1]      ${packages.gdm}/lib/security/pam_gdm.so
        auth       optional                    ${packages.gnome-keyring}/lib/security/pam_gnome_keyring.so

        account    include                     login

        password   required                    pam_deny.so

        session    include                     login
        session    optional                    ${packages.gnome-keyring}/lib/security/pam_gnome_keyring.so auto_start
      '';
    };
  };
}
