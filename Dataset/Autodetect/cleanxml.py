# import required module
from pathlib import Path
import os.path

 
# get the path/directory
#folder_dir = 'D:\Git\Salmon\Dataset\Autodetect\'
folder_dir = Path('D:\\Git\\Salmon\\Dataset\\Autodetect\\')
 
# iterate over files in
# that directory
xmls = Path(folder_dir).glob('*.xml')
for xml in xmls:
    #print(xml)
    jpgfile = str(Path(xml).parent.absolute())+"\\"+str(Path(xml).stem)+".jpg"
    #print(jpgfile)
    if not os.path.exists(jpgfile):
        print("Warning")
        Path.unlink(xml) 

jpgs = Path(folder_dir).glob('*.jpg')
for jpg in jpgs:
    #print(jpg)
    xmlfile = str(Path(jpg).parent.absolute())+"\\"+str(Path(jpg).stem)+".xml"
    print(jpgfile)
    if not os.path.exists(jpgfile):
        print("Warning")
        print(jpgfile)

        #  MOVE THE FILE Path.unlink(xml) 

