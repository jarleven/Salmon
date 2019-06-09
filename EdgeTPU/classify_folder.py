
#

# https://github.com/google-coral/examples-camera/blob/master/gstreamer/detect.py
# https://coral.googlesource.com/edgetpu/+/refs/heads/release-chef/edgetpu/demo/classify_capture.py
# https://github.com/tensorflow/models/blob/master/tutorials/image/imagenet/classify_image.py

#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""A demo which runs object classification on a folder containing cropped jpg files."""
import argparse
import time
import re
import imp
import os
from edgetpu.classification.engine import ClassificationEngine
from PIL import Image

# mkdir EdgeTPU_Mode
# cd EdgeTPU_Models/
# wget https://dl.google.com/coral/canned_models/all_models.tar.gz
# tar xvzf all_models.tar.gz 


# python3 classify_folder.py --model ./EdgeTPU_Models/inception_v1_224_quant_edgetpu.tflite --labels ./EdgeTPU_Models/imagenet_labels.txt --folder ~/foreground/cropped/




def load_labels(path):
    p = re.compile(r'\s*(\d+)(.+)')
    with open(path, 'r', encoding='utf-8') as f:
       lines = (p.match(line).groups() for line in f.readlines())
       return {int(num): text.strip() for num, text in lines}

def main():
    default_model_dir = "./EdgeTPU_Models/"
    default_model = 'mobilenet_v2_1.0_224_quant_edgetpu.tflite'
    default_labels = 'imagenet_labels.txt'
    parser = argparse.ArgumentParser()
    parser.add_argument('--model', help='.tflite model path',
                        default=os.path.join(default_model_dir,default_model))
    parser.add_argument('--labels', help='label file path',
                        default=os.path.join(default_model_dir, default_labels))
    parser.add_argument('--top_k', type=int, default=3,
                        help='number of classes with highest score to display')
    parser.add_argument('--threshold', type=float, default=0.1,
                        help='class score threshold')
    parser.add_argument('--folder', help='Search folder path')

    args = parser.parse_args()

    print("Loading %s with %s labels."%(args.model, args.labels))
    print("Running classification in [%s]."%(args.folder))
    engine = ClassificationEngine(args.model)
    labels = load_labels(args.labels)

    last_time = time.monotonic()
 


    for filename in os.listdir(args.folder):
        if filename.endswith(".jpg"):
            print(os.path.join(args.folder, filename))
 
            start_time = time.monotonic()
            img = Image.open(os.path.join(args.folder, filename))
            results = engine.ClassifyWithImage(img, threshold=args.threshold, top_k=args.top_k)
            end_time = time.monotonic()
            text_lines = [
                  'Inference: %.2f ms' %((end_time - start_time) * 1000),
                  'FPS: %.2f fps' %(1.0/(end_time - last_time)),
            ]
            for index, score in results:
              text_lines.append('score=%.2f: %s' % (score, labels[index]))
            print(' '.join(text_lines))
            last_time = end_time
        else:
            continue


if __name__ == '__main__':
    main()

