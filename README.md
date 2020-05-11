# binder

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/sahinbatmaz/binder/master)

------

#### dockerfile notes

- https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html#preparing-your-dockerfile
- https://github.com/binder-examples/minimal-dockerfile/blob/master/Dockerfile
- https://github.com/binder-project/binder-build-core/blob/master/images/base/Dockerfile
- https://github.com/binder-project/binder-build-core/blob/master/images/python/3.5/Dockerfile
- https://mybinder.readthedocs.io/en/latest/config_files.html

#### memory and core information

```
! free -mh
! cat /proc/cpuinfo | grep processor | wc -l
```

#### other notes
```
##############################################################
##############################################################


# # install the notebook package
# RUN pip install --no-cache --upgrade pip && \
#     pip install --no-cache --force-reinstall notebook


##############################################################
##############################################################


# # create user with a home directory
# ARG NB_USER
# ARG NB_UID
# ENV USER ${NB_USER}
# ENV HOME /home/${NB_USER}

# RUN adduser --disabled-password \
#     --gecos "Default user" \
#     --uid ${NB_UID} \
#     ${NB_USER}
# WORKDIR ${HOME}
# USER ${USER}
```

```
#RUN pip install --no-cache-dir notebook==6.0.1
#RUN pip install --no-cache-dir --ignore-installed notebook==6.0.3
RUN pip install --no-cache-dir --force-reinstall --no-deps notebook==6.0.3

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
    
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
```

