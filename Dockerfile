ARG image=debian:9.6
FROM $image as system

ENV HOME=/root \
      APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
      DEBIAN_FRONTEND=noninteractive \
      FILES='' \
      LANG=en_US.UTF-8 \
      LANGUAGE=en_US.UTF-8 \
      LC_ALL=C.UTF-8


# built-in packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
        software-properties-common curl \
        mc screen vim sudo wget git zsh tmux \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN chsh -s /usr/bin/zsh
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/zsh
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/zsh-autosuggestions
RUN git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

RUN sed -i 's/robbyrussell/powerlevel9k\/powerlevel9k/' ~/.zshrc
RUN sed -i 's/  git/  git zsh-syntax-highlighting zsh-autosuggestions colored-man-colored/' ~/.zshrc

RUN cp ~/.zshrc ~/aa && \
    echo export TERM="xterm-256color" > ~/.zshrc && \
    cat ~/aa >> ~/.zshrc && rm ~/aa
