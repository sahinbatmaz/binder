FROM ubuntu:16.04

##############################################################
##############################################################

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y vim htop wget bzip2 unzip byobu
RUN apt-get install -y software-properties-common
RUN apt-get install -y gcc
RUN apt-get install -y build-essential
RUN apt-get install -y git && git config --global http.sslverify false
RUN apt-get install -y net-tools

##############################################################
##############################################################

RUN apt install -y zsh
RUN sh -c "$(wget --no-check-certificate -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN apt install -y fonts-powerline
RUN cd ~/.oh-my-zsh/custom/plugins/ && \
    git clone https://github.com/unixorn/warhol.plugin.zsh.git warhol && \
    echo 'export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"' >> /root/.zshrc
    
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    sed -i '134s/wget/wget --no-check-certificate/g' ~/.fzf/install && \
    sed -i '137s/wget/wget --no-check-certificate/g' ~/.fzf/install && \
    ~/.fzf/install && \
    cd ~/.oh-my-zsh/custom/plugins/ && \
    git clone https://github.com/changyuheng/zsh-interactive-cd.git && \
    echo "source /root/.oh-my-zsh/custom/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh" >> /root/.zshrc
    
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    
RUN sed -i 's/ZSH_THEME="robyrussell"/ZSH_THEME="agnoster"/g' /root/.zshrc
RUN sed -i 's/plugins=(git)/plugins=(git warhol zsh-syntax-highlighting zsh-autosuggestions)/g' /root/.zshrc

##############################################################
##############################################################

RUN add-apt-repository ppa:lazygit-team/release
RUN apt-get update
RUN apt-get install lazygit

##############################################################
##############################################################

# RUN curl -o /Anaconda3-2020.02-Linux-x86_64.sh https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
RUN wget -P /  https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
RUN bash /Anaconda3-2020.02-Linux-x86_64.sh -b
RUN rm /Anaconda3-2020.02-Linux-x86_64.sh
ENV PATH /root/anaconda3/bin:$PATH

RUN conda config --set ssl_verify false
RUN pip install --upgrade pip

# RUN sed -i 's/self\.verify = True/self\.verify = False/g' $(python -c "import site; print(site.getsitepackages()[0])")/requests/session.py
# RUN sed -i 's/self\.verify = True/self\.verify = False/g' $(python -c "import site; print(site.getsitepackages()[0])")/pip/_vendor/requests/session.py

##############################################################
##############################################################

RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

##############################################################
##############################################################

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
RUN bash -c "test -f /root/.jupyter/jupyter_notebook_config.py || jupyter notebook --generate-config"
RUN echo 'c.NotebookApp.contents_manager_class = "jupytext.TextFileContentsManager"' >> /root/.jupyter/jupyter_notebook_config.py
RUN echo 'c.ContentsManager.default_jupytext_formats = "py"' >> /root/.jupyter/jupyter_notebook_config.py
RUN echo 'c.ContentsManager.preferred_jupytext_formats_save = "py:percent"' >> /root/.jupyter/jupyter_notebook_config.py
RUN echo 'c.ContentsManager.default_notebook_metadata_filter = "-all"' >> /root/.jupyter/jupyter_notebook_config.py
RUN echo 'c.ContentsManager.default_cell_metadata_filter = "-all"' >> /root/.jupyter/jupyter_notebook_config.py
RUN echo 'c.ContentsManager.notebook_extensions = "ipynb,py"' >> /root/.jupyter/jupyter_notebook_config.py

##############################################################
##############################################################

WORKDIR /home/notebooks
CMD ["jupyter", "notebook","--ip","0.0.0.0"]
# CMD jupyter notebook --notebook-dir=/home/notebooks/ --ip=0.0.0.0
# CMD jupyter notebook --no-browser --allow-root --NotebookApp.token='' --notebook-dir=/home/notebooks/ --port=9000 --ip=0.0.0.0 --debug

