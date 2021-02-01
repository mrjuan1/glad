pkgname=glad
pkgver=0.2
pkgrel=1
arch=(any)

makedepends=(git)
source=(git+https://github.com/dav1dde/glad)
md5sums=(SKIP)

depends=(python)
install=glad.install

build() {
	cd glad
	python setup.py build
}

package() {
	cd glad
	python setup.py install --prefix=$pkgdir/usr

	cd ../..
	cp glad-genlib.sh $pkgdir/usr/bin
}
