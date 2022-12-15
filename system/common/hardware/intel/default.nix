{
  hardware.cpu = {
    intel = {
      updateMicrocode = true;
      # sgx.provision.enable = true;
    };
  };
  powerManagement.cpuFreqGovernor = "powersave";
  powerManagement.cpufreq.min = 300000;
}
