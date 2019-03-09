sudo yum install gcc make ncurses-devel giflib-devel libjpeg-devel libtiff-devel
wget wget http://ftp.gnu.org/gnu/emacs/emacs-25.2.tar.xz
tar xJf emacs-25.2.tar.xz
cd emacs-25.2
./configure --without-x --without-selinux
make && sudo make install
