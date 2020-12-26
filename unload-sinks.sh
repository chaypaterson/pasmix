#!/bin/bash

# destroy loaded sinks

pactl unload-module module-combine-sink
pactl unload-module module-null-sink   
pactl unload-module module-loopback
