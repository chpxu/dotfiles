{ config, pkgs, ...}:
let
  unstable = import <nixpkgs-unstable> { config = { allowUnfree = true; };  };
in
{
  programs.vscode = with unstable; {
    enable = true;
    package = vscode-fhs;
    extensions = with vscode-extensions; [
      bbenoist.nix
      bungcip.better-toml
      james-yu.latex-workshop
      eamodio.gitlens
      esbenp.prettier-vscode
      arcticicestudio.nord-visual-studio-code
      dotjoshjohnson.xml
      formulahendry.auto-rename-tag
      formulahendry.auto-close-tag
      gencer.html-slim-scss-css-class-completion
      #glassit-linux.opacity
    ];
    userSettings = {
      "editor.guides.bracketPairs" =true;
      "window.titleBarStyle" = "custom";
      "latex-workshop.latex.recipes" = [
        {
          "name" = "lualatex ➞ biber ➞ lualatex × 2";
          "tools" = [ "lualatex" "biber" "lualatex" ];
        }
      ]; 
      "latex-workshop.latex.tools" = [
        {
          "name" = "lualatex";
          "command" = "lualatex";
          "args" = [
            "-synctex=1"
            "-interaction=nonstopmode"
            "-file-line-error"
            "-pdf"
            "-outdir=%OUTDIR%"
            "%DOC%"
          ];
        }
        {
          "name" = "biber";
          "command" = "biber";
          "args" = [
            "%DOCFILE%"
          ];
        }
      ];
      "latex-workshop.view.pdf.viewer" = "tab";
      "latex-workshop.view.pdf.external.viewer.command" = "zathura";
      "latex-workshop.view.pdf.external.viewer.args" = [
        "--synctex-editor-command"
        "code-oss --reuse-window -g \"%{input}:%{line}\""
        "%PDF%"
      ];
      "latex-workshop.view.pdf.external.synctex.command" = "zathura";
      "latex-workshop.view.pdf.external.synctex.args" = [
        "--synctex-forward=%LINE:0:%TEX%"
        "%PDF%"
      ];
      "latex-workshop.latex.rootFile.doNotPrompt" = true;
      "latex-workshop.latex.autoBuild.run" = "never";
      "editor.wordWrap" ="wordWrapColumn";
      "security.workspace.trust.untrustedFiles" = "open";
      "editor.fontFamily" = "'FiraCode Nerd Font','Source Code Pro', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "editor.cursorSmoothCaretAnimation" = true;
      "editor.smoothScrolling" = true;
      "editor.cursorBlinking" = "smooth";
      "editor.lineHeight" = 25;
      "telemetry.telemetryLevel" = "off";
      "code-runner.enableAppInsights"= false;
      "workbench.editor.historyBasedLanguageDetection" = false;
      "workbench.settings.enableNaturalLanguageSearch" = false;
      "workbench.enableExperiments" = false;
      "update.showReleaseNotes" = false;
      "editor.renderWhitespace" = "all";
      "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
      "editor.minimap.enabled" = false;
      "files.enableTrash" = false;
      "workbench.list.smoothScrolling" = true;
      "workbench.reduceMotion" = "off";
      "workbench.startupEditor" = "none";
      "workbench.tips.enabled" = false;
      "window.title" = "\${dirty}\${activeEditorShort}\${separator}\${rootName}\${separator}";
      "window.titleSeparator" = " -";
      "explorer.fileNesting.enabled" = true;
      "git.confirmSync" = false;
      "workbench.colorTheme" = "Nord";
      "[html]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "redhat.telemetry.enabled" = false;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "latex-workshop.intellisense.citation.backend" = "biblatex";
      "glassit-linux.opacity" = 50;
    };
  };  
}
