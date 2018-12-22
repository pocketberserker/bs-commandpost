FROM ocaml/opam:ubuntu

RUN opam update && \
  opam switch 4.02.3 && \
  sudo sh -c "echo \"eval `opam config env`\" > /etc/profile.d/opam.sh" && \
  rm -rf /home/opam/opam-repository

RUN (curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -) && \
  sudo apt-get install -y nodejs --no-install-recommends && \
  sudo apt-get clean && \
  sudo rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
