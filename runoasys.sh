#!/bin/bash

source /opt/conda/bin/activate

conda activate oasys
export QT_XCB_GL_INTEGRATION=xcb_egl
python -m oasys.canvas -l4 --force-discovery
