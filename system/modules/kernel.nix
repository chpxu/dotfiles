{
  pkgs,
  lib,
  ...
}: {
  xanmod = {
    fetchFromGitHub,
    buildLinux,
    ...
  } @ args:
    buildLinux (args
      // rec {
        version = "6.0.2";
        modDirVersion = "6.0.2-x64v2-rt11-xanmod1";
        # modDirVersion = version;
        src = fetchFromGitHub {
          owner = "xanmod";
          repo = "linux";
          rev = modDirVersion;
          sha256 = "";
        };
        kernelPatches = [];
        structuredExtraConfig = with lib.kernel; {
          X86_PSTATE_DRIVER = yes;
          TCP_CONG_BBR2 = yes;
          DEFAULT_BBR2 = yes;
          NET_SCH_DEFAULT = yes;
          DEFAULT_FQ_PIE = yes;
          FUTEX = yes;
          FUTEX_PI = yes;
          WINESYNC = module;
          PREEMPT_RT = yes;
          PREEMPT_RT_FULL = yes;
          DEBUG_OBJECTS = no;
          DEBUG_PREEMPT = no;
        };
        extraMeta.branch = "6.0";
      }
      // (args.argsOverride or {}));
}
