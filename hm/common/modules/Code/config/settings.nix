{pkgs}: let
  editorDefaultFormatter = "esbenp.prettier-vscode";
  pythonEnv = import ../../../packages/python/definePythonEnv.nix;
  customPythonEnv = pkgs.python310.withPackages pythonEnv.my-python-pkgs;
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
    "latex-workshop.latex.autoBuild.run" = "never";
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
    "editor.guides.bracketPairs" = true;
    "editor.fontFamily" = "'FiraCode Nerd Font','Source Code Pro', 'monospace', monospace";
    "editor.fontLigatures" = true;
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
    "editor.tabSize" = 4;
    "security.workspace.trust.untrustedFiles" = "open";
    "redhat.telemetry.enabled" = false;
    "telemetry.telemetryLevel" = "off";
    "code-runner.enableAppInsights" = false;
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
    "[python]" = {
      "editor.defaultFormatter" = "black";
    };
    "[latex]" = {
      "editor.defaultFormatter" = "James-Yu.latex-workshop";
    };
    "editor.defaultFormatter" = "";
    # ESLint
    "eslint.enable" = false;
    "eslint.runtime" = "node";
    "eslint.lintTask.enable" = true;
    # "eslint.format.enable" = true;
    # Python time!
    "python.languageServer" = "Pylance";
    "python.linting.pylintEnabled" = true;
    "python.diagnostics.sourceMapsEnabled" = true;
    "python.globalModuleInstallation" = true;
    ## Configure Pylance
    "python.analysis.typeCheckingMode" = "off";
    "python.analysis.completeFunctionParens" = true;
    "python.analysis.autoImportCompletions" = true;
    "python.analysis.packageIndexDepths" = [
      {
        "name" = "matplotlib";
        "depth" = 5;
        "includeAllSymbols" = true;
      }
      {
        "name" = "scipy";
        "depth" = 5;
        "includeAllSymbols" = true;
      }
      {
        "name" = "numpy";
        "depth" = 5;
        "includeAllSymbols" = true;
      }
    ];
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
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nil";
    "ltex.ltex-ls.path" = "${pkgs.ltex-ls}";
    "python.defaultInterpreterPath" = "${customPythonEnv}/bin/python";
    "python.pipenvPath" = "${pkgs.pipenv}/bin/pipenv";
    "python.linting.mypyEnabled" = true;
    "python.linting.mypyPath" = "${pkgs.python310Packages.mypy}/bin/mypy";
    "python.linting.mypyArgs" = [
      "--follow-imports=silent"
      #"--ignore-missing-imports",
      "--show-column-numbers"
      "--no-pretty"
    ];
    "python.linting.pylintPath" = "${pkgs.pylint}/bin/pylint";
    "python.autoComplete.extraPaths" = [
      "${customPythonEnv}/lib/python3.10/site-packages"
      "${customPythonEnv}/lib/python3.10/site-packages/matplotlib/"
      "${customPythonEnv}/lib/python3.10/site-packages/numpy/"
      "${customPythonEnv}/lib/python3.10/site-packages/scipy/"
    ];
    "python.analysis.extraPaths" = [
      "${customPythonEnv}/lib/python3.10/site-packages"
      "${customPythonEnv}/lib/python3.10/site-packages/matplotlib/"
      "${customPythonEnv}/lib/python3.10/site-packages/numpy/"
      "${customPythonEnv}/lib/python3.10/site-packages/scipy/"
    ];
    "pylint.args" = ["--rcfile" "./.pylintrc"];
    "python.formatting.provider" = "black";
    "python.formatting.blackPath" = "${pkgs.black}/bin/black";
    "pylint.interpreter" = [
      "${customPythonEnv}/bin/python"
    ];
  };
}
