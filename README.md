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
