#!/bin/bash

# git clone https://github.com/paxtonhare/demo-magic.git
source ~/src/demos/demo-magic/demo-magic.sh
TYPE_SPEED=100
PROMPT_TIMEOUT=2
#DEMO_PROMPT="${CYAN}\W${GREEN}➜ ${COLOR_RESET}"
DEMO_PROMPT="${CYAN}\W ${GREEN}$ ${COLOR_RESET}"
DEMO_COMMENT_COLOR=$GREEN
GIT_ROOT=$(git rev-parse --show-toplevel)
DEMO_ROOT=$GIT_ROOT

# https://archive.zhimingwang.org/blog/2015-09-21-zsh-51-and-bracketed-paste.html
#unset zle_bracketed_paste
clear

p "# 👀 here are all the things..."
pei tree -L 3 $DEMO_ROOT
p

p "# 💡 Keeping MachineConfigs in git is a good idea, but because file contents"
p "#    are in URL or base64 encoded format, making changes can be cumbersome."
p

p "# ⚙️ Here is a contrived example MachineConfig which writes a message to a file."
pei "bat -H 16 -H 19 -l yaml machineconfigs/99-worker-message.yaml"
p

p "# 🔥 Butane files look like a MachineConfig, but file contents can be inline,"
p "#    plaintext, or even included from a standalone file."
p "#    By treating butane files as the source of truth, we can more easily make changes."
p

p "# 🔥 Here is a butane file for generating the above MachineConfig"
pei "bat -H 15 -l yaml machineconfigs/butane/99-worker-message.bu"
p

p "# 📓 Note that the included file is referenced by only the filename 'message.txt'."
p "#    The path will be provided to the butane command later."
p
p "# 🔍 Here is the message.txt file included by the butane file"
pei "bat  machineconfigs/inc/message.txt"
p

p "# ✏️ Now imagine we have to make a change to the message.txt file"
pei "date >> machineconfigs/inc/message.txt"
pei "bat machineconfigs/inc/message.txt"
p

p "# 🙋‍♂️ But now we have a new problem. How do we make sure the MachineConfig"
p "#    is up to date with the new message? 🤔"
p
p "# 👉 The short non-scaling answer is:"
DEMO_COMMENT_COLOR=$RED
p "# butane -d inc < butane/99-worker-message.bu > 99-worker-message.yaml"
DEMO_COMMENT_COLOR=$GREEN
p

p "# 🔧 Here is a Makefile which deduces the dependencies between every machineconfig,"
p "#    butane file, and any included files. Any MachineConfig file older than"
p "#    any of its dependencies is rebuilt."
p

pei "bat machineconfigs/Makefile"
p

p "# 🎯 Each Butane file is searched for includes which are noted as a dependency in a deps file."
p "#    The default 'all' target builds any stale or missing corresponding YAML file for each BU."
p
p "# ⚙️ Here is the dependency file for the above MachineConfig"
pei "bat machineconfigs/.deps/99-worker-message.d"
p

p "# 🔍 All the MachineConfigs already exist"
pei "ls machineconfigs"
p
p "# 🔧 Now use make to rebuild only the machineconfigs needing an update"
pei "make -C machineconfigs"
p
p "# ⚙️ Here is the updated machineconfig with the new message"
pei "bat machineconfigs/99-worker-message.yaml"
p

p "# ✍️ Now you can commit the changes to git and let the 🤖s take over."
p "git add machineconfigs"
p "git commit -m 'update message machineconfig'"
p

# cleanup
git checkout -- machineconfigs/inc/message.txt
git checkout -- machineconfigs/99-worker-message.yaml