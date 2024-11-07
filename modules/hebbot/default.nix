{
  config,
  lib,
  ...
}:
{
  imports = [
    ./vars.nix
    ./state.nix
  ];

  services.hebbot = {
    enable = true;
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
      sections = [ ];
      projects = [ ];
    };

    templates = {
      section = ./templates/section.md;
      project = ./templates/project.md;
      report = ./templates/report.md;
    };
  };

  systemd.services.hebbot.serviceConfig = {
    WorkingDirectory = lib.mkForce "/var/lib/hebbot";
  };
}
