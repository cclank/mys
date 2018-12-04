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

kubeadm init --token-ttl 0 --kubernetes-version 1.10.5 --apiserver-advertise-address=192.168.56.20 --service-cidr=10.163.240.0/20 --pod-network-cidr=192.168.0.0/16



[ERROR Hostname]: hostname "k8s_m2" a DNS-1123 subdomain must consist of lower case alphanumeric characters, '-' or '.', and must start and end with an alphanumeric character

[ERROR Hostname] a DNS-1123 subdomain must consist of lower case alphanumeric characters


kubeadm join 192.168.56.20:6443 --token tyijkp.4p8201tfth647uar --discovery-token-ca-cert-hash sha256:7d3e8d523c6cdeb5e55d02aaf54501e90923db27abf1b52eb333d61fed5eafc7





[root@k8sm2 tasks]# more main.yml.bak 
---

- name: copy script files to host
  copy: src={{ item }} dest=/tmp/
  with_items:
    - hadoop_v2.sh
    - mkfs_kubev2.sh
    - bonding.sh

- name: copy init_cluster_bcc.sh to host
  template: src=init_cluster_bcc.sh dest=/tmp/

- name: exec common scripts
  command: chdir=/tmp /usr/bin/sh {{ item }}
  with_items:
    - hadoop_v2.sh
    - bonding.sh

- name: init cluster
  command: chdir=/tmp /usr/bin/sh init_cluster_bcc.sh {{ product_line }} {{ cluster_name }}

- include: mkfs_kube.yml
  when: "'raid10' in group_names or 'raid10_4' in group_names"

- name: remove init scripts
  file: dest=/tmp/{{ item }} state=absent
  with_items:
    - hadoop_v2.sh
    - init_cluster_bcc.sh
    - mkfs_kubev2.sh
    - bonding.sh
  #notify:
  #  - reboot server

ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.56.30

8212078300

The host key sent by the server is different from the host key 
stored in the host key database for 192.168.56.30 (192.168.56.30), port 22.
This may mean that a hostile party has "hijacked" your connection 
and you are not connected to the server you specified.


