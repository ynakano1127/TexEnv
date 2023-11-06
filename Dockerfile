FROM archlinux

RUN pacman -Sy --noconfirm
RUN pacman -S --noconfirm wget perl

RUN wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
WORKDIR /

RUN tar -zxvf install-tl-unx.tar.gz && \
    rm install-tl-unx.tar.gz && \
    mv install-tl-* install-tl
RUN perl ./install-tl/install-tl --no-interaction --scheme=scheme-basic --repository http://mirror.ctan.org/systems/texlive/tlnet

ENV MANPATH="$MANPATH:/usr/local/texlive/2023/texmf-dist/doc/man" \
    INFOPATH="$INFOPATH:/usr/local/texlive/2023/texmf-dist/doc/info" \
    PATH="$PATH:/usr/local/texlive/2023/bin/x86_64-linux"

RUN pacman -S fontconfig  --noconfirm && \
    tlmgr install collection-langjapanese
