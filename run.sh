#!/bin/sh -l
set -e

git config --global user.email "$GITHUB_USER_EMAIL"
git config --global user.name "$GITHUB_USERNAME"

git clone "https://$4@github.com/$5.git"  "$RUNNER_TEMP/infra-as-code-repo"
wget https://raw.githubusercontent.com/DenisPalnitsky/gitops-release/master/replace-key.py
python replace-key.py --file $RUNNER_TEMP/infra-as-code-repo/"$1" --key $2 --value $3
cd "$RUNNER_TEMP/infra-as-code-repo"
if [ -n "$6" ]; then
  git checkout "$6" 2>/dev/null || git checkout -b "$6"
fi
git add .
git commit -m "Updating of key $2 in $1"
git push -u origin "$6"
