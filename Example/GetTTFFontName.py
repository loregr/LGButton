"""
From
https://github.com/gddc/ttfquery/blob/master/ttfquery/describe.py
and
http://www.starrhorne.com/2012/01/18/how-to-extract-font-names-from-ttf-files-using-python-and-our-old-friend-the-command-line.html
ported to Python 3
"""
import os
from fontTools import ttLib

FONT_SPECIFIER_NAME_ID = 4
FONT_SPECIFIER_FAMILY_ID = 1
def shortName( font ):
    """Get the short name from the font's names table"""
    name = ""
    family = ""
    for record in font['name'].names:
        if b'\x00' in record.string:
            name_str = record.string.decode('utf-16-be')
        else:
            name_str = record.string.decode('utf-8')
        if record.nameID == FONT_SPECIFIER_NAME_ID and not name:
            name = name_str
        elif record.nameID == FONT_SPECIFIER_FAMILY_ID and not family:
            family = name_str
        if name and family: break
    return name, family

if __name__ == '__main__':
    path = "../LGButton/Resources/"
    fonts = os.listdir(path)
    for font in fonts:
        if font.endswith(".ttf") == False:
            continue
        tt = ttLib.TTFont(path + font)
        print("FileName:%s\t\t"%font,"Name: %s  Family: %s" % shortName(tt))
