unction jgrep()
{
    find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.java" -print0 | xargs -0 grep --color -n "$@"
}
这个是位于Android源码build/envsetup.sh中的jgrep函数，用于搜索java文件内容，是经常使用的一个函数，是find结合grep的典型案例。如果已经确定了搜索内容在java文件中，那么相比于直接用grep进行全局搜索，这种先搜索所有的java文件，再在其中搜索内容的方式可以显著提高效率。

我们先来解析一下这个函数：
find .                                ：在当前目录搜索
-o                                     : 或，并列多个条件
-name .repo –prune        ： 忽略.repo目录（git库相关）
-name .git –prune           ： 忽略.git目录（git库相关）
-name out –prune           ： 忽略out目录（编译生成的目录）ds
-type f                             ：指定文件类型为普通文件
-name "*\.java"              ： 指定匹配的文件名为.java文件
-print0 | xargs -0             ： 忽略搜索中可能出现的错误信息，并将搜索到的文件作为结果向后传递并继续执行
grep --color –n               ：用grep在之前搜索到的文件中进行内容搜索，输出行号并标识颜色
"$@"                              ：表示在使用jgrep函数时输入的参数，这里即为grep搜索的内容（本人未搞清这里为什么写$@而不是$*、$1）
这么分析下来，这个函数的意思应该很容易就可以理解了，在这个基础上，大家可以根据实际情况举一反三，以写出适合


#文件内容搜索函数sep
#参数1 必选 搜索内容
#参数2 可选 前缀-t 内容所在的文件类型（即文件后缀名，如java），缺省为所有文件类型
#参数3 可选 前缀-f 指定搜索的目录 缺省为当前目录及所有子目录
#用例 sep "new ITelecomService.Stub"  -t  java xml  –f  packages/ frameworks/
#用例解析 在packages、frameworks目录中的所有java、xml文件中搜索"new ITelecomService.Stub"
function sep()
{
#文件内容=第一个参数
se_content=$1
#文件类型和搜索目录暂时=空
se_fileType=""
se_folder=""
#shift的作用是将第一个参数移除，即当前函数输入的第二个参数变成第一个参数，第三个变成第二个，以此类推
shift
#判断当前第一个参数是否为-t，即文件类型是否指定，如果指定就取出文件类型放入se_fileType变量中
if [ "$1" = "-t" ];then
    #如果是-t就将这个参数移除
    shift
    while ( [ "$1" != "-f" ] && [ -n "$1" ] )
    do
        se_fileType="$se_fileType $1"
        shift
    done
fi
#判断当前第一个参数是否为-f，即搜索目录是否指定，如果指定就取出搜索目录放入se_folder变量中
if [ "$1" = "-f" ];then
    #如果是-f就将这个参数移除
    shift
    while [ -n "$1" ]
    do
        se_folder="$se_folder $1"
        shift
    done
fi
#判断文件类型是否为空，不为空则建立循环分别搜索指定的文件类型
if [ -z $se_fileType ];then
    #这里如果搜索目录为空find会自动搜索当前目录及子目录，因此不用再做判断
         #这里用到了egrep而不是grep，方便输入搜索内容时直接使用正则表达式
    find $se_folder -type f -print0 | xargs -0 egrep -n --color "$se_content"
else
    for ft in $se_fileType
    do
        find $se_folder -type f -name "*.$ft" -print0 | xargs -0 egrep -n --color "$se_content"
    done
fi
}
这个函数整体而言比较简单，加上其中的注释，想必大家可以很容易理解，在这个基础之上我们还可以添加其他参数，比如是否精确匹配等，这里不再具体说明了。
关于函数如何使用：写到.sh文件中再用source命令导入即可在命令行直接使用




DEVICE2=$(ls -l /sys/class/net |grep `lspci |grep -E "10-Gigabit|10GbE|SFP+|Lx" |awk '(NR==2){print $1}'` |awk -F"/" '{print $NF}')


MAC（Media Access Control或者Medium Access Control）地址，意译为媒体访问控制，或称为物理地址、硬件地址，用来定义网络设备的位置。在OSI模型中，第三层网络层负责 IP地址，第二层数据链路层则负责 MAC地址。
MAC地址是网卡决定的，是固定的。因此一个主机会有一个MAC地址，而每个网络位置会有一个专属于它的IP地址。为确保MAC地址的唯一性，以太网卡制造商将MAC地址固化到网卡中。地址的前半部分（24位）标识网卡的制造商，由IEEE分配，称为OUI（组织唯一标识符）；地址的后半部分由网卡制造商为其网卡分配一个唯一的编号。
MAC地址为电脑网卡的物理地址，每个网卡拥有全球唯一的MAC，以示区别。
格式通常为6个字节的二进制代码（以6组16进制数表示，共占6个字节），格式为XX-XX-XX-XX-XX-XX 或者 XX:XX:XX:XX:XX:XX
比如： ED-DD-4D-45-5A-9F

匹配模式："^([A-Fa-f0-9]{2}[-,:]){5}[A-Fa-f0-9]{2}$"

^ 代表开头

[A-Fa-f0-9]{2}  表示由两个16进进字符制组成 

[-,:] 分隔符可能 为 " : "或 " - "

{5} 前面由5个类似格式的字段组成，即 5个 XX- 或 XX:

[A-Fa-f0-9]{2} 表示由两个16进进字符制组成结尾

$ 代表结尾

grep -P -o "^([A-Fa-f0-9]{2}[-,:]){5}[A-Fa-f0-9]{2}$" /sys/class/net/$DEVICE1/address




















