{pkgs}: let
  editorDefaultFormatter = "esbenp.prettier-vscode";
in {
  settings = {
    "window.titleBarStyle" = "custom";
    "latex-workshop.latex.recipes" = [
      {
        "name" = "lualatex ➞ biber ➞ lualatex × 2";
        "tools" = ["lualatex" "lualatex"];
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
      "code --no-sandbox --reuse-window -g \"%{input}:%{line}\""
      "%PDF%"
    ];
    "latex-workshop.view.pdf.external.synctex.command" = "zathura";
    "latex-workshop.view.pdf.external.synctex.args" = [
      "--synctex-forward=%LINE:0:%TEX%"
      "%PDF%"
    ];
    "latex-workshop.latex.rootFile.doNotPrompt" = true;
    "latex-workshop.latex.autoBuild.run" = "onSave";
    "latex-workshop.texcount.autorun" = "onSave";
    "latex-workshop.intellisense.citation.backend" = "biblatex";
    "latex-workshop.hover.preview.enabled" = true;
    "latex-workshop.hover.preview.mathjax.extensions" = [
      "amscd"
      "bbox"
      "boldsymbol"
      "braket"
      "cases"
      "colortbl"
      "mathtools"
      "physics"
      "unicode"
      "upgreek"
    ];
    "latex-workshop.linting.chktex.enabled" = true;
    "latex-workshop.linting.chktex.exec.args" = [
      "-wall"
      "-n22"
      "-n21"
      "-n30"
      "-e16"
      "-q"
    ];
    "latex-workshop.linting.lacheck.enabled" = true;
    "editor.defaultFormatter" = null;
    "editor.guides.bracketPairs" = true;
    "editor.fontFamily" = "'FiraCode Nerd Font','Source Code Pro', 'monospace', monospace";
    "editor.fontLigatures" = true;
    "editor.bracketPairColorization.enabled" = false;
    "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
    "editor.formatOnSave" = true;
    "editor.cursorSmoothCaretAnimation" = true;
    "editor.smoothScrolling" = true;
    "editor.cursorBlinking" = "smooth";
    "editor.lineHeight" = 22;
    "editor.minimap.enabled" = false;
    "editor.wordWrap" = "wordWrapColumn";
    "editor.wordWrapColumn" = 120;
    "editor.renderWhitespace" = "all";
    "editor.tabSize" = 2;
    "security.workspace.trust.untrustedFiles" = "open";
    "redhat.telemetry.enabled" = false;
    "telemetry.telemetryLevel" = "off";
    "typescript.suggest.paths" = false;
    "javascript.suggest.paths" = false;
    "workbench.editor.historyBasedLanguageDetection" = false;
    "workbench.settings.enableNaturalLanguageSearch" = false;
    "workbench.enableExperiments" = false;
    "update.showReleaseNotes" = false;
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
    "[latex]" = {
      "editor.defaultFormatter" = "James-Yu.latex-workshop";
    };
    # ESLint
    "eslint.enable" = false;
    "eslint.runtime" = "node";
    "eslint.lintTask.enable" = true;
    "eslint.format.enable" = true;
    # Python time!
    "python.languageServer" = "Pylance";
    "python.diagnostics.sourceMapsEnabled" = true;
    ## Configure Pylance
    "python.analysis.typeCheckingMode" = "off";
    "python.analysis.completeFunctionParens" = true;
    "python.analysis.autoImportCompletions" = true;
    "ltex.enabled" = true;
    "ltex.language" = "en-GB";
    "ltex.dictionary" = {
      "en" = [
        "monic"
        "infimum"
        "supremum"
        "bolzano"
        "weierstrass"
        "euler"
      ];
    };
    "ltex.statusBarItem" = true;
    "ltex.ltex-ls.path" = "${pkgs.ltex-ls}";
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nil";
    "jupyter.disableJupyterAutoStart" = true;
    "python.defaultInterpreterPath" = "python";
    "pylint.interpreter" = [
      "python3"
    ];
    "evenBetterToml.formatter.allowedBlankLines" = 1;
    "evenBetterToml.formatter.arrayAutoExpand" = true;
    "evenBetterToml.formatter.columnWidth" = 80;
    "C_Cpp.autocompleteAddParentheses" = true;
    "C_Cpp.default.cppStandard" = "c++23";
    "C_Cpp.default.cStandard" = "c99";
    "C_Cpp.default.intelliSenseMode" = "linux-gcc-x64";
    "http.experimental.systemCertificatesV2" = true;
    "update.mode" = "none";
  };
}
