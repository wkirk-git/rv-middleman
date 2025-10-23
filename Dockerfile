FROM debian:trixie-20251020-slim
LABEL maintainer="William Kirk wkirk-git@mailbox.org" \
      org.opencontainers.image.authors="William Kirk wkirk-git@mailbox.org" \
      description="This project https://github.com/wkirk-git/rv-middleman demonstrates using the rv package manager to set up a Ruby development environment with Middleman in a slim Debian Trixie container." \
      version="0.2.0"
SHELL ["/bin/bash", "-exo", "pipefail",  "-c"]
RUN apt-get update -y && \
apt-get install -y --no-install-recommends \
curl=8.14.1-2 \
xz-utils=5.8.1-1 \
libsass-dev=3.6.5+20231221-3+b1 \
build-essential=12.12 \
nodejs=20.19.2+dfsg-1 \
ca-certificates=20250419 \
git=1:2.47.3-0+deb13u1 \
libyaml-dev=0.2.5-2 && \
rm -rf /var/lib/apt/lists/* && \
useradd -ms /bin/bash middleman
USER middleman
WORKDIR /home/middleman/
ENV PATH="$PATH:/home/middleman/.cargo/bin:/home/middleman/.data/rv/rubies/ruby-3.4.7/bin"
ENV BASH_ENV="/home/middleman/.bashrc"
RUN echo "eval \"$(rv shell init bash)\"" >> ~/.bashrc
COPY . /home/middleman
RUN curl --proto '=https' --tlsv1.2 -LsSf https://github.com/spinel-coop/rv/releases/download/v0.2.0/rv-installer.sh | sh && \
rv ruby install 3.4.7 && \
rv ruby pin ruby-3.4.7 && \
gem update --system 3.7.2 && \
bundle update && \
bundle install
ENTRYPOINT ["bundle", "exec", "middleman", "server", "--bind-address", "0.0.0.0"]
