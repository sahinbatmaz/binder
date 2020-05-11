# binder

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/sahinbatmaz/binder/master)

------

#### dockerfile notes

- https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html#preparing-your-dockerfile
- https://github.com/binder-examples/minimal-dockerfile/blob/master/Dockerfile
- https://github.com/binder-project/binder-build-core/blob/master/images/base/Dockerfile
- https://github.com/binder-project/binder-build-core/blob/master/images/python/3.5/Dockerfile

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
