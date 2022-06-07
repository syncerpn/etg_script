# -*- coding: utf-8 -*-
"""
Created on Wed Mar 18 17:56:24 2020

@author: Syncer
"""

import re
import os
from shutil import copyfile

pattern = re.compile(r'idle')
file_root = 'E:/SYNCER STUDIO/YT/Enter The Gungeon/DUMPsprites/WeaponCollection3/'
file_dest = 'E:/SYNCER STUDIO/YT/Enter The Gungeon/weapon_spr/'

file_list = os.listdir(file_root)

for file in file_list:
    if pattern.search(file):
        copyfile(file_root+file, file_dest+file)
        