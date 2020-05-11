# FROM python:3.7-slim
FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y wget


RUN useradd -m -s /bin/bash main
USER main
ENV HOME /home/main
ENV SHELL /bin/bash
ENV USER main
WORKDIR $HOME

# RUN curl -o /Anaconda3-2020.02-Linux-x86_64.sh https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
# RUN wget -P /  https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
RUN bash Anaconda3-2020.02-Linux-x86_64.sh -b
RUN rm Anaconda3-2020.02-Linux-x86_64.sh

#ENV PATH /root/anaconda3/bin:$PATH
ENV PATH $HOME/anaconda3/bin:$PATH
RUN pip install --upgrade pip

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
