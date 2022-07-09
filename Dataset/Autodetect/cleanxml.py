# import required module
from pathlib import Path
import os.path

 
# get the path/directory
#folder_dir = 'D:\Git\Salmon\Dataset\Autodetect\'
folder_dir = Path('D:\\Git\\Salmon\\Dataset\\Autodetect\\')
 
# iterate over files in
# that directory
images = Path(folder_dir).glob('*.xml')
for image in images:
    print(image)
    jpgfile = str(Path(image).parent.absolute())+"\\"+str(Path(image).stem)+".jpg"
    print(jpgfile)
    if not os.path.exists(jpgfile):
        print("Warning")
        Path.unlink(image) 
    