fx_version 'cerulean'
game 'gta5'

name 'RCV'
description 'Repair and clean your vehicle.'
author 'Tuggummi'
version '1.0.0'


shared_scripts {
    'config.lua',
    'translations.lua'
} 

client_script 'c_RCV.lua'
server_script 's_RCV.lua'