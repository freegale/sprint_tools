#! /bin/bash
#step 1
function RepoBackup(){
    echo "==========================仓库$1备份开始============================"
    # 切换到远程master的最新代码分支
    cd ./$1
    git fetch 

    temp_branch_name=$(cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 32)
    git checkout -b $temp_branch_name remotes/origin/master

    # 在最新代码分支上创建Tag，并推送到远程
    bak_tag_hash=$(git rev-parse --verify --quiet v$2BAK)
    # 如果本地存在备份Tag，从本地和远程删除该Tag
    if [ -n "$bak_tag_hash" ]
    then 
        git tag -d v$2BAK
        git push origin :refs/tags/v$2BAK
    fi

    # 新建备份Tag并且推送到远程
    git tag -a v$2BAK -m "迭代$2版本升级前备份"
    git push origin v$2BAK

    # 删除临时创建的分支
    git checkout -
    git branch -d $temp_branch_name
    echo "==========================仓库$1备份完成============================"
    cd ..
}

cd ~/Documents/workspace/git/
version_no=$1
for dir in $(ls -d */)
do 
    RepoBackup $dir $version_no
done
# dir_name="testofversioncontrol"
# repoBackup $dir_name $version_no