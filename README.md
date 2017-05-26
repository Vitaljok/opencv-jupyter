# opencv-jupyter
Jupyter with OpenCV support and focus on video stream processing
Based on scipy-notebook from [jupyter/docker-stacks](https://github.com/jupyter/docker-stacks) and [janza/docker-python3-opencv](https://github.com/janza/docker-python3-opencv) images.

Additional changes:
- added missing libraries for OpenCV compilation
- jpeg9a compiled from sources
- explicit FFMPEG flags for OpenCV
- disabled AVX for deploying on older server

Starting command example:
- docker run -d -v opencv-notebooks:/home/jovyan/work -p 8001:8888 \
  jupyter-opencv start-notebook.sh --NotebookApp.password='sha1:123456789012:1234567890abcdefghijklmnoprstqvwxyz'
