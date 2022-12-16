{
  pkgs,
  lib,
  rtVer,
  version,
  sha256 ? "",
  ...
}: {
  boot.kernelPackages = let
    inherit rtVer;
    xanmod = {
      fetchFromGitHub,
      buildLinux,
      ...
    } @ args:
      buildLinux (args
        // rec {
          inherit version;
          modDirVersion = "${version}-rt${rtVer}-xanmod1";
          src = fetchFromGitHub {
            owner = "xanmod";
            repo = "linux";
            rev = modDirVersion;
            inherit sha256;
          };
          kernelPatches = [];
          structuredExtraConfig = with lib.kernel; {
            EXPERT = yes;
            RCU_EXPERT = yes;
            # X86_PSTATE_DRIVER = yes;
            TCP_CONG_BBR2 = yes;
            DEFAULT_BBR2 = yes;
            NET_SCH_DEFAULT = yes;
            DEFAULT_FQ_PIE = yes;
            FUTEX = yes;
            FUTEX_PI = yes;
            WINESYNC = module;
            PREEMPT_RT = no;
            # ANDROID = lib.mkForce no;
            # PREEMPT_RT_FULL = yes;
            PREEMPT_VOLUNTARY = yes;
            LRU_GEN = yes;
            LRU_GEN_ENABLED = yes;
            DEBUG_OBJECTS = no;
            DEBUG_PREEMPT = no;
            NO_HZ = yes;
            NO_HZ_FULL = yes;
            # NO_HZ_IDLE = yes;
            HZ = freeform "500";
            HZ_500 = yes;
            HZ_1000 = no;
            # RCU_PERF_TEST = no;
          };
          extraMeta.branch = "6.0";
        }
        // (args.argsOverride or {}));
    xanmodFor = pkgs.callPackage xanmod {};
  in
    pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor xanmodFor);
}
