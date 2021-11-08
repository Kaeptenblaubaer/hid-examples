# syntax=docker/dockerfile:1.3-labs
FROM gitpod/workspace-base

USER root

# Install Nix
RUN addgroup --system nixbld \
  && adduser gitpod nixbld \
  && for i in $(seq 1 30); do useradd -ms /bin/bash nixbld$i &&  adduser nixbld$i nixbld; done \
  && mkdir -m 0755 /nix && chown gitpod /nix \
  && mkdir -p /etc/nix && echo 'sandbox = false' > /etc/nix/nix.conf
  
# Install Nix
CMD /bin/bash -l
USER gitpod
ENV USER gitpod
WORKDIR /home/gitpod

RUN touch .bash_profile \
 && curl https://nixos.org/releases/nix/nix-2.3.14/install | sh

RUN echo '. /home/gitpod/.nix-profile/etc/profile.d/nix.sh' >> /home/gitpod/.bashrc
RUN mkdir -p /home/gitpod/.config/nixpkgs \
  && echo \
  '{ allowUnfree = true; allowBroken = true; \n\
   packageOverrides = super: let self = super.pkgs; in \n\
  { \n\
    myHaskellEnv = self.haskell.packages.ghc7102.ghcWithPackages \n\
    (haskellPackages: with haskellPackages; [ \n\
    # libraries \n\
    arrows async cgi criterion \n\
    # tools \n\
    cabal-install haskintex ]); \n\
   }; \n\
  }' > /home/gitpod/.config/nixpkgs/config.nix







# Install cachix
RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && nix-env -iA cachix -f https://cachix.org/api/v1/install \
  && cachix use cachix

# Install git
RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && nix-env -i git git-lfs

# Install stack
RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && nix-env -f "<nixpkgs>" -iA stack \
  && nix-env -f "<nixpkgs>" -iA cabal-install 

# Install direnv
RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && nix-env -i direnv \
  && direnv hook bash >> /home/gitpod/.bashrc \
  && mkdir -p .config/direnv \
  && echo '[whitelist]' > .config/direnv/config.toml \
  && echo 'prefix = [ "/workspace" ]' >> .config/direnv/config.toml 
  
