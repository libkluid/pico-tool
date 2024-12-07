install:
  git clone https://github.com/raspberrypi/pico-sdk .sdk

init PROJECT:
  ./.scripts/init.sh {{PROJECT}}
  cd {{PROJECT}}
  git submodule update --init --recursive
