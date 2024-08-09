ARG JUPYTER_VERSION=notebook-7.0.6

#########################################################
# Set the base image to use for subsequent instructions #
#########################################################
FROM jupyter/base-notebook:${JUPYTER_VERSION} AS jupyter


ARG WORK_DIR=/home/jovyan/work
#########################################################
#                  Create a run stage                   #
#########################################################
FROM jupyter AS run-stage

USER $NB_USER

# Set the environment variable to disable file validation for PyDev  
ENV PYDEVD_DISABLE_FILE_VALIDATION=1

# Install nbextensions
RUN conda install -c conda-forge jupyter_contrib_nbextensions
# Enable nbextensions
RUN jupyter contrib nbextension install --user

# Install additional Python packages if needed 
# RUN conda install --quiet --yes \
#     numpy \
#     pandas \
#     matplotlib \
#     scipy \
#     scikit-learn

RUN conda clean --all -f -y

COPY --chown=$NB_UID:$NB_GID ./jupyter /home/$NB_USER/.jupyter
COPY --chown=$NB_UID:$NB_GID ./extensions /home/$NB_USER/.local/share/jupyter/nbextensions

RUN fix-permissions $CONDA_DIR &&\
    fix-permissions /home/$NB_USER/

# Set working directory
WORKDIR ${WORK_DIR}

# Expose the Jupyter Notebook port  
EXPOSE 8888

USER $NB_USER
