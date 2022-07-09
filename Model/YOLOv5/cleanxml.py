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
    jpgfile = (Path(xml).parent.absolute() / Path(xml).stem).with_suffix('.jpg')

    #jpgfile = str(Path(xml).parent.absolute())+"\\"+str(Path(xml).stem)+".jpg"
    #print(jpgfile)
    if not os.path.exists(jpgfile):
        print("Warning")
        Path.unlink(xml) 

jpgs = Path(folder_dir).glob('*.jpg')
for jpg in jpgs:
    #print(jpg)
    xmlfile = (Path(jpg).parent.absolute() / Path(jpg).stem).with_suffix('.xml')

    #xmlfile = str(Path(jpg).parent.absolute())+"\\"+str(Path(jpg).stem)+".xml"
    #print(xmlfile)
    if not os.path.exists(xmlfile):
        print("move", jpg, "D:\\cleanup")
        #copyfile(source, destination)


        #  MOVE THE FILE Path.unlink(xml) 

