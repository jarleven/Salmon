#!/bin/bash

mkdir ~/EdgeTPU_Models
cd ~/EdgeTPU_Models


wget https://dl.google.com/coral/canned_models/mobilenet_v2_1.0_224_inat_bird_quant_edgetpu.tflite \
https://dl.google.com/coral/canned_models/inat_bird_labels.txt \
https://coral.withgoogle.com/static/docs/images/parrot.jpg

exit


cd ~/

wget https://dl.google.com/coral/edgetpu_api/edgetpu_api_latest.tar.gz -O edgetpu_api.tar.gz --trust-server-names

tar xzf edgetpu_api.tar.gz

cd edgetpu_api

bash ./install.sh



