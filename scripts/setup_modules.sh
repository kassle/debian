#! /bin/sh

## enable HDMI audio
OUTFILE=$1/etc/modprobe.d/hdmi_audio.conf
echo "options snd_intel_dspcfg dsp_driver=1" > $OUTFILE
