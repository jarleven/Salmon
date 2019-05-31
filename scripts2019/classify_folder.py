# Python script to ues the Google Edge TPU to classify all JPEG images in a folder.
# The classification data is saved in a log file for processing later.
# The logfile is timestamped to protect it from being overwritten by multiple runs of this script
#
# The code is based on example files provided by Google
# Jarl Even Englund May 2019
#

import argparse
import re
import glob
from edgetpu.classification.engine import ClassificationEngine
from PIL import Image
import time
from datetime import datetime


folder="/home/mendel/test/*.jpg"
labelFile="/home/mendel/imagenet_labels.txt"
classificationFile="/home/mendel/inception_v4_299_quant_edgetpu.tflite"


# Function to read labels from text files.
def ReadLabelFile(file_path):
  """Reads labels from text file and store it in a dict.

  Each line in the file contains id and description separted by colon or space.
  Example: '0:cat' or '0 cat'.

  Args:
    file_path: String, path to the label file.

  Returns:
    Dict of (int, string) which maps label id to description.
  """
  with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()
  ret = {}
  for line in lines:
    pair = re.split(r'[:\s]+', line.strip(), maxsplit=1)
    ret[int(pair[0])] = pair[1].strip()
  return ret

# Prepare labels.
labels = ReadLabelFile(labelFile)
# Initialize engine.
engine = ClassificationEngine(classificationFile)


crlf="\r\n"

# Keep track of the files and the time
processedcnt=0
start = time.time()


datestring=datetime.today().strftime('%Y-%b-%d__%H-%M-%S')

# Create a file for the log
text_file = open(datestring+".txt", "w")
text_file.write("Testing."+crlf)


# Loop over all the files in the directory
for filepath in glob.iglob(folder):

  processedcnt = processedcnt + 1
  #print("----------------------")
  #print(filepath)

  img = Image.open(filepath)
  # Run inference
  for result in engine.ClassifyWithImage(img, top_k=3):

    label=labels[result[0]] 
    res=result[1]
    #print(label)
    #print(res)
    #print(crlf)

    text_file.write(label+"___---___"+str(res)+"___---___"+filepath+crlf)


  #f processedcnt == 10:
  #   break


# Done, print some statistics and close the logfile file.
end = time.time()

print("\r\n\r\n")
print("Process date:     ", datestring)

print("Files processed:  ", processedcnt)
print("Loop time:        ", end - start)

text_file.close()


