# mys

echo "# mys" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin git@github.com:cclank/mys.git
git push -u origin master


新项目中，添加所有文件很普遍，我们可以使用 git add . 命令来添加当前项目的所有文件。

git status 显示你上次提交更新后的更改或者写入缓存的改动， 而 git diff 一行一行地显示这些改动具体是啥。

使用 git add 命令将想要快照的内容写入缓存区， 而执行 git commit 将缓存区内容添加到仓库中。

如果你觉得 git add 提交缓存的流程太过繁琐，Git 也允许你用 -a 选项跳过这一步

如果你觉得 git add 提交缓存的流程太过繁琐，Git 也允许你用 -a 选项跳过这一步

git pull 相当于 git fetch + git merge

git commit、git push、git pull、 git fetch、git merge 的含义与区别

 git commit：是将本地修改过的文件提交到本地库中；
 git push：是将本地库中的最新信息发送给远程库；
 git pull：是从远程获取最新版本到本地，并自动merge；
 git fetch：是从远程获取最新版本到本地，不会自动merge；
 git merge：是用于从指定的commit(s)合并到当前分支，用来合并两个分支；
