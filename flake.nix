{
  description = "A collection of flake templates";

  outputs = { self }: {

    templates = {

      trivial = {
        path = ./trivial;
        description = "A very basic flake";
      };

      simpleContainer = {
        path = ./simple-container;
        description = "A NixOS container running apache-httpd";
      };

      bash-hello = {
        path = ./bash-hello;
        description = "An over-engineered Hello World in bash";
      };

      c-hello = {
        path = ./c-hello;
        description = "An over-engineered Hello World in C";
      };

      rust-web-server = {
        path = ./rust-web-server;
        description = "A Rust web server including a NixOS module";
      };

      scala3 = {
        path = ./scala3;
        description = "Scala3 with devshells";
      };

      compat = {
        path = ./compat;
        description = "A default.nix and shell.nix for backward compatibility with Nix installations that don't support flakes";
      };

    };

    defaultTemplate = self.templates.trivial;

  };
}
