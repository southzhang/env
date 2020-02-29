
#GOROOT=~/programs/go
#GOROOT=~/Programs/go1.10

export GOPATH=~/Documents/workspace/GOPATH
export PATH=$GOPATH/bin:$PATH


# export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct



#export GOROOT
#export GOPATH
#export PATH

#function initgo () {
#	export GOPATH=`pwd`
#}


function setgopath() {
	DIR=`pwd`
	echo $DIR
	echo $HOME
	echo $GOPATH

	while [ $DIR != $HOME ]; do
		#echo $DIR
		if [ -d ${DIR}/src ]; then
			break
		else
			DIR=`dirname ${DIR}`
		fi
	done
	
	if [ $DIR = $HOME ]; then
		echo "Can't find a valid GOPATH"
	else
		export GOPATH=${DIR}
		echo "Set env GOPATH as ${DIR}"
		export PATH=${DIR}/bin:${PATH}
		echo "Add PATH: ${DIR}/bin"
	fi
}

function addgopath () {

	DIR=`pwd`
	echo $DIR
	#echo $HOME
	
	while [ $DIR != $HOME ]; do
		#echo $DIR
		if [ -d ${DIR}/src ]; then
			break
		else
			DIR=`dirname ${DIR}`
		fi
	done
	
	if [ $DIR = $HOME ]; then
		echo "Can't find a valid GOPATH"
	else
		export GOPATH=${DIR}:${GOPATH}
		echo "Set env GOPATH as ${DIR}"
		export PATH=${DIR}/bin:${PATH}
		echo "Add PATH: ${DIR}/bin"
	fi
}

function gfw () {
	export http_proxy=socks5://127.0.0.1:1080
	export https_proxy=socks5://127.0.0.1:1080
}

function chaincodezip() {
	echo "==> 开始对cabbage 打包压缩..."

	zip_path=~/Documents/workspace
	source_path=~/Documents/workspace/GOPATH/src/pingan.com/fimax/cabbage

	DIR=`pwd`
	target_path=/tmp/tmpwsx123/pingan.com/fimax
	rm -rf /tmp/tmpwsx123
	mkdir -p $target_path

	cp -r $source_path $target_path
	cd $target_path/cabbage
	rm -rf .git
	rm -rf .idea
	rm -f .gitignore

	cd ../../..
	pwd
	zip -qr $zip_path/cabbage.zip ./*
	cd ..
	rm -rf tmpwsx123
	cd $DIR
	echo "==> cabbage 打包压缩 zip 成功"
}
