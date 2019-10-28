
cd ~
git clone https://github.com/jarleven/Salmon.git

cd ~
mkdir LaksenLive
mount 192.168.1.236:/home/jarleven/laksenArcive/Live ~/LaksenLive

cd ~
mkdir EdgeTPU_Models
cd EdgeTPU_Models
wget https://dl.google.com/coral/canned_models/imagenet_labels.txt
wget https://dl.google.com/coral/canned_models/inception_v1_224_quant_edgetpu.tflite

cd ~/Salmon/EdgeTPU
python3 classify_folder.py --model ~/EdgeTPU_Models/inception_v1_224_quant_edgetpu.tflite --labels ~/EdgeTPU_Models/imagenet_labels.txt --folder ~/LaksenLive/AutoForeground/AutoForegroundSeptember/



Salmon/EdgeTPU/edgetpu_process.sh /home/jarleven/laksenArcive/Live/AutoForeground/AutoForegroundSeptember/

Salmon/EdgeTPU/edgetpu_process.sh /home/jarleven/laksenArcive/Live/AutoForeground/AutoForegroundSeptember/
