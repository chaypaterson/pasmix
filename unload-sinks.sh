#!/bin/bash

# destroy loaded sinks

pactl unload-module module-combine-sink
pactl unload-module module-null-sink   
pactl unload-module module-loopback
pactl unload-module module-pipe-source
pactl unload-module module-remap-source
