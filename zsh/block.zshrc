
alias bl-cluster=/Users/zhangwenming/Documents/workspace/blockchainDeployment_local/scripts/cluster.sh


bl() {
    cat << EOF
Commands:

    bl-init: 初始化一个新 Chain 环境
    bl-deploy-all: 部署 Chain 环境
    bl-stop-clear-all: 停止并清空 Chain 环境
    bl-chaincode-upgrade: 升级 ChainCode

    bl-add-channel: 新增一个 channel

EOF
}

function bl-init() {
    echo "开始初始化 Chain 环境"
    bl-cluster init-env
}

function bl-deploy-all() {
    echo "开始部署 Chain 环境"
    bl-cluster deploy-all
}

function bl-stop-clear-all() {
    echo "停止并清空 Chain 环境"
    bl-cluster stop-clear all
}

function bl-chaincode-upgrade() {
    declare random=$RANDOM
    echo "开始升级 ChainCode, 版本为 $random"
	bl-cluster -v $random upgrade-chaincode
}

function bl-add-channel() {
    channelName=$1
    echo "开始新增一个 channel=$channelName"

    echo "1. 创建通道的交易"
    bl-cluster -C $channelName generate-block-and-tx
    echo "2. 创建通道的以及将 peer 加入通道"
    bl-cluster -C $channelName deploy-chain
    echo "3. 部署 chaincode"
    bl-cluster -C $channelName -k deploy-chaincode
}


export CATHAYA_CONFIG_PATH=~/.cathaya





