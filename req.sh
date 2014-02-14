#!/bin/bash
##### Control Script for instaslling prerequisites #####

####PRE SETUP####
install_ruby() {
    echo " -------------- Installing Ruby -------------- "
    if [ ! -f /usr/bin/ruby ]; then
      /scripts/installruby
    fi
    return $?
}

remove_stuff() {
    rm -rf /lib/liba52*
    rm -rf /lib/libamr*
    rm -rf /lib/libavcodec*
    rm -rf /lib/libavformat*
    rm -rf /lib/libavutil*
    rm -rf /lib/libdha*
    rm -rf /lib/libfaac*
    rm -rf /lib/libfaad*
    rm -rf /lib/libmp3lame*
    rm -rf /lib/libmp4v2*
    rm -rf /lib/libogg*
    rm -rf /lib/libtheora*
    rm -rf /lib/libvorbis*

    rm -rf /usr/lib/liba52*
    rm -rf /usr/lib/libamr*
    rm -rf /usr/lib/libavcodec*
    rm -rf /usr/lib/libavformat*
    rm -rf /usr/lib/libavutil*
    rm -rf /usr/lib/libdha*
    rm -rf /usr/lib/libfaac*
    rm -rf /usr/lib/libfaad*
    rm -rf /usr/lib/libmp3lame*
    rm -rf /usr/lib/libmp4v2*
    rm -rf /usr/lib/libogg*
    rm -rf /usr/lib/libtheora*
    rm -rf /usr/lib/libvorbis*

    rm -rf /usr/local/lib/liba52*
    rm -rf /usr/local/lib/libamr*
    rm -rf /usr/local/lib/libavcodec*
    rm -rf /usr/local/lib/libavformat*
    rm -rf /usr/local/lib/libavutil*
    rm -rf /usr/local/lib/libdha*
    rm -rf /usr/local/lib/libfaac*
    rm -rf /usr/local/lib/libfaad*
    rm -rf /usr/local/lib/libmp3lame*
    rm -rf /usr/local/lib/libmp4v2*
    rm -rf /usr/local/lib/libogg*
    rm -rf /usr/local/lib/libtheora*
    rm -rf /usr/local/lib/libvorbis*
    rm -f /usr/lib/libxvidcore.*

    unlink /usr/bin/ffmpeg >/dev/null 2>&1
    unlink /usr/local/bin/ffmpeg >/dev/null 2>&1
    unlink /bin/mplayer >/dev/null 2>&1
    unlink /usr/bin/mplayer >/dev/null 2>&1
    unlink /usr/local/bin/mplayer >/dev/null 2>&1
    unlink /bin/mencoder >/dev/null 2>&1
    unlink /usr/bin/mencoder  >/dev/null 2>&1
    unlink /usr/local/bin/mencoder >/dev/null 2>&1
    unlink /bin/flvtool2 >/dev/null 2>&1
    unlink /usr/bin/flvtool2 >/dev/null 2>&1
    unlink /usr/local/bin/flvtool2 >/dev/null 2>&1
    rm -rf /usr/local/cpffmpeg
    rm -rf $HOME/tmp
    mkdir -p $HOME/tmp

    return $?
}

run_yum() {
    echo " -------------- Running Yum -------------- "
    sed -i '/exclude/s/^/#/g' /etc/yum.conf
    yum remove -y ffmpeg x264 wt-cpanel-ffmpeg-php xvidcore

    yum install curl-devel gcc gcc-c++ libgcc gd gd-devel gettext freetype \
    freetype-devel libjpeg* libjpeg-devel* \
    libpng* libpng-devel* libstdc++* libstdc++-devel* libtiff* \
    libtiff-devel* libtool* libxml* libxml2* \
    libxml2-devel* zlib* zlib-devel* automake* autoconf* samba-common* \
    ncurses-devel ncurses patch make apr-util giflib-devel giflib neon \
    expat-devel gettext-devel openssl-devel subversion SDL-devel freeglut-devel perl -y

    sed -i '/exclude/s/^#//g' /etc/yum.conf
    
    rpm -e alsa-lib --nodeps
    return 0
}

check_threads() {
    echo " -------------- Checking For Perl Compatibility -------------- "
    if ! /usr/bin/perl -e "use threads;"
    then
        if [ -f /usr/bin/perl5.10.1 ]
        then
            mv /usr/bin/perl /usr/bin/perl.old
            ln -s /usr/bin/perl5.10.1 /usr/bin/perl
        else
            cd /usr/local/src
            rm -rf ActivePerl*
            wget http://downloads.activestate.com/ActivePerl/releases/5.18.1.1800/ActivePerl-5.18.1.1800-x86_64-linux-glibc-2.5-297570.tar.gz
            tar xzf ActivePerl*
            cd ActivePerl*
            sh install.sh --license-accepted --prefix /opt/wt-perl/ --no-install-html
            mv /usr/bin/perl /usr/bin/perl.old
            ln -s /opt/wt-perl/bin/perl-static /usr/bin/perl
        fi
    fi
    
    return $?
}

#Git client
install_git() {
    echo " -------------- Installing Git (If Necessary) -------------- "
    cd $DOWNDIR
    if ! hash git 2>/dev/null
    then
        if [ -f /usr/local/cpanel/3rdparty/bin/git ]
        then
            alias git=/usr/local/cpanel/3rdparty/bin/git
        else 
            cd $DOWNDIR
            rm -vrf git-master
            yum -y install expat-devel gettext-devel openssl-devel zlib-devel
            wget -N https://github.com/git/git/archive/master.tar.gz
            tar -xzvf master
            cd git-master
            make prefix=/usr/local all
            make prefix=/usr/local install
        fi
    fi
    return $?
}
