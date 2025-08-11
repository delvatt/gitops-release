#!/bin/sh -l
set -e

git config --global user.email "$GITHUB_USER_EMAIL"
git config --global user.name "$GITHUB_USERNAME"

git clone "https://$4@github.com/$5.git"  "$RUNNER_TEMP/infra-as-code-repo"

git --no-pager branch -a -v

if [ -n "$6" ]; then
  git checkout -b "$6" remotes/origin/$6
fi

wget https://raw.githubusercontent.com/delvatt/gitops-release/master/replace-key.py
python replace-key.py --file $RUNNER_TEMP/infra-as-code-repo/"$1" --key $2 --value $3

cd "$RUNNER_TEMP/infra-as-code-repo"
if [ -n "$7" ]; then
  git checkout "$7" 2>/dev/null || git checkout -b "$7"
fi

git add .
git commit -m "Updating of key $2 in $1"
git push -u origin "$7"
