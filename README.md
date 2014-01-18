FFMPEG Auto Installer
===
A series of scripts used to help install the latest version of FFMPEG. This currently is only tested with CentOS. It may work with fedora but unless you translate the prerequisites with apt-get first it wont work with Ubunutu. This was also designed to work within a cpanel environment where many other prerequisites were already installed. This project was originally started by the ffmpeg auto installer folks [here][1]. I ran into tons of issues with the newer version of FFMPEG so rather than continually fixing it I just forked it and with the help of a colleague simplified and fixed it.  

Install
---
1. Clone the repo or download the zip
2. run ```sh ffmpeg.sh```

That's it! Pretty simple right! You should start seeing green "completed" if everything went well. If you see any "failed" messages you can check the log in $DOWNDIR/log. By default this is located in /root/ffmpeginstall/log. Each library will begin with the "Installing lib" so you can can easily search and find. 

Libraries Installed
---
- FreeType
- libwmf
- FLVTool
- Lame
- libogg
- libvorbis
- VorbisTools
- libtheora
- openamr
- liba52
- FAAC
- FAAD2
- YASM
- NASM
- XVID
- x264
- Live555
- re2c
- amrnb
- amrwb
- libvpx
- libasound

Programs Installed
---
- FFMPEG
- MPlayer
- MP4Box
- FFMPEG-PHP (GitHub Fork)

Future
---
- Add all necessary prereq's
- Support for Ubuntu

[1]: http://www.ffmpeginstaller.com/