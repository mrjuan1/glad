#!/bin/sh -e

if [ $UID -ne 0 ]; then
	echo "Run as root"
	exit 1
fi

api="gles2=2.0"
extensions="--extensions GL_EXT_texture_filter_anisotropic"

case "$1" in
	"--gl")
		profile="--profile core"
		api="gl="
		spec="--spec gl"
		extensions=""
		;;
	"--gles")
		api="gles2="
		;;
	"--gles3")
		api="gles2=3.0"
		;;
	"--gles31")
		api="gles2=3.1"
		;;
	"--remove")
		rm -Rfv /usr/include/glad.h /usr/include/khrplatform.h /usr/lib/libglad.so /tmp/glad
		exit 0
esac

misc="$spec $extensions"

cd /tmp
rm -Rf glad
mkdir glad
cd glad

glad $profile --out-path . --api $api --generator=c $misc --local-files

gcc glad.c -o libglad.so -O3 -m64 -ftree-vectorize -ffast-math -funroll-loops -fPIC -shared -Wl,-soname,libglad.so
strip -s libglad.so

cp -v *.h /usr/include
cp -v libglad.so /usr/lib

cd ..
rm -Rf glad
