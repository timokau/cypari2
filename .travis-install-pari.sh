# Helper script to install PARI for Travis CI

# Exit on error
set -e

PARI_URL="http://pari.math.u-bordeaux.fr/pub/pari/$URLDIR"

# Figure out PARI version and download location
# Note that we support giving a list of URLs
if [ "$PARI_VERSION" = snapshot ]; then
    # The C=M;O=D request means: sort by date, most recent first.
    # Then the first tarball is the one we want.
    PARI_VERSION=$(wget -qO- "$PARI_URL/?C=M;O=D" | sed -n 's/.*href="\(pari-.*-g.*\)[.]tar[.]gz".*/\1/; T; p; q')
fi

# Download PARI sources
wget --no-verbose "$PARI_URL/$PARI_VERSION.tar.gz"

# Install
tar xzf "$PARI_VERSION.tar.gz"
cd "$PARI_VERSION"
./Configure --prefix=/usr
make gp
sudo make install
