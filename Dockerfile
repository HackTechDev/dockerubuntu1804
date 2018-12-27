ARG image=ubuntu:18.04
FROM $image as system


ARG localbuild
RUN echo "LOCALBUILD=$localbuild"
RUN if [ "x$localbuild" != "x" ]; then sed -i 's#http://archive.ubuntu.com/#http://fr.archive.ubuntu.com/#' /etc/apt/sources.list; fi

ENV HOME=/root \
      APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
      DEBIAN_FRONTEND=noninteractive \
      FILES='' \
      LANG=en_US.UTF-8 \
      LANGUAGE=en_US.UTF-8 \
      LC_ALL=C.UTF-8


# built-in packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common curl \
    && apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
        mc screen vim sudo wget git zsh tmux \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/zsh util01 && echo "util01:mot2passe" | chpasswd && adduser util01 sudo

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN chsh -s /usr/bin/zsh
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/zsh
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/zsh-autosuggestions
RUN git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

RUN sed -i 's/robbyrussell/powerlevel9k\/powerlevel9k/' ~/.zshrc
RUN sed -i 's/  git/  git zsh-syntax-highlighting zsh-autosuggestions colored-man-colored/' ~/.zshrc

RUN cp ~/.zshrc ~/aa
RUN echo export TERM="xterm-256color" > ~/.zshrc
RUN cat ~/aa >> ~/.zshrc
RUN rm ~/aa

RUN cp ~/.zshrc /home/util01/
RUN sed -i 's/  export ZSH=\"\/root\/.oh-my-zsh\"/export ZSH=\"\/home\/util01\/.oh-my-zsh\"/' /home/util01/.zshrc
RUN cp -R ~/.oh-my-zsh /home/util01
RUN chown -R util01:util01 /home/util01/

RUN mkdir "/home/util01/volume01" && \
    chown -R util01:util01 /home/util01/volume01
