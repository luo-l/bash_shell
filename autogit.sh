cd ~/bash_shell/
git pull
echo "Commit made on $(date)" >> commit-log-$(date +'%Y%m%d').txt
LAST_30_DAYS=$(date -d '30 days ago' --utc +%Y-%m-%d)
COMMIT_COUNT=$(git rev-list --count --after="$LAST_30_DAYS" HEAD)
echo "Commit Count in Last 30 Days: $COMMIT_COUNT" >> commit-log-$(date +'%Y%m%d').txt
git add commit-log-$(date +'%Y%m%d').txt

git commit -m "x502c bash shell Automated commit on $(date)"
git push
