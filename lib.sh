#!/bin/bash
##### Install Libraries #####

ERROR=0

install_freetype() {
    echo " -------------- Installing FreeType -------------- "
    FREETYPE_VER="2.5.0.1" #2013-06-19
    cd $DOWNDIR
    rm -vrf freetype-$FREETYPE_VER
    wget -N http://download.savannah.gnu.org/releases/freetype/freetype-$FREETYPE_VER.tar.gz
    tar -zxvf freetype-$FREETYPE_VER.tar.gz
    cd freetype-$FREETYPE_VER
    ./configure --prefix=/usr --enable-shared || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libwmf() {
    echo " -------------- Installing libwmf -------------- "    
    LIBWMF_VER="0.2.8.4" #2005-7-27
    cd $DOWNDIR
    rm -vrf libwmf-$LIBWMF_VER
    wget -N http://downloads.sourceforge.net/project/wvware/libwmf/$LIBWMF_VER/libwmf-$LIBWMF_VER.tar.gz
    tar -xvzf  libwmf-$LIBWMF_VER.tar.gz
    cd libwmf*
    ./configure --enable-shared --prefix=/usr --with-freetype=/usr/  || local ERROR=1
    make -j$cpu  || local ERROR=1
    make install $DESTDIR  || local ERROR=1

    ldconfig
    return $ERROR
}

install_flvtool() {
    echo " -------------- Installing FLVTool -------------- "
    cd $DOWNDIR
    rm -vrf flvtool2
    git clone https://github.com/unnu/flvtool2.git flvtool2
    cd flvtool2
    ruby setup.rb config || local ERROR=1
    ruby setup.rb setup || local ERROR=1
    ruby setup.rb install || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_lame() {
    echo " -------------- Installing LAME -------------- "
    LAME_MJVER="3.99" #2012-02-28
    LAME_MNVER=".5"
    cd $DOWNDIR
    rm -vrf lame-$LAME_MJVER$LAME_MNVER
    wget -N http://downloads.sourceforge.net/project/lame/lame/$LAME_MJVER/lame-$LAME_MJVER$LAME_MNVER.tar.gz
    tar -zxvf lame-$LAME_MJVER$LAME_MNVER.tar.gz
    cd lame-$LAME_MJVER$LAME_MNVER
    ./configure --enable-shared --prefix=/usr --enable-mp3x --enable-mp3rtp  || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1

    ldconfig
    return $ERROR
}

install_codecs() {
    echo " -------------- Installing Codecs -------------- "
    FFMPEG_CODECS_VER="20110131"
    cd $DOWNDIR
    rm -vfr all-$FFMPEG_CODECS_VER
    #wget -N http://mirror.ffmpeginstaller.com/source/codecs/all-$FFMPEG_CODEC_VER.tar.bz2
    wget -N http://www.mplayerhq.hu/MPlayer/releases/codecs/all-$FFMPEG_CODEC_VER.tar.bz2
    tar -xvjf all-$FFMPEG_CODECS_VER.tar.bz2
    chown -R root.root all-$FFMPEG_CODECS_VER/
    mkdir -pv /usr/lib/codecs/
    /bin/cp -vrf all-$FFMPEG_CODECS_VER/* /usr/lib/codecs/
    chmod -R 755 /usr/lib/codecs/

    ldconfig
    return $?
}

install_libogg() {
    echo " -------------- Installing libogg -------------- "
    LIBOGG_VER="1.3.1" #2013-05-20
    cd $DOWNDIR
    rm -vrf libogg-$LIBOGG_VER
    wget -N http://downloads.xiph.org/releases/ogg/libogg-$LIBOGG_VER.tar.gz
    tar -xvzf libogg-$LIBOGG_VER.tar.gz
    cd libogg-$LIBOGG_VER
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libvorbis() {
    echo " -------------- Installing libvorbis -------------- "
    LIBVORBIS_VER="1.3.3" #2012-02-03
    cd $DOWNDIR
    rm -vrf libvorbis-$LIBVORBIS_VER
    wget -N http://downloads.xiph.org/releases/vorbis/libvorbis-$LIBVORBIS_VER.tar.gz
    tar -xvzf libvorbis-$LIBVORBIS_VER.tar.gz
    cd libvorbis-$LIBVORBIS_VER/
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_vorbistools() {
    echo " -------------- Installing VorbisTools -------------- "
    VORBISTOOLS_VER="1.4.0" #2010-03-26
    cd $DOWNDIR
    rm -vrf vorbis-tools-$VORBISTOOLS_VER
    wget -N http://downloads.xiph.org/releases/vorbis/vorbis-tools-$VORBISTOOLS_VER.tar.gz
    tar -xvzf vorbis-tools-$VORBISTOOLS_VER.tar.gz
    cd vorbis-tools-$VORBISTOOLS_VER
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libtheora() {
    echo " -------------- Installing libtheora -------------- "
    LIBTHEORA_VER="1.1.1" #2010-01-25
    cd $DOWNDIR
    rm -vrf libtheora-$LIBTHEORA_VER
    wget -N http://downloads.xiph.org/releases/theora/libtheora-$LIBTHEORA_VER.tar.bz2
    tar -xvjf libtheora-$LIBTHEORA_VER.tar.bz2
    cd libtheora-$LIBTHEORA_VER
    ./configure --enable-shared --prefix=/usr --with-ogg=/usr --with-vorbis=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_openamr() {
    echo " -------------- Installing OpenAMR -------------- "
    OPENAMR_VER="0.1.3" #2012-02-20
    cd $DOWNDIR
    rm -vrf opencore-$OPENAMR_VER
    wget -N http://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-$OPENAMR_VER.tar.gz
    tar -zxvf opencore-amr-$OPENAMR_VER.tar.gz
    cd opencore-amr-$OPENAMR_VER
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_liba52() {
    echo " -------------- Installing liba52 -------------- "
    LIBA52_VER="0.7.4" #2002-07-27
    cd $DOWNDIR
    rm -rf a52dec-$LIBA52_VER
    wget -N http://liba52.sourceforge.net/files/a52dec-$LIBA52_VER.tar.gz
    tar -xvzf a52dec-$LIBA52_VER.tar.gz
    cd a52dec-$LIBA52_VER/
    ./bootstrap
    ARCH=`arch`
    #64bit processor bug fix
    if [[ $ARCH == 'x86_64' ]];then
      ./configure --prefix=/usr --enable-shared 'CFLAGS=-fPIC'  || local ERROR=1	
    else
      ./configure --prefix=/usr --enable-shared || local ERROR=1
    fi
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_facc() {
    echo " -------------- Installing FACC -------------- "
    FACC_VER="1.28" #2009-02-10
    cd $DOWNDIR
    rm -rf facc-$FACC_VER
    wget -N http://downloads.sourceforge.net/project/faac/faac-src/faac-$FACC_VER/faac-$FACC_VER.tar.gz
    tar -xvzf faac-$FACC_VER.tar.gz
    cd faac-$FACC_VER/
    sed -i 126d common/mp4v2/mpeg4ip.h
    sh bootstrap
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_faad2() {
    echo " -------------- Installing FAAD -------------- "
    FAAD_VER="2.7" #2009-02-10
    cd $DOWNDIR
    rm -rf faad2-$FAAD_VER
    wget -N http://downloads.sourceforge.net/faac/faad2-$FAAD_VER.tar.gz
    tar -xvzf faad2-$FAAD_VER.tar.gz
    cd faad2-$FAAD_VER/
    sh bootstrap
    ./configure --enable-shared --prefix=/usr  --with-mpeg4ip || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_yasm() {
    echo " -------------- Installing YASM -------------- " 
    YASM_VER="1.2.0" #2011-10-31
    cd $DOWNDIR
    rm -vrf yasm-$YASM_VER
    wget -N http://www.tortall.net/projects/yasm/releases/yasm-$YASM_VER.tar.gz
    tar -xvzf yasm-$YASM_VER.tar.gz
    cd  yasm-$YASM_VER
    sh autogen.sh
    ./configure --enable-shared --prefix=/usr  || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1

    ldconfig
    return $ERROR
}

install_nasm() {
    echo " -------------- Installing NASM -------------- "
    NASM_VER="2.10.09" #2013-07-22
    cd $DOWNDIR
    rm -vrf nasm-$NASM_VER
    wget -N http://www.nasm.us/pub/nasm/releasebuilds/$NASM_VER/nasm-$NASM_VER.tar.gz
    tar -xvzf nasm-$NASM_VER.tar.gz
    cd nasm-$NASM_VER
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_xvid() {
    echo " -------------- Installing XVID -------------- "
    cd $DOWNDIR
    #need latest for MP4Box to work
    rm -vrf xvid_*
    wget -N http://downloads.xvid.org/downloads/xvid_latest.tar.gz
    tar -xvzf xvid_latest.tar.gz
    cd xvid_*/trunk/xvidcore/build/generic/
    ./bootstrap.sh
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_x264() {
    echo " -------------- Installing x264 -------------- "
    cd $DOWNDIR
    rm -vrf x264
    git clone http://repo.or.cz/r/x264.git x264
    cd x264/
    #broken centos5/32bit./configure  --prefix=/usr --enable-shared --disable-asm
    ./configure  --prefix=/usr --enable-shared || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_live555() {
    echo " -------------- Installing Live555 -------------- "
    cd $DOWNDIR
    rm -vrf live
    wget -N http://www.live555.com/liveMedia/public/live555-latest.tar.gz
    tar xvf live555-latest.tar.gz
    cd live
    ./genMakefiles linux || local ERROR=1
    make -j$cpu || local ERROR=1
    make install  || local ERROR=1
    make clean || local ERROR=1

    ldconfig
    return $ERROR
}

install_re2c() {
    echo " -------------- Installing RE2C -------------- "
    RE2C_VER="0.13.6" #2013-07-05
    cd $DOWNDIR
    echo "Removing old source"
    rm -vrf re2c-$RE2C_VER
    wget -N http://downloads.sourceforge.net/project/re2c/re2c/$RE2C_VER/re2c-$RE2C_VER.tar.gz
    tar -xvzf re2c-$RE2C_VER.tar.gz
    cd re2c-$RE2C_VER/
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_amrnb() {
    echo " -------------- Installing AMRNB -------------- "
    AMR_VER="11.0.0.0" #2013-04-05
    cd $DOWNDIR
    rm -vrf amrnb-$AMR_VER
    wget --no-check-certificate -N ftp://ftp.penguin.cz/pub/users/utx/amr/amrnb-$AMR_VER.tar.bz2
    tar -xvjf amrnb-$AMR_VER.tar.bz2
    cd amrnb-$AMR_VER
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_amrwb() {
    echo " -------------- Installing AMRWB -------------- "
    cd $DOWNDIR
    rm -vrf amrwb-$AMR_VER
    wget -N ftp://ftp.penguin.cz/pub/users/utx/amr/amrwb-$AMR_VER.tar.bz2
    tar -xvjf amrwb-$AMR_VER.tar.bz2
    cd amrwb-$AMR_VER
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libvpx() {
    echo " -------------- Installing libvpx -------------- "
    cd $DOWNDIR
    rm -vrf libvpx
    git clone https://chromium.googlesource.com/webm/libvpx libvpx
    cd libvpx
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libasound() {
    echo " -------------- Installing libasound -------------- "
    cd $DOWNDIR
    rm -rf alsa-lib*
    wget ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.0.27.2.tar.bz2
    tar xjf alsa-lib*
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}