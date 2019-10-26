# bash scripts

## env_setup.sh - environment setup script

sets up user scripts, as those inside `env` folder. 
How to setup, example:
* identify the user local bin folder, in macOS: `~/.local/bin`, define the env variable `SYS_SCRIPTS_TARGET` with it
* create folder `~/SYS`, think of it as the `SYS` env var for now
* checkout these scripts project to some folder, e.g., `~/Documents/github/bash-scripts`, think of it as the `SYS_SCRIPTS_SRC` env var for now;
* create the link `ln -s $SYS_SCRIPTS_SRC/bash/env_setup.sh $SYS/setup.sh`
* add that link to a bashrc or bash profile user file with a following line: ```source "$SYS/setup.sh"```
* create a `$SYS/include` file exporting the variables `SYS_SCRIPTS_SRC`, `SYS_SCRIPTS_TARGET`, and any other that you find useful from now on




