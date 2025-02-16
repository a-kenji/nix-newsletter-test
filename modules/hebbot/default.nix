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

  services.hebbot = {
    enable = true;
    # package = inputs.self.packages.${pkgs.system}.hebbot;
    botPasswordFile = config.clan.core.vars.generators.this-week-in-nix.files.password.path;
    settings = {
      bot_user_id = config.clan.core.vars.generators.this-week-in-nix.files.username.value;
      reporting_room_id = "!BJHtvOvAduXHBtFrAA:matrix.org";
      admin_room_id = "!QAPnvBhMyaqqOTESwS:matrix.org";
      update_config_command = "echo 'clan machines update'";
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
          order = 40;
          inherit usual_reporters;
        }
        {
          emoji = "📦";
          name = "nixpkgs";
          title = "nixpkgs";
          description = "";
          order = 50;
          inherit usual_reporters;
        }
        {
          emoji = "⚖️";
          name = "rfcs";
          title = "rfcs";
          description = "The Nix community RFCs";
          website = "https://github.com/NixOS/rfcs";
          order = 100;
          inherit usual_reporters;
        }
        {
          emoji = "🏘";
          name = "nix-community";
          title = "nix-community";
          description = "Nix community projects";
          order = 100;
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
}
