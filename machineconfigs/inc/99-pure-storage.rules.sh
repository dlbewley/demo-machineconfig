# https://raw.githubusercontent.com/cjkennedy1972/px-ocp-mco-multipath/refs/heads/master/px-ocp-mco-multipathd.yaml
#ACTION=="change", SUBSYSTEM=="scsi", ENV{SDEV_UA}=="INQUIRY_DATA_HAS_CHANGED", TEST=="rescan", ATTR{rescan}="x"
ACTION=="change", SUBSYSTEM=="scsi", ENV{SDEV_UA}=="CAPACITY_DATA_HAS_CHANGED", TEST=="rescan", ATTR{rescan}="x"
#ACTION=="change", SUBSYSTEM=="scsi", ENV{SDEV_UA}=="THIN_PROVISIONING_SOFT_THRESHOLD_REACHED", TEST=="rescan", ATTR{rescan}="x"
#ACTION=="change", SUBSYSTEM=="scsi", ENV{SDEV_UA}=="MODE_PARAMETERS_CHANGED", TEST=="rescan", ATTR{rescan}="x"
ACTION=="change", SUBSYSTEM=="scsi", ENV{SDEV_UA}=="REPORTED_LUNS_DATA_HAS_CHANGED", RUN+="scan-scsi-target $env{DEVPATH}"