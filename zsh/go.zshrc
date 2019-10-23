
#GOROOT=~/programs/go
#GOROOT=~/Programs/go1.10

export GOPATH=~/Documents/workspace/GOPATH
export PATH=$GOPATH/bin:$PATH

# # Enable the go modules feature
# export GO111MODULE=on
# Set the GOPROXY environment variable
# export GOPROXY=https://goproxy.cn



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


