{ lib, ... }:
{
  security.pam.services = {
    login = {
      enableKwallet = true;
      rules.session.kwallet.args = lib.mkAfter [ "force_run" ];
    };

    greetd.text = lib.mkForce ''
      auth substack login
      account include login
      password substack login
      session include login
    '';
  };
}
