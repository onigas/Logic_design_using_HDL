#!/usr/bin/env python3
from pathlib import Path
from PIL import Image
import sys
W,H=240,160
def resize_crop(img):
 img=img.convert('RGB');w,h=img.size;scale=max(W/w,H/h);nw,nh=int(w*scale),int(h*scale);img=img.resize((nw,nh),Image.LANCZOS);left=(nw-W)//2;top=(nh-H)//2;return img.crop((left,top,left+W,top+H))
def main():
 if len(sys.argv)!=3: sys.exit(1)
 src=Path(sys.argv[1]);base=Path(sys.argv[2]);img=resize_crop(Image.open(src));vals=[]
 for y in range(H):
  for x in range(W):
   r,g,b=img.getpixel((x,y));vals.append(((r>>4)<<8)|((g>>4)<<4)|(b>>4))
 base.with_suffix('.mem').write_text(''.join(f'{v:03X}\n' for v in vals))
 coe=['memory_initialization_radix=16;','memory_initialization_vector=']+[f'{v:03X}'+(',' if i<len(vals)-1 else ';') for i,v in enumerate(vals)]
 base.with_suffix('.coe').write_text('\n'.join(coe)+'\n');img.save(base.with_suffix('.png'))
if __name__=='__main__': main()
