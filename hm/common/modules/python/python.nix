{
  config,
  pkgs,
  ...
}: {
  # Apparently pylint can be managed through HM so let's try
  programs.pylint = {
    enable = true;
    package = pkgs.pylint;
    settings = {
      "[MASTER]" = {
        "profile" = "no";
        "ignore" = "CVS";
        "persistent" = "yes";
        "load-plugins" = null;
        "jobs" = 1;
        "unsafe-load-any-extension" = "no";
        "extension-pkg-whitelist" = "numpy";
      };
      "[MESSAGES CONTROL]" = {
        "confidence" = "";
        "disable" = "E0611";
      };
      "[REPORTS]" = {
        "output-format" = "text";
        "files-output" = "no";
        "reports" = "yes";
        "evaluation" = "10.0 - ((float(5 * error + warning + refactor + convention) / statement) * 10)";
        "comment" = "no";
      };
      "[BASIC]" = {
        "required-attributes" = null;
        "bad-functions" = "map,filter,input";
        "good-names" = "g,R,C,A,v,n,x,i,j,k,m,y,z,l,r,s,t,f,ex,Run,_";
        "bad-names" = "foo,bar,baz,toto,tutu,tata";
        "name-group" = null;
        "include-naming-hint" = "yes";
        "function-rgx" = "[A-Za-z_][A-Za-z0-9_]{1,30}$";
        "function-name-hint" = "[A-Za-z_][A-Za-z0-9_]{1,30}$";
        "variable-rgx" = "[A-Za-z_][A-Za-z0-9_]{1,30}$";
        "variable-name-hint" = "[A-Za-z_][A-Za-z0-9_]{1,30}$";
        "const-rgx" = "(([A-Za-z_][A-Za-z0-9_]*)|(__.*__))$";
        "const-name-hint" = "(([A-Za-z_][A-Za-z0-9_]*)|(__.*__))$";
        "attr-rgx" = "[A-Za-z_][A-Za-z0-9_]{1,30}$";
        "attr-name-hint" = "[A-Za-z_][A-Za-z0-9_]{1,30}$";
        "argument-rgx" = "[A-Za-z_][A-Za-z0-9_]{1,30}$";
        "argument-name-hint" = "[A-Za-z_][A-Za-z0-9_]{1,30}$";
        "class-attribute-rgx" = "([A-Za-z_][A-Za-z0-9_]{1,30}|(__.*__))$";
        "class-attribute-name-hint" = "([A-Za-z_][A-Za-z0-9_]{1,30}|(__.*__))$";
        "inlinevar-rgx" = "[A-Za-z_][A-Za-z0-9_]*$";
        "inlinevar-name-hint" = "[A-Za-z_][A-Za-z0-9_]*$";
        "class-rgx" = "[A-Za-z_][a-zA-Z0-9]+$";
        "class-name-hint" = "[A-Za-z_][a-zA-Z0-9]+$";
        "module-rgx" = "(([A-Za-z_][A-Za-z0-9_]*)|([A-Z][a-zA-Z0-9]+))$";
        "module-name-hint" = "(([A-Za-z_][A-Za-z0-9_]*)|([A-Z][a-zA-Z0-9]+))$";
        "method-rgx" = "[A-Za-z_][A-Za-z0-9_]{1,30}$";
        "method-name-hint" = "[A-Za-z_][A-Za-z0-9_]{1,30}$";
        "no-docstring-rgx" = "__.*__";
        "docstring-min-length" = -1;
      };

      "[FORMAT]" = {
        "max-line-length" = 100;
        "ignore-long-lines" = "^\s*(# )?<?https?://\S+>?$";
        "single-line-if-stmt" = "no";
        "no-space-check" = "trailing-comma,dict-separator";
        "max-module-lines" = 1000;
        "indent-string" = "'    '";
        "indent-after-paren" = 2;
        "expected-line-ending-format" = "";
      };
      "[LOGGING]" = {
        "logging-modules" = "logging";
      };
      "[MISCELLANEOUS]" = {
        "notes" = "FIXME,XXX,TODO";
      };
      "[SIILARITIES]" = {
        "min-similarity-lines" = 4;
        "ignore-comments" = true;
        "ignore-docstrings" = true;
        "ignore-imports" = false;
      };
      "[SPELLING]" = {
        "spelling-dict" = "";
        "spelling-ignore-words" = "";
        "spelling-private-dict-file" = "";
        "spelling-store-unknown-words" = false;
      };
      "[TYPECHECK]" = {
        "ignore-mixin-members" = true;
        "ignored-modules" = "ROOT,numpy,scipy,scipy.integrate,scipy.misc,numpy*";
        "ignored-classes" = "SQLObject,ROOT,numpy,scipy,scipy.integrate,scipy.misc,numpy*";
        "zope" = false;
        "generated-members" = "REQUEST,acl_users,aq_parent,scipy,scipy.integrate,scipy.misc,numpy*";
      };
      "[VARIABLES]" = {
        "init-import" = false;
        "dummy-variables-rgx" = "_$|dummy";
        "additional-builtins" = null;
        "callbacks" = "cb_,_cb";
      };

      "[CLASSES]" = {
        "ignore-iface-methods" = "isImplementedBy,deferred,extends,names,namesAndDescriptions,queryDescriptionFor,getBases,getDescriptionFor,getDoc,getName,getTaggedValue,getTaggedValueTags,isEqualOrExtendedBy,setTaggedValue,isImplementedByInstancesOf,adaptWith,is_implemented_by";
        "defining-attr-methods" = "__init__,__new__,setUp";
        "valid-classmethod-first-arg" = "cls";
        "valid-metaclass-classmethod-first-arg" = "mcs";
        "exclude-protected" = "_asdict,_fields,_replace,_source,_make";
      };
      "[DESIGN]" = {
        "max-args" = 10;
        "ignored-argument-names" = "_.*";
        "max-locals" = 25;
        "max-returns" = 10;
        "max-branches" = 12;
        "max-statements" = 50;
        "max-parents" = 7;
        "max-attributes" = 7;
        "min-public-methods" = 2;
        "max-public-methods" = 20;
      };

      "[IMPORTS]" = {
        "deprecated-modules" = "regsub,TERMIOS,Bastion,rexec";
        "import-graph" = null;
        "ext-import-graph" = null;
        "int-import-graph" = null;
      };
      "[EXCEPTIONS]" = {
        "overgeneral-exceptions" = "Exception";
      };
    };
  };
  programs.matplotlib = {
    enable = true;
  };
}
