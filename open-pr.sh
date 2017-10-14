#!/bin/bash
## refs: http://int128.hatenablog.com/entry/2015/05/30/151447
HUB="2.2.9"

mkdir -p "$HOME/.config"
set +x
echo "https://${GH_ACCESS_TOKEN}:@github.com" > "$HOME/.config/git-credential"
echo "github.com:
- oauth_token: $GH_ACCESS_TOKEN
  user: $GH_USER" > "$HOME/.config/hub"
unset GH_ACCESS_TOKEN
set -x

git config --global user.name "${GH_USER}"
git config --global user.email "${GH_USER}@users.noreply.github.com"
git config --global core.autocrlf "input"
git config --global hub.protocol "https"
git config --global credential.helper "store --file=$HOME/config/git-credential"

curl -LO "https://github.com/github/hub/releases/download/v$HUB/hub-linux-amd64-$HUB.tgz"
tar -C "$HOME" -zxf "hub-linux-amd64-$HUB"

hub clone "ysknmt/COMEVIZZ" _
cd _
# TODO: change branch name to unique
hub checkout -b "gitbook"
hub add .
hub commit -m "update gitbook html"

# TODO: change branch name to unique
hub push origin "gitbook"
# TODO: Include original pull request number in message If we could
hub pull-request -m "Generate HTML documents"
cd ..