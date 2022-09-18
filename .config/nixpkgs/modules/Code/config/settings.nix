let
  editorDefaultFormatter = "esbenp.prettier-vscode";
in {
  settings = {
    "window.titleBarStyle" = "custom";
    "latex-workshop.latex.recipes" = [
      {
        "name" = "lualatex ➞ biber ➞ lualatex × 2";
        "tools" = ["lualatex"];
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
          "-output-format=pdf"
          "-output-directory=%OUTDIR%"
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
      "code --reuse-window -g \"%{input}:%{line}\""
      "%PDF%"
    ];
    "latex-workshop.view.pdf.external.synctex.command" = "zathura";
    "latex-workshop.view.pdf.external.synctex.args" = [
      "--synctex-forward=%LINE:0:%TEX%"
      "%PDF%"
    ];
    "latex-workshop.latex.rootFile.doNotPrompt" = true;
    "latex-workshop.latex.autoBuild.run" = "never";
    "latex-workshop.intellisense.citation.backend" = "biblatex";
    "editor.guides.bracketPairs" = true;
    "editor.fontFamily" = "'FiraCode Nerd Font','Source Code Pro', 'monospace', monospace";
    "editor.fontLigatures" = true;
    "editor.cursorSmoothCaretAnimation" = true;
    "editor.smoothScrolling" = true;
    "editor.cursorBlinking" = "smooth";
    "editor.lineHeight" = 22;
    "editor.wordWrap" = "wordWrapColumn";
    "editor.wordWrapColumn" = 120;
    "editor.tabSize" = 2;
    "security.workspace.trust.untrustedFiles" = "open";
    "redhat.telemetry.enabled" = false;
    "telemetry.telemetryLevel" = "off";
    "code-runner.enableAppInsights" = false;
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
    "workbench.colorTheme" = "Nord";
    "window.title" = "\${dirty}\${activeEditorShort}\${separator}\${rootName}\${separator}";
    "window.titleSeparator" = " - ";
    "explorer.fileNesting.enabled" = true;
    "git.confirmSync" = false;

    # Formatters
    "[html]" = {
      "editor.defaultFormatter" = editorDefaultFormatter;
    };
    "[css]" = {
      "editor.defaultFormatter" = editorDefaultFormatter;
    };
    "[javascript]" = {
      "editor.defaultFormatter" = editorDefaultFormatter;
    };
    "[typescript]" = {
      "editor.defaultFormatter" = editorDefaultFormatter;
    };
    "[nix]" = {
      "editor.defaultFormatter" = "kamadorueda.alejandra";
    };
    "[python]" = {
      "editor.defaultFormatter" = "ms-python.python";
    };
    "editor.defaultFormatter" = editorDefaultFormatter;
    # ESLint
    "eslint.enable" = true;
    "eslint.runtime" = "node";
    "eslint.lintTask.enable" = true;
    # "eslint.format.enable" = true;
    # Python time!
    "python.languageServer" = "Pylance";
    "python.linting.pylintEnabled" = true;
    ## Configure Pylance
    "python.analysis.typeCheckingMode" = "strict";
    "python.analysis.completeFunctionParens" = true;
  };
}
