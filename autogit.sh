cd ~/bash_shell/
git pull
echo "Commit made on $(date)" >> commit-log-$(date +'%Y%m%d').txt
git add commit-log-$(date +'%Y%m%d').txt
git commit -m "x502c bash shell Automated commit on $(date)"
git push
