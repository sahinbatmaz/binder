# FROM python:3.7-slim
FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y vim htop wget bzip2 unzip byobu
RUN apt-get install -y software-properties-common
RUN apt-get install -y gcc
RUN apt-get install -y build-essential
RUN apt-get install -y git && git config --global http.sslverify false
RUN apt-get install -y net-tools

RUN apt install -y zsh

RUN add-apt-repository ppa:lazygit-team/release
RUN apt-get update
RUN apt-get install lazygit

RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN useradd -m -s /bin/bash main
USER main
ENV HOME /home/main
ENV SHELL /bin/bash
ENV USER main
WORKDIR $HOME


# RUN apt install -y zsh
RUN sh -c "$(wget --no-check-certificate -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN apt install -y fonts-powerline
RUN cd ~/.oh-my-zsh/custom/plugins/ && \
    git clone https://github.com/unixorn/warhol.plugin.zsh.git warhol && \
    echo 'export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"' >> ~/.zshrc
    
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    sed -i '134s/wget/wget --no-check-certificate/g' ~/.fzf/install && \
    sed -i '137s/wget/wget --no-check-certificate/g' ~/.fzf/install && \
    ~/.fzf/install && \
    cd ~/.oh-my-zsh/custom/plugins/ && \
    git clone https://github.com/changyuheng/zsh-interactive-cd.git && \
    echo "source ~/.oh-my-zsh/custom/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh" >> ~/.zshrc
    
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    
RUN sed -i 's/ZSH_THEME="robyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc
RUN sed -i 's/plugins=(git)/plugins=(git warhol zsh-syntax-highlighting zsh-autosuggestions)/g' ~/.zshrc


# RUN curl -o /Anaconda3-2020.02-Linux-x86_64.sh https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
# RUN wget -P /  https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
RUN bash Anaconda3-2020.02-Linux-x86_64.sh -b
RUN rm Anaconda3-2020.02-Linux-x86_64.sh

#ENV PATH /root/anaconda3/bin:$PATH
ENV PATH $HOME/anaconda3/bin:$PATH
RUN pip install --upgrade pip



RUN conda install -c conda-forge jupyter_contrib_nbextensions && \
    conda install -c conda-forge jupyter_nbextensions_configurator
RUN jupyter nbextension enable codefolding/main &&\
    jupyter nbextension enable execute_time/ExecuteTime && \
    jupyter nbextension enable scratchpad/main && \
    jupyter nbextension enable collapsible_headings/main && \
    jupyter nbextension enable autoscroll/main

##############################################################
##############################################################

RUN conda install -c conda-forge jupytext
RUN bash -c "test -f ~/.jupyter/jupyter_notebook_config.py || jupyter notebook --generate-config"
RUN echo 'c.NotebookApp.contents_manager_class = "jupytext.TextFileContentsManager"' >> ~/.jupyter/jupyter_notebook_config.py
RUN echo 'c.ContentsManager.default_jupytext_formats = "py"' >> ~/.jupyter/jupyter_notebook_config.py
RUN echo 'c.ContentsManager.preferred_jupytext_formats_save = "py:percent"' >> ~/.jupyter/jupyter_notebook_config.py
RUN echo 'c.ContentsManager.default_notebook_metadata_filter = "-all"' >> ~/.jupyter/jupyter_notebook_config.py
RUN echo 'c.ContentsManager.default_cell_metadata_filter = "-all"' >> ~/.jupyter/jupyter_notebook_config.py
RUN echo 'c.ContentsManager.notebook_extensions = "ipynb,py"' >> ~/.jupyter/jupyter_notebook_config.py

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
