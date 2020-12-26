#!/bin/bash

# Create a sink that will act as a virtual microphone:
pactl load-module module-null-sink sink_name=mix-for-virtual-mic sink_properties=device.description=Mix-for-Virtual-Microphone

# get name of output sink for system sounds
SystemSink=$(pactl info | sed -n '/alsa_output/{s/.*: //p}')
# merge add system sounds to virtual microphone
pactl load-module module-combine-sink sink_name=virtual-microphone-and-speakers slaves=mix-for-virtual-mic,$SystemSink

# get name of microphone
MicSource=$(pactl info | sed -n '/alsa_input/{s/.*: //p}')
# loop microphone back into combined virtual microphone
pactl load-module module-loopback source=$MicSource sink=mix-for-virtual-mic latency_msec=20
