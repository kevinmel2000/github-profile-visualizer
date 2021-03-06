#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
CURRENT_DATE=`date +%Y-%m-%d`
COMMIT_MESSAGE="Profile status at ${CURRENT_DATE}"

pushd $CURRENT_DIR
  # Get number of repositories
  num_repo=$(./ok.sh -j list_repos ${GITHUB_USER} | grep "full_name" | wc -l | tr -d ' ')

  #Get number of followers
  num_followers=$(./ok.sh -j list_followers | grep "followers_url" | wc -l | tr -d ' ')

  # Get number of following
  num_following=$(./ok.sh -j list_following | grep "following_url" | wc -l | tr -d ' ')

  # Append to file
  echo "${CURRENT_DATE},${num_repo}" >> num_repo.txt
  echo "${CURRENT_DATE},${num_followers}" >> follower.txt
  echo "${CURRENT_DATE},${num_following}" >> following.txt

  # Commit
  git add num_repo.txt follower.txt following.txt
  git commit -m "${COMMIT_MESSAGE}"
  git push origin master 
popd

