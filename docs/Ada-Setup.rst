- https://ada-lang.io
- https://alire.ada.dev
- https://github.com/simonjwright/distributing-gcc/releases
- https://github.com/rod-chapman/SPARKNaCl

#. Download `latest Alire for Apple Silicon`_
#. Set up GNAT toolchain, and run hello_word.
#. Clone and build SPARKNaCl, and run the tests.

.. _latest Alire for Apple Silicon: https://github.com/alire-project/alire/releases/download/v2.1.0/alr-2.1.0-bin-aarch64-macos.zip

.. code-block:: bash
    
    mkdir ~/ada
    # Unzip the downloaded file
    unzip ~/Downloads/alr-2.1.0-bin-aarch64-macos.zip -d ~/ada/alire
    # Move the alire binary to /usr/local/bin
    mv ~/ada/alire/alr /usr/local/bin/alr
    # Remove the unzipped directory
    rm -rf ~/ada/alire

    # Verify the installation
    alr --version

    tmpdir="$(mktemp -d)" && trap 'rm -rf "$tmpdir"' EXIT
    # unzip ~/Downloads/alr-2.1.0-bin-aarch64-macos.zip -d "$tmpdir"
    curl -L 'https://github.com/alire-project/alire/releases/download/v2.1.0/alr-2.1.0-bin-aarch64-macos.zip' |
        bsdtar -xvf- -C "$tmpdir"
    sudo install "$tmpdir/bin/alr" /usr/local/bin/
    rm -rf "$tmpdir"
    unset tmpdir

    alr toolchain --select
    # gnat_native=15.1.2
    # gprbuild=25.0.1

    mkdir -p ~/ada/hello_world && cd "$_"
    alr init --in-place --bin $(basename "$PWD")
    alr run

    # If you hit "ld: library not found for -lSystem" on macOS, use:
    alr build -- -largs -Wl,-syslibroot,"$(xcrun --show-sdk-path)"
    alr run

    # With the Linker package using SDKROOT environment variable:
    SDKROOT=$(xcrun --show-sdk-path) alr build
    SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk alr build
