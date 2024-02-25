#!/bin/bash
#Courtesy of https://askubuntu.com/a/1312918

pactl load-module module-null-sink \
    sink_name=mix-for-virtual-mic \
    sink_properties=device.description=Mix-for-Virtual-Microphone

# get name of microphone
MicSource=$(pactl info | sed -n '/alsa_input/{s/.*: //p}')
# loop microphone back into combined virtual microphone
pactl load-module module-loopback \
    source=$MicSource \
    sink=mix-for-virtual-mic latency_msec=20

pactl load-module module-pipe-source \
   source_name=virtmic \
   file=/tmp/virtmic format=s16le rate=16000 channels=1

pactl load-module module-combine-sink \
   sink_name=virtual-microphone-and-speakers \
   slaves=mix-for-virtual-mic,@DEFAULT_SINK@

pactl load-module module-remap-source \
   master=mix-for-virtual-mic.monitor \
   source_properties=device.description=mixed-mic
