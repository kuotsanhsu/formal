Lean 4 Setup
============

.. code-block:: bash

    # Install elan
    curl -sSfL https://elan.lean-lang.org/elan-init.sh | sh
    # Update elan
    elan self update
    # Install the latest stable version of Lean 4
    elan install stable
    # Set the latest stable version of Lean 4 as the default
    elan default stable

    # Initialize a new mathlib4 project in the current directory
    # with project name "Logic" and template "math"
    lake init Logic math

    # Build the project
    lake build
