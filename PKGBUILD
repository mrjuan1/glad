pkgname=glad
pkgver=1.0
pkgrel=1
arch=(any)

makedepends=(git python)
source=(git+https://github.com/dav1dde/glad)
md5sums=(SKIP)

prepare() {
	cd glad
	python setup.py build
	cd ..
	python glad/build/lib/glad --out-path src --api gles2=2.0 --generator c --extensions GL_EXT_texture_filter_anisotropic --local-files
}

build() {
	cd src
	gcc glad.c -o libglad.so -O3 -pipe -m64 -ftree-vectorize -ffast-math -funroll-loops -fPIC -shared -Wl,-soname,libglad.so
}

package() {
	cd src
	mkdir -pv $pkgdir/usr/include
	cp -v glad.h $pkgdir/usr/include
	strip -s libglad.so
	mkdir -pv $pkgdir/usr/lib
	cp -v libglad.so $pkgdir/usr/lib
}
