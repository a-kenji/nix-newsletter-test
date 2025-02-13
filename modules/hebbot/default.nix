{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  usual_reporters = [
    "@a-kenji:matrix.org"
  ];
in
{
  imports = [
    ./vars.nix
    ./state.nix
  ];

  services.hebbot =
    let
      publish_command = pkgs.writeScriptBin "publish_command" ''
        #! ${pkgs.stdenv.shell}
        paste () {
          ${lib.getExe pkgs.jq} -Rns '{text: inputs}' | ${lib.getExe pkgs.curl} -s -H 'Content-Type: application/json' --data-binary @- https://paste.0cx.de | ${lib.getExe pkgs.jq} -r '. | "https://paste.0cx.de\(.path)"'
        }
        cat - | paste
      '';
    in
    {
      enable = true;
      package = inputs.self.packages.${pkgs.system}.hebbot;
      botPasswordFile = config.clan.core.vars.generators.this-week-in-nix.files.password.path;
      settings = {
        bot_user_id = config.clan.core.vars.generators.this-week-in-nix.files.username.value;
        reporting_room_id = "!BJHtvOvAduXHBtFrAA:matrix.org";
        admin_room_id = "!QAPnvBhMyaqqOTESwS:matrix.org";
        update_config_command = "echo 'clan machines update'";
        publish_command = lib.getExe publish_command;
        min_length = 0;
        verbs = [
          "reports"
          "says"
          "announces"
        ];
        notice_emoji = "⭕";
        restrict_notice = true;
        image_markdown = "> ![]({{file}})";
        video_markdown = "> {{< video src=\"{{file}}\" >}}";
        ack_text = "✅ Thanks for the report {{user}}, I'll store your update for TWIN Feel free to edit your message if necessary, the changes will be recognized.";
        editors = [
          "@a-kenji:matrix.org"
        ];
        #TODO: These are user facing, have them in a toplevel directory structure
        sections = [
          {
            emoji = "💻";
            name = "nixos";
            title = "nixos";
            description = "";
            order = 500;
            inherit usual_reporters;
          }
          {
            emoji = "📦";
            name = "nixpkgs";
            title = "nixpkgs";
            description = "";
            order = 500;
            inherit usual_reporters;
          }
          {
            emoji = "⚖️";
            name = "rfcs";
            title = "rfcs";
            description = "The Nix community RFCs";
            website = "https://github.com/NixOS/rfcs";
            order = 400;
            inherit usual_reporters;
          }
          {
            emoji = "🏘 nix-community";
            name = "nix-community";
            title = "nix-community";
            description = "Nix community projects";
            order = 300;
            inherit usual_reporters;
          }
          {
            emoji = "🏗";
            name = "external projects";
            title = "external projects";
            description = "External Nix projects";
            order = 100;
            inherit usual_reporters;
          }
          {
            emoji = "📅";
            name = "events";
            title = "events";
            description = "";
            order = 500;
            inherit usual_reporters;
          }
          {
            emoji = "📺";
            name = "media";
            title = "media";
            description = "";
            order = 500;
            inherit usual_reporters;
          }
        ];
        projects = [
          {
            emoji = "❄️";
            name = "Nix";
            title = "The Nix Package Manager";
            description = "";
            website = "";
            default_section = "nixos";
          }
          {
            emoji = "📝";
            name = "documentation team";
            title = "documentation team";
            description = "Nixpkgs Documentation Team";
            website = "";
            default_section = "nixpkgs";
          }
          {
            emoji = "🪩";
            name = "disko";
            title = "disko";
            description = "";
            website = "";
            default_section = "nix-community";
          }
          {
            emoji = "🩺 nixos-healthchecks";
            name = "nixos-healthchecks";
            title = "nixos-healthchecks";
            description = "Write health checks as NixOS options to quickly verify if your services are properly running. ";
            website = "https://github.com/mrVanDalo/nixos-healthchecks";
            default_section = "external projects";
          }
          {
            emoji = "noogle";
            name = "noogle";
            title = "noogle";
            description = "https://noogle.dev - nix function exploring.";
            website = "https://noogle.dev/";
            default_section = "nix-community";
          }
          {
            emoji = "🐛";
            name = "nixos-anywhere";
            title = "nixos-anywhere";
            description = "";
            website = "";
            default_section = "nix-community";
          }
          {
            emoji = "📢";
            name = "conferences";
            title = "conferences";
            description = "Conferences";
            website = "";
            default_section = "events";
          }
          {
            emoji = "👥";
            name = "meetups";
            title = "meetups";
            description = "Meetups";
            website = "";
            default_section = "events";
          }
          {
            emoji = "🎙";
            name = "podcasts";
            title = "podcasts";
            description = "";
            website = "";
            default_section = "media";
          }
          {
            emoji = "📚";
            name = "books";
            title = "books";
            description = "";
            website = "";
            default_section = "media";
          }
        ];
      };

      templates = {
        section = ./templates/section.md;
        project = ./templates/project.md;
        report = ./templates/report.md;
      };
    };

  systemd.services.hebbot.preStart = lib.mkAfter ''
    ln -sf ${./templates/template.md} ./template.md
  '';
}
