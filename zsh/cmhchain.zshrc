DIR2="/Users/$USER/Documents/workspace/PingAn-Projects/deployFimax/script/"
DIR3="/Users/$USER/Documents/workspace/PingAn-Projects/deployFimax3.0/script/"


bl() {
    cat << EOF
Commands:

    bl-open             # 必须执行，需要一个参数，2：使用fimax2.0 3:使用fimax3.0
    bl-deploy           # 只部署 cabbage
    bl-deploy-new-canna # 只部署 canna, 单 channel
    bl-deploy-canna     # 需要先部署cabbage, 再部署 canna 
    bl-clear            # 删除链环境
    bl-upgrade-cc       # 升级 ChainCode
    bl-chaincode-clear  # 清除无效的chaincode docker 容器， 排除 mysql 容器
    bl-log              # 查看 peer log
    bl-cmd-remove       # docker rm $(docker ps -a | grep 'Exited (0)' | grep -v '6e5e2644c551' | awk '{print $1}') 

EOF
}


function bl-open() {
    echo $1

    if [ "$1" = "2" ]; then 
        cd $DIR2
    elif [ "$1" = "3" ]; then 
        cd $DIR3
    else 
        echo "parameters error."
        exit 1
    fi
}


function bl-deploy () {
    export GO111MODULE=off

    nohup goreman start > ../logs/goreman.log 2>&1 &
    echo "sleep 5 seconds..."
    sleep 5

    echo "start deploy achannel..."
    ./channel.sh -C achannel -p 1.1 -o 1 > ../logs/achannel.log 2>&1f
    # echo "start deploy bchannel..."
    # ./channel.sh -C bchannel -p 1.1 -o 1 > ../logs/bchannel.log 2>&1

    echo "start deploy cabbage in achannel..."
    ./plusCC.sh -p 1.1 -o 1 -e cc/cabbage.env > ../logs/cabbage.log 2>&1
    # echo "start deploy cabbage in bchannel..."
    # ./plusCC.sh -p 1.1 -o 1 -e cc/cabbage2.env > ../logs/cabbage2.log 2>&1
}

function bl-clear () { 
    ./generateFb.sh
    ./killByPort.sh 6200
    ./killByPort.sh 6661
}

function bl-deploy-new-canna() {

    nohup goreman start > ../logs/goreman.log 2>&1 &
    echo "sleep 5 seconds..."
    sleep 5

    echo "start deploy achannel..."
    ./channel.sh -C achannel -p 1.1 -o 1 > ../logs/achannel.log 2>&1f

    echo "start deploy canna in achannel..."
    ./plusCC.sh -p 1.1 -o 1 -e cc/canna.env > ../logs/canna.log 2>&1
}


function bl-deploy-canna() {
    echo "start deploy canna in achannel..."
    ./plusCC.sh -p 1.1 -o 1 -e cc/canna.env > ../logs/canna.log 2>&1
}

function bl-upgrade-cc () {

    echo "==> start upgrade chaincode..."	
    echo $1

    if [ $# != 1 ] ; then 
        echo "must input chaincode name" 
        exit 1; 
    fi 

    if [ "$1" = "cabbage" ]; then 
        echo "start upgrade cabbage in achannel..."
        ./upgradeCC.sh -p 1.1 -o 1 -e cc/cabbage.env > ../logs/cabbage.log 2>&1
        # echo "start upgrade cabbage in bchannel..."
        # ./upgradeCC.sh -p 1.1 -o 1 -e cc/cabbage2.env > ../logs/cabbage2.log 2>&1
    elif [ "$1" = "canna" ]; then 
        echo "start upgrade canna in achannel..."
        ./upgradeCC.sh -p 1.1 -o 1 -e cc/canna.env > ../logs/canna.log 2>&1
    else 
        echo "parameters error."
        exit 1
    fi
}

function bl-chaincode-clear() {
    echo "开始清除无效的chaincode docker 容器， 排除 mysql 容器"
    ids=`docker ps -a | grep 'Exited (0)' | grep -v '6e5e2644c551' | awk '{print $1}'`
    # docker rm ids
    echo ids
    # docker rm $(docker ps -a | grep 'Exited (0)' | grep -v '6e5e2644c551' | awk '{print $1}')
}

function bl-log() {
    
    tail -f 100 ../logs/goreman.log
}
