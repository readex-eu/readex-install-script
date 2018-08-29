#!/bin/bash
# version copmarison from https://stackoverflow.com/questions/4023830/how-to-compare-two-strings-in-dot-separated-version-format-in-bash

# The compiler suite used to build this package in
# non-cross-compiling environments. Needs to be in $PATH.
# <gcc[default]|ibm|intel|pgi|studio>
COMPILER=gcc

# The MPI compiler suite to build this package in non
# cross-compiling mode. Usually autodetected. Needs to be
# in $PATH.
# <bullxmpi|hp|ibmpoe|intel|intel2|intel3|intelpoe|lam|
# mpibull2|mpich|mpich2|mpich3|openmpi|platform|scali|
# sgimpt|sun>
MPI=openmpi

# If you want to build scorep with libcudart but do not
# have a libcudart in a standard location then you need
# to explicitly specify the directory where it is
# installed. On non-cross-compile systems we search the
# system include and lib paths per default [yes], on
# cross-compile systems however,you have to specify a
# path [no].
# <Path to libcudart installation>
CUDA=

# If papi.h is not installed in the default location,
# specify the dirname where it can be found.
# <path to PAPI include>
PAPI_INCLUDE=

# If libpapi.* is not installed in the default location,
# specify the dirname where it can be found.
# <path to PAPI lib>
PAPI_LIB=

# Specifies the path to the program database toolkit
# (PDT) binaries, e.g., cparse.
# <path to PDT bin>
PDT=

# <slurm|superMUC|interactive>
STARTER=

# path to ACE include
ACE_INCLUDE=

# path to ACE lib
ACE_LIB=

# path to Boost include
# need for version check
BOOST_INCLUDE=

# path to Boost lib
BOOST_LIB=

# path to Cereal include
CEREAL_INCLUDE=

if [[ -z $1 ]]; then
	INSTALLATION_PATH=/opt
else
	shopt -s extglob
	INSTALLATION_PATH=${INSTALLATION_PATH%%+(/)}
fi

DATE=`date '+%Y-%m-%d'`

DOWNLOAD_SCOREP=http://www.readex.eu/wp-content/uploads/software/ScoreP.tar.gz
DOWNLOAD_PERISCOPE=http://www.readex.eu/wp-content/uploads/software/PTF.tar.gz
DOWNLOAD_SCOREP_DEV=http://www.readex.eu/wp-content/uploads/2018/04/scorep-dev-06.tar.gz
DOWNLOAD_RRL=http://www.readex.eu/wp-content/uploads/software/RRL.tar.gz
DOWNLOAD_PCPS=http://www.readex.eu/wp-content/uploads/software/PCPs.tar.gz
DOWNLOAD_ATPS=http://www.readex.eu/wp-content/uploads/software/ATP.tar.gz
DOWNLOAD_CLUSTER_PREDICTION=http://www.readex.eu/wp-content/uploads/software/Cluster_Prediction.tar.gz
DOWNLOAD_CMAKE=https://cmake.org/files/v3.11/cmake-3.11.4.tar.gz
DOWNLOAD_BOOST=https://dl.bintray.com/boostorg/release/1.65.1/source/boost_1_65_1.tar.gz
DOWNLOAD_ACE=https://github.com/DOCGroup/ACE_TAO/releases/download/ACE%2BTAO-6_5_1/ACE.tar.gz
DOWNLOAD_PYTHON=https://github.com/python/cpython/archive/v3.7.0.tar.gz
DOWNLOAD_FLEX=https://netcologne.dl.sourceforge.net/project/flex/flex-2.5.39.tar.gz
DOWNLOAD_BISON=https://ftp.gnu.org/gnu/bison/bison-3.0.4.tar.gz
DOWNLOAD_CEREAL=https://github.com/USCiLab/cereal/archive/v1.2.1.tar.gz
DOWNLOAD_PEEP=https://github.com/score-p/scorep_plugin_x86_energy.git
DOWNLOAD_MODULE=https://netcologne.dl.sourceforge.net/projects/modules/files/Modules/modules-4.1.4/modules-4.1.4.tar.gz

ARCHIVE_FILE_SCOREP=${DOWNLOAD_SCOREP##*/}
ARCHIVE_FILE_PERISCOPE=${DOWNLOAD_PERISCOPE##*/}
ARCHIVE_FILE_SCOREP_DEV=${DOWNLOAD_SCOREP_DEV##*/}
ARCHIVE_FILE_RRL=${DOWNLOAD_RRL##*/}
ARCHIVE_FILE_PCPS=${DOWNLOAD_PCPS##*/}
ARCHIVE_FILE_ATPS=${DOWNLOAD_ATPS##*/}
ARCHIVE_FILE_CLUSTER_PREDICTION=${DOWNLOAD_CLUSTER_PREDICTION##*/}
ARCHIVE_FILE_CMAKE=${DOWNLOAD_CMAKE##*/}
ARCHIVE_FILE_BOOST=${DOWNLOAD_BOOST##*/}
ARCHIVE_FILE_ACE=${DOWNLOAD_ACE##*/}
ARCHIVE_FILE_FLEX=${DOWNLOAD_FLEX##*/}
ARCHIVE_FILE_BISON=${DOWNLOAD_BISON##*/}
ARCHIVE_FILE_PYTHON=${DOWNLOAD_PYTHON##*/}
ARCHIVE_FILE_CEREAL=${DOWNLOAD_CEREAL##*/}
ARCHIVE_FILE_MODULE=${DOWNLOAD_MODULE##*/}


DIR_SCOREP=${ARCHIVE_FILE_SCOREP%.tar.gz}
DIR_PERISCOPE=${ARCHIVE_FILE_PERISCOPE%.tar.gz}
DIR_SCOREP_DEV=${ARCHIVE_FILE_SCOREP_DEV%.tar.gz}
DIR_RRL=${ARCHIVE_FILE_RRL%.tar.gz}
DIR_PCPS=${ARCHIVE_FILE_PCPS%.tar.gz}
DIR_ATPS=${ARCHIVE_FILE_ATPS%.tar.gz}
DIR_CLUSTER_PREDICTION=${ARCHIVE_FILE_CLUSTER_PREDICTION%.tar.gz}
DIR_CMAKE=${ARCHIVE_FILE_CMAKE%.tar.gz}
DIR_BOOST=${ARCHIVE_FILE_BOOST%.tar.gz}
DIR_ACE=ACE_wrappers
DIR_PEEP=scorep_plugin_x86_energy
DIR_FLEX=${ARCHIVE_FILE_FLEX%.tar.gz}
DIR_PYTHON=cpython-3.7.0
DIR_CEREAL=cereal-1.2.1
DIR_BISON=${ARCHIVE_FILE_BISON%.tar.gz}
DIR_MODULE=${ARCHIVE_FILE_MODULE%.tar.gz}

GCC_VERSION_A=6.3.0
GCC_VERSION_B=7.1.0
GFORTRAN_VERSION_A=6.3.0
GFORTRAN_VERSION_B=7.1.0
INTEL_VERSION_A=2017.2.174
INTEL_VERSION_B=2018.1.163
BISON_VERSION=3.0.4
PAPI_VERSION=5.5.1
PYTHON_VERSION=3.6
ACE_VERSION=6.5.0
FLEX_VERSION=2.5.39
BOOST_VERSION=1.65.1
CEREAL_VERSION=1.2.1
CMAKE_VERSION=3.11
LUA_VERSION=5.1

PACKAGE_FLEX=flex
PACKAGE_BISON=bison
PACKAGE_PYTHON=python3
PACKAGE_BOOST=libboost-all-dev
PACKAGE_CEREAL=libcereal-dev
PACKAGE_ACE=libace-dev
PACKAGE_PAPI=libpapi-dev
PACKAGE_LIBREADLINE=libreadline-dev
PACKAGE_LUA=liblua5.3-dev
PACKAGE_MAKEINFO=texinfo


#############################################################
#                                                           #
#                                                           #
#                      REQUIREMENTS                         #
#                                                           #
#                                                           #
#############################################################

echo "Checking requirements ..."

INSTALLATION_PATH_REQUIREMENTS=$INSTALLATION_PATH/requirements

vercomp () {
	if [[ $1 == $2 ]]
	then
		return 0
	fi
	local IFS=.
	local i ver1=($1) ver2=($2)
	# fill empty fields in ver1 with zeros
	for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
	do
		ver1[i]=0
	done
	for ((i=0; i<${#ver1[@]}; i++))
	do
		if [[ -z ${ver2[i]} ]]
		then
			# fill empty fields in ver2 with zeros
			ver2[i]=0
		fi
		if ((10#${ver1[i]} > 10#${ver2[i]}))
		then
			return 1
		fi
		if ((10#${ver1[i]} < 10#${ver2[i]}))
		then
			return 2
		fi
	done
	return 0
}

testvercomp () {
	vercomp $1 $2
	case $? in
		0) op='=';;
		1) op='>';;
		2) op='<';;
	esac
	if [[ $op != $3 ]]
	then
		echo "FAIL: Expected '$3', Actual '$op', Arg1 '$1', Arg2 '$2'"
	else
		echo "Pass: '$1 $op $2'"
	fi
}

packageversion () {
	VERSION=$(apt-cache policy $1 | grep Candidate)
	[[ $VERSION =~ ([0-9]+\.){2}[0-9]+ ]]
	VERSION="${BASH_REMATCH[0]}"
	if [ -n $VERSION ];then
		echo $VERSION
	else
		echo "0"
	fi
}

installCmake() {
	wget -c ${DOWNLOAD_CMAKE}
	rm -rf $DIR_CMAKE
	tar -xzf $ARCHIVE_FILE_CMAKE
	cd DIR_CMAKE
	./bootstrap --prefix=$INSTALLATION_PATH_REQUIREMENTS/cmake && make && make install
	if [ $? != 0 ]; then
		exit 1;
	fi
	export PATH=$INSTALLATION_PATH_REQUIREMENTS/cmake/bin:$PATH
	cd .. 
}

installBoost() {
	vercomp $(packageversion ${PACKAGE_BOOST}) $BOOST_VERSION
	case $? in
		0) 
			sudo apt-get install ${PACKAGE_BOOST} -y
			;;
		*) 
			wget -c ${DOWNLOAD_BOOST}
			rm -rf $DIR_BOOST
			tar -xzf $ARCHIVE_FILE_BOOST
			cd $DIR_BOOST
			./bootstrap.sh --prefix=$INSTALLATION_PATH_REQUIREMENTS/boost
			if [ $? != 0 ]; then
				exit 1;
			fi
			./b2 install
			if [ $? != 0 ]; then
				exit 1;
			fi
			BOOST_LIB=$INSTALLATION_PATH_REQUIREMENTS/boost/lib
			BOOST_INCLUDE=$INSTALLATION_PATH_REQUIREMENTS/boost/include
			cd ..	 
			;;
	esac
}

installACE() {
	vercomp $(packageversion ${PACKAGE_ACE}) $ACE_VERSION
	case $? in
		0) 
			sudo apt-get install ${PACKAGE_ACE} -y
			;;
		*) 
			wget -c ${DOWNLOAD_ACE}
			rm -rf $DIR_ACE
			tar -xzf $ARCHIVE_FILE_ACE
			cd $DIR_ACE
			export ACE_ROOT=$(pwd)
			cp ace/config-linux.h ace/config.h
			cp include/makeinclude/platform_linux.GNU include/makeinclude/platform_macros.GNU
			echo "INSTALL_PREFIX=$INSTALLATION_PATH/ACE_wrappers" >> include/makeinclude/platform_macros.GNU
			make && make install 
			if [ $? != 0 ]; then
				exit 1;
			fi
			ACE_LIB=$INSTALLATION_PATH_REQUIREMENTS/ACE_wrappers/lib
			ACE_INCLUDE=$INSTALLATION_PATH_REQUIREMENTS/ACE_wrappers/include
			cd ..
			;;
	esac

}

installCereal() {
	vercomp $(packageversion ${PACKAGE_CEREAL}) $CEREAL_VERSION
	case $? in
		0) 
			sudo apt-get install ${PACKAGE_CEREAL} -y
			;;
		*) 
			wget -c ${DOWNLOAD_CEREAL}
			rm -rf $DIR_CEREAL
			tar -xzf $ARCHIVE_FILE_CEREAL
			cd $DIR_CEREAL
			cp -r include/ $INSTALLATION_PATH_REQUIREMENTS/cereal-1.2.1
			if [ $? != 0 ]; then
				exit 1;
			fi
			cd ../..
			CEREAL_INCLUDE=$INSTALLATION_PATH_REQUIREMENTS/cereal-1.2.1/include
			;;
	esac
}

installBison() {
	vercomp $(packageversion ${PACKAGE_BISON}) $BISON_VERSION
	case $? in
		0) 
			sudo apt-get install ${PACKAGE_BISON} -y
			;;
		*) 
			wget -c ${DOWNLOAD_BISON}
			rm -rf $DIR_BISON
			tar -xzf $ARCHIVE_FILE_BISON
			cd $DIR_BISON
			mkdir build 
			cd build 
			../configure --prefix=$INSTALLATION_PATH_REQUIREMENTS/bison-3.0.4
			make && make install 
			if [ $? != 0 ]; then
				exit 1;
			fi
			export PATH=$INSTALLATION_PATH_REQUIREMENTS/bison-3.0.4/bin:$PATH
			cd ../..
			;;
	esac
}

installPython() {
	vercomp $(packageversion ${PACKAGE_PYTHON}) $PYTHON_VERSION
	case $? in
		0) 
			sudo apt-get install ${PACKAGE_PYTHON} -y
			;;
		*) 
			wget -c ${DOWNLOAD_PYTHON}
			rm -rf $DIR_PYTHON
			tar -xzf $ARCHIVE_FILE_PYTHON
			cd $DIR_PYTHON
			./configure --prefix=$INSTALLATION_PATH_REQUIREMENTS/Python
			make && make install
			if [ $? != 0 ]; then
				exit 1;
			fi
			cd ../
			export PATH=$INSTALLATION_PATH_REQUIREMENTS/Python/bin:$PATH
			;;
	esac

}

installFlex() {
	vercomp $(packageversion ${PACKAGE_FLEX}) $FLEX_VERSION
	case $? in
		0) 
			sudo apt-get install ${PACKAGE_FLEX} -y
			;;
		*) 
			wget -c ${DOWNLOAD_FLEX}
			rm -rf $DIR_FLEX
			tar -xzf $ARCHIVE_FILE_FLEX
			cd $DIR_FLEX
			mkdir build
			cd build
			../configure --prefix=$INSTALLATION_PATH_REQUIREMENTS/flex
			make && make install
			if [ $? != 0 ]; then
				exit 1;
			fi
			cd ../..
			export PATH=$INSTALLATION_PATH_REQUIREMENTS/flex/bin:$PATH
			;;
	esac
}

installLua() {
	sudo apt-get install ${PACKAGE_LUA} -y
}

installMakeinfo() {
	sudo apt-get install ${PACKAGE_MAKEINFO} -y
}

installPapi() {
	sudo apt-get install ${PACKAGE_PAPI} -y 
}

installLibreadline() {
	sudo apt-get install ${PACKAGE_LIBREADLINE} -y 
}

installModule() {
		TCL_VERSION_INSTALLED=$(ls /usr/lib/x86_64-linux-gnu | grep libtcl | head -n 1)

		if [[ ! -n $TCL_VERSION_INSTALLED ]]; then
			sudo apt-get install tcl-devel -y
		fi
		wget -c ${DOWNLOAD_MODULE}
		rm -rf $DIR_MODULE
		tar -xzf $ARCHIVE_FILE_MODULE
		cd $DIR_MODULE
		./configure --prefix=$INSTALLATION_PATH/Module --modulefilesdir=$INSTALLATION_PATH/modulefiles
		make && make install
		if [ $? != 0 ]; then
			exit 1;
		fi
		. $INSTALLATION_PATH/Module/init/profile.sh
		. $INSTALLATION_PATH/Module/init/profile.csh
		sudo ln -s $INSTALLATION_PATH/Module/init/profile.sh /etc/profile.d/modules.sh
		sudo ln -s $INSTALLATION_PATH/Module/init/profile.csh /etc/profile.d/modules.csh
		buildModulefile
		mkdir $INSTALLATION_PATH/modulefiles/Readex
		mv ${MPI}_${COMPILER_PATH} $INSTALLATION_PATH/modulefiles/Readex/${MPI}_${COMPILER_PATH}
		cd ../
}

buildModulefile() {
	touch ${MPI}_$COMPILER_PATH
	echo "#%Module1.0######################################################################" >> Readex
	echo "## Readex modulefile" >> Readex
	echo "proc ModulesHelp { } {" >> Readex
    echo "	puts stderr \"\\tThe Dot Module\\n\"" >> Readex
    echo "	puts stderr \"\\tThis module adds the current working directory to your path.\"" >> Readex
	echo "}" >> Readex
	echo "module-whatis   \"adds all necessary directories to your PATH and LD_LIBRARY_PATH environment variable\" " >> Readex
	echo "append-path     PATH            $INSTALLATION_PATH_SCOREP/bin" >> Readex
	echo "append-path     PATH            $INSTALLATION_PATH_PERISCOPE/bin" >> Readex 
	echo "append-path     PATH 	          $INSTALLATION_PATH_RRL/bin" >> Readex 
	echo "append-path     PATH            $INSTALLATION_PATH_ATPS/bin" >> Readex
	echo "append-path     LD_LIBRARY_PATH $INSTALLATION_PATH_SCOREP/lib" >> Readex
	echo "append-path     LD_LIBRARY_PATH $INSTALLATION_PATH_PERISCOPE/lib" >> Readex
	echo "append-path     LD_LIBRARY_PATH $INSTALLATION_PATH_RRL/lib" >> Readex 
	echo "append-path     LD_LIBRARY_PATH $INSTALLATION_PATH_PCPS/lib" >> Readex
	echo "append-path     LD_LIBRARY_PATH $INSTALLATION_PATH_ATPS/lib" >> Readex
	echo "append-path     LD_LIBRARY_PATH $INSTALLATION_PATH_CLUSTER_PREDICTION/lib" >> Readex
}


if [ "$COMPILER" = "gcc" ]; then
	command -v gcc >/dev/null 2>&1 || { echo >&2 "[Error] GCC $GCC_VERSION_A or $GCC_VERSION_B is required. Please install it first. Aborting."; exit 1; }
	GCC_VERSION_INSTALLED=$(gcc -dumpversion)
	command -v gfortran >/dev/null 2>&1 || { echo >&2 "[Error] GFortran $GFORTRAN_VERSION_A or $GFORTRAN_VERSION_B is required. Please install it first. Aborting."; exit 1; }
	GFORTRAN_VERSION_INSTALLED=$(gfortran -dumpversion)
fi

if [ "$COMPILER" = "intel" ]; then
	command -v icc >/dev/null 2>&1 || { echo >&2 "[Error] Intel $INTEL_VERSION_A or $INTEL_VERSION_B is required. Please install it first. Aborting."; exit 1; }
	INTEL_VERSION_INSTALLED=$(which icc)
	[[ $INTEL_VERSION_INSTALLED =~ ([0-9]+\.){2}[0-9]+ ]]
	INTEL_VERSION_INSTALLED="${BASH_REMATCH[0]}"
fi

command -v bison >/dev/null 2>&1 || { echo >&2 "[Error] Bison $BISON_VERSION is required. Please install it first. Aborting."; installBison; }
BISON_VERSION_INSTALLED=$(bison --version)
[[ $BISON_VERSION_INSTALLED =~ ([0-9]+\.){2}[0-9]+ ]]
BISON_VERSION_INSTALLED="${BASH_REMATCH[0]}"


LUA_VERSION_INSTALLED=$(ls /usr/lib/x86_64-linux-gnu | grep liblua | head -n 1)

if [[ -n $LUA_VERSION_INSTALLED ]]; then
	[[ $LUA_VERSION_INSTALLED =~ [0-9]+\.[0-9]+ ]]
	LUA_VERSION_INSTALLED="${BASH_REMATCH[0]}"
else    
	echo "[Error] Lua $LUA_VERSION or higher is required. Please install it first. Aborting."
	installLua;
fi


if [[ -n $PAPI_LIB ]]; then
	PAPI_LIB_PATH="$PAPI_LIB/libpapi.so"
else
	PAPI_LIB_PATH="/usr/lib/x86_64-linux-gnu/libpapi.so"
fi

if [ -f ${PAPI_LIB_PATH} ]; then
	PAPI_VERSION_INSTALLED=$(readlink ${PAPI_LIB_PATH})
	[[ $PAPI_VERSION_INSTALLED =~ ([0-9]+\.){2}[0-9]+ ]]
	PAPI_VERSION_INSTALLED="${BASH_REMATCH[0]}"
else
	echo "[Error] PAPI $PAPI_VERSION or higher is required. Please install it first. Aborting."
	installPapi;
fi

if [[ -n $BOOST_INCLUDE ]]; then
	BOOST_INCLUDE_PATH="$BOOST_INCLUDE/version.hpp"
else
	BOOST_INCLUDE_PATH="/usr/include/boost/version.hpp"
fi

if [ -f ${BOOST_INCLUDE_PATH} ]; then
	BOOST_VERSION_INSTALLED=$(cat $BOOST_INCLUDE_PATH | grep "define BOOST_VERSION ")
	[[ $BOOST_VERSION_INSTALLED =~ [0-9]+ ]]
	BOOST_VERSION_INSTALLED="${BASH_REMATCH[0]}"

	BOOST_VERSION_PATCH=$(($BOOST_VERSION_INSTALLED%100))
	BOOST_VERSION_MINOR=$(($BOOST_VERSION_INSTALLED/100%1000))
	BOOST_VERSION_MAJOR=$(($BOOST_VERSION_INSTALLED/100000))

	BOOST_VERSION_INSTALLED="$BOOST_VERSION_MAJOR.$BOOST_VERSION_MINOR"

	if [ -n "$BOOST_VERSION_PATCH" ]; then
		BOOST_VERSION_INSTALLED="$BOOST_VERSION_INSTALLED.$BOOST_VERSION_PATCH"
	fi
else
	echo "[Error] BOOST $BOOST_VERSION is required. Installing now..."
	installBoost
fi

if [[ -n $ACE_LIB ]]; then
	ACE_LIB_PATH="$ACE_LIB/libACE.so"
else
	ACE_LIB_PATH="/usr/lib/libACE.so"
fi

if [ -f ${ACE_LIB_PATH} ]; then
	ACE_VERSION_INSTALLED=$(readlink ${ACE_LIB_PATH})
	[[ $ACE_VERSION_INSTALLED =~ ([0-9]+\.){2}[0-9]+ ]]
	ACE_VERSION_INSTALLED="${BASH_REMATCH[0]}"
else
	echo "ACE $ACE_VERSION is required. Installing it now."
	installACE
fi

if [ ! -f /usr/lib/x86_64-linux-gnu/libreadline.so ]; then
	echo "libreadline is required. Installing it now."
	installLibreadline
fi

if [[ -n $CEREAL_INCLUDE ]]; then
	CEREAL_INCLUDE_PATH="$CEREAL_INCLUDE/cereal.hpp"
else
	CEREAL_INCLUDE_PATH="/usr/include/cereal/cereal.hpp"
fi

if [[ -n ${CEREAL_INCLUDE} ]]; then
	CEREAL_VERSION_INSTALLED=0
elif [ -f /usr/include/cereal/cereal.hpp ]; then
	CEREAL_VERSION_INSTALLED=$(dpkg -s libcereal-dev | grep Version) 
	[[ $CEREAL_VERSION_INSTALLED =~ ([0-9]+\.){2}[0-9]+ ]]
	CEREAL_VERSION_INSTALLED="${BASH_REMATCH[0]}"
else
	echo "CEREAL $CEREAL_VERSION is required. Installing it now."
	installCereal
	CEREAL_VERSION_INSTALLED=$CEREAL_VERSION
fi

command -v cmake >/dev/null 2>&1 || { echo >&2 "[Error] CMake $CMAKE_VERSION or higher is required. Now installing the required version."; installCmake; }
CMAKE_VERSION_INSTALLED=$(cmake --version) 
[[ $CMAKE_VERSION_INSTALLED =~ ([0-9]+\.){2}[0-9]+ ]]
CMAKE_VERSION_INSTALLED="${BASH_REMATCH[0]}"

command -v python3 >/dev/null 2>&1 || { echo >&2 "[Error] Python $PYTHON_VERSION or higher is required. Please install it first. Aborting."; installPython; }
PYTHON_VERSION_INSTALLED=$(python3 --version)
[[ $PYTHON_VERSION_INSTALLED =~ ([0-9]+\.){2}[0-9]+ ]]
PYTHON_VERSION_INSTALLED="${BASH_REMATCH[0]}"

command -v flex >/dev/null 2>&1 || { echo >&2 "[Error] Flex $FLEX_VERSION is required. Installing it now. "; installFlex; }
FLEX_VERSION_INSTALLED=$(flex --version)
[[ $FLEX_VERSION_INSTALLED =~ ([0-9]+\.){2}[0-9]+ ]]
FLEX_VERSION_INSTALLED="${BASH_REMATCH[0]}"

command -v makeinfo >/dev/null 2>&1 || { echo >&2 "Makeinfo is required. Installing it."; installMakeinfo; }

WARNING=false

if [ "$COMPILER" = "gcc" ]; then
	COMPILER_PATH=$COMPILER-$GCC_VERSION_INSTALLED
	vercomp $GCC_VERSION_INSTALLED $GCC_VERSION_A
	case $? in
		0) 
			GCC_OP="the same"
			;;
		1) 
			GCC_OP="newer"
			;;
		2)
			GCC_OP="older"
			echo "[Warning] Your GCC version ($GCC_VERSION_INSTALLED) is $GCC_OP than the recommendations ($GCC_VERSION_A or $GCC_VERSION_B)."
			WARNING=true
			;;
	esac

	if [ "$GCC_OP" != "the same" ]  && [ "$GCC_OP" != "older" ]; then
		vercomp $GCC_VERSION_INSTALLED $GCC_VERSION_B
		case $? in
			0) 
				OP="the same"
				;;
			1) 
				OP="newer"
				echo "[Warning] Your GCC version ($GCC_VERSION_INSTALLED) is $OP than the recommendations ($GCC_VERSION_A or $GCC_VERSION_B)."
				WARNING=true
				;;
			2)
				OP="older"
				echo "[Warning] Your GCC version ($GCC_VERSION_INSTALLED) is $OP/$GCC_OP than the recommendation ($GCC_VERSION_B/$GCC_VERSION_A)."
				WARNING=true
				;;
		esac
	fi

	vercomp $GFORTRAN_VERSION_INSTALLED $GFORTRAN_VERSION_A
	case $? in
		0) 
			GFORTRAN_OP="the same"
			;;
		1) 
			GFORTRAN_OP="newer"
			;;
		2)
			GFORTRAN_OP="older"
			echo "[Warning] Your GFortran version ($GFORTRAN_VERSION_INSTALLED) is $GFORTRAN_OP than the recommendations ($GFORTRAN_VERSION_A or $GFORTRAN_VERSION_B)."
			WARNING=true
			;;
	esac

	if [ "$GFORTRAN_OP" != "the same" ]  && [ "$GFORTRAN_OP" != "older" ]; then
		vercomp $GFORTRAN_VERSION_INSTALLED $GFORTRAN_VERSION_B
		case $? in
			0) 
				OP="the same"
				;;
			1) 
				OP="newer"
				echo "[Warning] Your GFortan version ($GFORTRAN_VERSION_INSTALLED) is $OP than the recommendations ($GFORTRAN_VERSION_A or $GFORTRAN_VERSION_B)."
				WARNING=true
				;;
			2)
				OP="older"
				echo "[Warning] Your GFortran version ($GFORTRAN_VERSION_INSTALLED) is $OP/$GFORTRAN_OP than the recommendation ($GFORTRAN_VERSION_B/$GFORTRAN_VERSION_A)."
				WARNING=true
				;;
		esac
	fi
fi

if [ "$COMPILER" = "intel" ]; then
	COMPILER_PATH=$COMPILER-$INTEL_VERSION_INSTALLED
	vercomp $INTEL_VERSION_INSTALLED $INTEL_VERSION_A
	case $? in
		0) 
			ICC_OP="the same"
			;;
		1) 
			ICC_OP="newer"
			;;
		2)
			ICC_OP="older"
			echo "[Warning] Your Intel Compiler version ($INTEL_VERSION_INSTALLED) is $ICC_OP than the recommendations ($INTEL_VERSION_A or $INTEL_VERSION_B)."
			WARNING=true
			;;
	esac

	if [ "$ICC_OP" != "the same" ]  && [ "$ICC_OP" != "older" ]; then
		vercomp $INTEL_VERSION_INSTALLED $INTEL_VERSION_B
		case $? in
			0) 
				OP="the same"
				;;
			1) 
				OP="newer"
				echo "[Warning] Your Intel Compiler version ($INTEL_VERSION_INSTALLED) is $OP than the recommendations ($INTEL_VERSION_A or $INTEL_VERSION_B)."
				WARNING=true
				;;
			2)
				OP="older"
				echo "[Warning] Your Intel Compiler version ($INTEL_VERSION_INSTALLED) is $OP/$ICC_OP than the recommendation ($INTEL_VERSION_B/$INTEL_VERSION_A)."
				WARNING=true
				;;
		esac
	fi
fi

vercomp $BISON_VERSION_INSTALLED $BISON_VERSION
case $? in
	0) 
		OP="the same"
		;;
	1) 
		OP="newer"
		echo "[Warning] Your Bison version ($BISON_VERSION_INSTALLED) is $OP than the recommendation ($BISON_VERSION). Installing right version."
		installBison
		WARNING=true
		;;
	2)
		OP="older"
		echo "[Warning] Your Bison version ($BISON_VERSION_INSTALLED) is $OP than the recommendation ($BISON_VERSION) Installing right version."
		installBison
		WARNING=true
		;;
esac

vercomp $CEREAL_VERSION_INSTALLED $CEREAL_VERSION
case $? in
	0) 
		OP="the same"
		;;
	1) 
		OP="newer"
		echo "[Warning] Your Cereal version ($CEREAL_VERSION_INSTALLED) is $OP than the recommendation ($CEREAL_VERSION). Installing right version."
		installCereal
		WARNING=true
		;;
	2)
		OP="older"
		if [[ -n $CEREAL_INCLUDE ]];then
			echo "[Warning] Cannot detect version of Cereal."
		else
			echo "[Warning] Your Cereal version ($CEREAL_VERSION_INSTALLED) is $OP than the recommendation ($CEREAL_VERSION) Installing right version."
			installCereal
		fi
		WARNING=true
		;;
esac

vercomp $LUA_VERSION_INSTALLED $LUA_VERSION
case $? in
	0) 
		OP="the same"
		;;
	1) 
		OP="newer"
		;;
	2)
		OP="older"
		echo "[Warning] Your Lua version ($LUA_VERSION_INSTALLED) is $OP than the recommendation ($LUA_VERSION)."
		WARNING=true
		;;
esac

vercomp $PAPI_VERSION_INSTALLED $PAPI_VERSION
case $? in
	0) 
		OP="the same"
		;;
	1) 
		OP="newer"
		;;
	2)
		OP="older"
		echo "[Warning] Your PAPI version ($PAPI_VERSION_INSTALLED) is $OP than the recommendation ($PAPI_VERSION)."
		WARNING=true
		;;
esac

vercomp $BOOST_VERSION_INSTALLED $BOOST_VERSION
case $? in
	0) 
		OP="the same"
		;;
	1) 
		OP="newer"
		echo "[Warning] Your BOOST version ($BOOST_VERSION_INSTALLED) is $OP than the recommendation ($BOOST_VERSION). Installing right version."
		installBoost
		WARNING=true
		;;
	2)
		OP="older"
		echo "[Warning] Your BOOST version ($BOOST_VERSION_INSTALLED) is $OP than the recommendation ($BOOST_VERSION). Installing right version."
		installBoost
		WARNING=true
		;;
esac

vercomp $ACE_VERSION_INSTALLED $ACE_VERSION
case $? in
	0) 
		OP="the same"
		;;
	1) 
		OP="newer"
		echo "[Warning] Your ACE version ($ACE_VERSION_INSTALLED) is $OP than the recommendation ($ACE_VERSION). Installing right version."
		installACE
		WARNING=true
		;;
	2)
		OP="older"
		echo "[Warning] Your ACE version ($ACE_VERSION_INSTALLED) is $OP than the recommendation ($ACE_VERSION). Installing right version."
		installACE
		WARNING=true
		;;
esac

vercomp $PYTHON_VERSION_INSTALLED $PYTHON_VERSION
case $? in
	0) 
		OP="the same"
		;;
	1) 
		OP="newer"
		;;
	2)
		OP="older"
		echo "[Warning] Your Python version ($PYTHON_VERSION_INSTALLED) is $OP than the recommendation ($PYTHON_VERSION). Installing right version"
		installPython
		WARNING=true
		;;
esac

vercomp $FLEX_VERSION_INSTALLED $FLEX_VERSION
case $? in
	0) 
		OP="the same"
		;;
	1) 
		OP="newer"
		echo "[Warning] Your Flex version ($FLEX_VERSION_INSTALLED) is $OP than the recommendation ($FLEX_VERSION). Installing right version."
		installFlex
		WARNING=true
		;;
	2)
		OP="older"
		echo "[Warning] Your Flex version ($FLEX_VERSION_INSTALLED) is $OP than the recommendation ($FLEX_VERSION). Installing right version."
		installFlex
		WARNING=true
		;;
esac

vercomp $CMAKE_VERSION_INSTALLED $CMAKE_VERSION
case $? in
	0) 
		OP="the same"
		;;
	1) 
		OP="newer"
		;;
	2)
		OP="older"
		echo "[Warning] Your CMake version ($CMAKE_VERSION_INSTALLED) is $OP than the recommendation ($CMAKE_VERSION). Installing right version."
		installCmake
		WARNING=true
		;;
esac


INSTALLATION_PATH_SCOREP=$INSTALLATION_PATH/scorep/scorep_readex_${MPI}_$COMPILER_PATH
INSTALLATION_PATH_PERISCOPE=$INSTALLATION_PATH/ptf-readex/ptf_readex_${MPI}_$COMPILER_PATH
INSTALLATION_PATH_SCOREP_DEV=$INSTALLATION_PATH/scorep-dev
INSTALLATION_PATH_RRL=$INSTALLATION_PATH/readex-rrl/rrl_readex_${MPI}_$COMPILER_PATH
INSTALLATION_PATH_PEEP=$INSTALLATION_PATH/scorep_plugin_x86_energy
INSTALLATION_PATH_PCPS=$INSTALLATION_PATH/parameter_control_plugins/pcp_readex_${MPI}_$COMPILER_PATH
INSTALLATION_PATH_ATPS=$INSTALLATION_PATH/readex-atp/atp_readex_${MPI}_$COMPILER_PATH
INSTALLATION_PATH_CLUSTER_PREDICTION=$INSTALLATION_PATH/cluster_prediction/cluster_prediction_readex_${MPI}_$COMPILER_PATH

DECISION=

while [ "$DECISION" != "n" ] && [ "$DECISION" != "no" ] && [ "$DECISION" != "y" ] && [ "$DECISION" != "yes" ]; do
	echo "Do you want to continue with the Installation of READEX Tool Suite? (yes|no)"
	read DECISION

	if [ "$DECISION" = "n" ] || [ "$DECISION" = "no" ]; then
		exit 1;
	fi

	if [ "$DECISION" = "y" ] || [ "$DECISION" = "yes" ]; then
		break
	fi

done

#############################################################
#                                                           #
#                                                           #
#                       SCORE-P                             #
#                                                           #
#                                                           #
#############################################################

echo "[ 1/18] Downloading Score-P"

wget -c $DOWNLOAD_SCOREP
rm -rf $DIR_SCOREP
tar -xzf $ARCHIVE_FILE_SCOREP

echo "[ 2/18] Installing Score-P"

cd $DIR_SCOREP
mkdir build
cd build

CONFIGURE_SCOREP="../configure '--prefix=$INSTALLATION_PATH_SCOREP' \
	'--enable-backend-test-runs' \
	'--with-nocross-compiler-suite=$COMPILER' \
	'--with-mpi=$MPI'"

if [[ -n $CUDA ]]; then
	CONFIGURE_SCOREP="$CONFIGURE_SCOREP '--with-libcudart=$CUDA'"
fi

CONFIGURE_SCOREP="$CONFIGURE_SCOREP '--with-pdt=$PDT'"

if [[ -n $PAPI_INCLUDE ]]; then
	CONFIGURE_SCOREP="$CONFIGURE_SCOREP '--with-papi-header=$PAPI_INCLUDE'"
fi

if [[ -n $PAPI_LIB ]]; then
	CONFIGURE_SCOREP="$CONFIGURE_SCOREP '--with-papi-lib=$PAPI_LIB'"
fi


CONFIGURE_SCOREP="$CONFIGURE_SCOREP '--with-libbfd=no' \
	'--disable-silent-rules' \
	'--without-gui' \
	'--enable-static' \
	'--enable-shared' \
	'--enable-debug' \
	'--with-shmem=no' \
	'CFLAGS= -g -O3 -fno-omit-frame-pointer' \
	'CXXFLAGS=-g -O3 -fno-omit-frame-pointer'"


eval $CONFIGURE_SCOREP

make && make install
if [ $? != 0 ]; then
	exit 1;
fi

export PATH=$INSTALLATION_PATH_SCOREP/bin:$PATH

#############################################################
#                                                           #
#                                                           #
#                       Periscope                           #
#                                                           #
#                                                           #
#############################################################

echo "[ 3/18] Downloading Periscope"

cd ../..
wget -c $DOWNLOAD_PERISCOPE
rm -rf $DIR_PERISCOPE
tar -xzf $ARCHIVE_FILE_PERISCOPE

echo "[ 4/18] Downloading scorep-dev"
wget -c $DOWNLOAD_SCOREP_DEV
rm -rf $DIR_SCOREP_DEV
tar -xzf $ARCHIVE_FILE_SCOREP_DEV

echo "[ 5/18] Installing scorep-dev"
cd $DIR_SCOREP_DEV
./install-scorep-dev.06.sh --prefix=$INSTALLATION_PATH_SCOREP_DEV

export PATH=$INSTALLATION_PATH_SCOREP_DEV/bin:$PATH
export LD_LIBRARY_PATH=$INSTALLATION_PATH_SCOREP_DEV/lib:$LD_LIBRARY_PATH

echo "[ 6/18] Installing Periscope"

cd ../$DIR_PERISCOPE
./bootstrap
mkdir build
cd build

CONFIGURE_PERISCOPE="../configure '--prefix=$INSTALLATION_PATH_PERISCOPE' \
	--enable-developer-mode"

if [ "$COMPILER" = "intel" ]; then
	CONFIGURE_PERISCOPE="$CONFIGURE_PERISCOPE --with-compiler=$COMPILER"
fi

if [[ -n $STARTER ]]; then
	CONFIGURE_PERISCOPE="$CONFIGURE_PERISCOPE --with-starter=$STARTER"
else
	CONFIGURE_PERISCOPE="$CONFIGURE_PERISCOPE --with-starter=interactive"
fi

if [[ -n $ACE_INCLUDE ]]; then
	CONFIGURE_PERISCOPE="$CONFIGURE_PERISCOPE --with-ace-include=$ACE_INCLUDE"
fi

if [[ -n $ACE_LIB ]]; then
	CONFIGURE_PERISCOPE="$CONFIGURE_PERISCOPE --with-ace-lib=$ACE_LIB"
fi

if [[ -n $BOOST_INCLUDE ]]; then
	CONFIGURE_PERISCOPE="$CONFIGURE_PERISCOPE --with-boost-include=$BOOST_INCLUDE"
fi

if [[ -n $BOOST_LIB ]]; then
	CONFIGURE_PERISCOPE="$CONFIGURE_PERISCOPE --with-boost-lib=$BOOST_LIB"
fi

if [[ -n $PAPI_LIB ]]; then
	CONFIGURE_PERISCOPE="$CONFIGURE_PERISCOPE --with-papi-lib=$PAPI_LIB"
fi

CONFIGURE_PERISCOPE="$CONFIGURE_PERISCOPE \
	--with-cube-include=$INSTALLATION_PATH_SCOREP/include \
	--with-cube-lib=$INSTALLATION_PATH_SCOREP/lib \
	--with-scorep-include=$INSTALLATION_PATH_SCOREP/include \
	--with-scorep-lib=$INSTALLATION_PATH_SCOREP/lib"

if [[ -n $CEREAL_INCLUDE ]]; then
	CONFIGURE_PERISCOPE="$CONFIGURE_PERISCOPE --with-cereal-include=$CEREAL_INCLUDE"
fi

eval $CONFIGURE_PERISCOPE

make && make install
if [ $? != 0 ]; then
	exit 1;
fi

#############################################################
#                                                           #
#                                                           #
#                READEX RUNTIME LIBRARY                     #
#                                                           #
#                                                           #
#############################################################

cd ../..

DECISION_X86_ADAPT=

while [ "$DECISION_X86_ADAPT" != "n" ] && [ "$DECISION_X86_ADAPT" != "no" ] && [ "$DECISION_X86_ADAPT" != "y" ] && [ "$DECISION_X86_ADAPT" != "yes" ]; do
	echo "Do you want to install x86_adapt? (yes|no)"
	read DECISION_X86_ADAPT

	if [ "$DECISION_X86_ADAPT" = "n" ] || [ "$DECISION_X86_ADAPT" = "no" ]; then
		echo "skipping x86_adapt...."
		break;
	fi

	if [ "$DECISION_X86_ADAPT" = "y" ] || [ "$DECISION_X86_ADAPT" = "yes" ]; then
		echo "[ 7/16] Downloading x86_adapt"
		rm -rf x86_adapt
		git clone https://github.com/tud-zih-energy/x86_adapt.git

		echo "[ 8/16] Installing x86_adapt"
		cd x86_adapt
		mkdir build
		cd build
		cmake -DCMAKE_INSTALL_PREFIX=$INSTALLATION_PATH/x86_adapt ../
		make
		if [ $? != 0 ]; then
			exit 1;
		fi
		insmod kernel_module/definition_driver/x86_adapt_defs.ko
		insmod kernel_module/driver/x86_adapt_driver.ko
		make install
		if [ $? != 0 ]; then
			exit 1;
		fi
		cd ../..
	fi

done

echo "[ 9/18] Downloading RRL"

wget -c $DOWNLOAD_RRL
rm -rf $DIR_RRL
tar -xzf $ARCHIVE_FILE_RRL

cd $DIR_RRL
mkdir build
cd build

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

echo "[10/18] Installing RRL"

cmake ../ -DCMAKE_INSTALL_PREFIX=$INSTALLATION_PATH_RRL -DDISABLE_CALIBRATION=ON && make && make install
if [ $? != 0 ]; then
	exit 1;
fi

cd ../..

export PATH=$PATH:$INSTALLATION_PATH_RRL/bin
export RRL_INC=$INSTALLATION_PATH_RRL/include

#############################################################
#                                                           #
#                                                           #
#            PARAMETER CONTROL PLUGINS                      #
#                                                           #
#                                                           #
#############################################################
echo "[11/18] Downloading Processor Energy Event Plugin"
rm -rf $DIR_PEEP
git clone -b x86_energy_v_2 $DOWNLOAD_PEEP  

echo "[12/18] Installing Processor Energy Event Plugin"
cd $DIR_PEEP
mkdir build 
cd build
if [ "$DECISION_X86_ADAPT" = "y" ] || [ "$DECISION_X86_ADAPT" = "yes" ]; then
	cmake -DCMAKE_INSTALL_PREFIX=$INSTALLATION_PATH_PEEP -DX86_ADAPT_LIBRARIES=$INSTALLATION_PATH/x86_adapt/lib .. && make && make install 
else
	cmake -DCMAKE_INSTALL_PREFIX=$INSTALLATION_PATH_PEEP .. && make && make install 
fi
if [ $? != 0 ]; then
	exit 1;
fi
cd ../..

echo "[13/18] Downloading PCPs"

wget -c $DOWNLOAD_PCPS
rm -rf $DIR_PCPS
tar -xzf $ARCHIVE_FILE_PCPS

echo "[14/18] Installing PCPs"

cd $DIR_PCPS
./build.sh $INSTALLATION_PATH_PCPS


#############################################################
#                                                           #
#                                                           #
#             APPLICATION TUNING PARAMETER                  #
#                                                           #
#                                                           #
#############################################################

echo "[15/18] Downloading ATPs"

cd ..
wget -c $DOWNLOAD_ATPS
rm -rf $DIR_ATPS
tar -xzf $ARCHIVE_FILE_ATPS

cd $DIR_ATPS
mkdir build
cd build

echo "[16/18] Installing ATPs"

cmake ../ -DCMAKE_INSTALL_PREFIX=$INSTALLATION_PATH_ATPS && make && make install
if [ $? != 0 ]; then
	exit 1;
fi

#############################################################
#                                                           #
#                                                           #
#                  CLUSTER PREDICTION                       #
#                                                           #
#                                                           #
#############################################################

echo "[17/18] Downloading Cluster Prediction"

cd ../..
wget -c $DOWNLOAD_CLUSTER_PREDICTION
rm -rf $DIR_CLUSTER_PREDICTION
tar -xzf $ARCHIVE_FILE_CLUSTER_PREDICTION

cd $DIR_CLUSTER_PREDICTION
mkdir build
cd build

echo "[18/18] Installing Cluster Prediction"

cmake ../ -DCMAKE_INSTALL_PREFIX=$INSTALLATION_PATH_CLUSTER_PREDICTION && make && make install
if [ $? != 0 ]; then
	exit 1;
fi

cd ../..

DECISION=

while [ "$DECISION" != "n" ] && [ "$DECISION" != "no" ] && [ "$DECISION" != "y" ] && [ "$DECISION" != "yes" ]; do
	echo "Do you want to use Environment Modules to get easy access to the Readex Tool Suite?(yes|no)"
	read DECISION

	if [ "$DECISION" = "n" ] || [ "$DECISION" = "no" ];then
		echo "To use the Readex Tool Suite run following commands or add them to your shell configuration file, to append your \$PATH and \$LD_LIBRARY_PATH variable "
		echo "export PATH=$INSTALLATION_PATH_SCOREP/bin:$INSTALLATION_PATH_PERISCOPE/bin:$INSTALLATION_PATH_RRL/bin:$INSTALLATION_PATH_ATPS/bin:\$PATH"
		echo "export LD_LIBRARY_PATH=$INSTALLATION_PATH_SCOREP/lib:$INSTALLATION_PATH_PERISCOPE/lib:$INSTALLATION_PATH_RRL/lib:$INSTALLATION_PATH_PCPS/lib:$INSTALLATION_PATH_ATPS/lib:$INSTALLATION_PATH_CLUSTER_PREDICTION/lib:\$LD_LIBRARY_PATH"
		echo "To use Processor Energy Event Plugin: "
		echo "export LD_LIBRARY_PATH=$INSTALLATION_PATH_PEEP/lib:\$LD_LIBRARY_PATH"
		break
	fi

	if [ "$DECISION" = "y" ] || [ "$DECISION" = "yes" ];then
		DECISION_INSTALL=
		while [ "$DECISION_INSTALL" != "n" ] && [ "$DECISION_INSTALL" != "no" ] && [ "$DECISION_INSTALL" != "y" ] && [ "$DECISION_INSTALL" != "yes" ]; do
			echo "Do you have Environment Modules already installed and configured? (yes|no)"
			read DECISION_INSTALL
			if [ "$DECISION_INSTALL" = "y" ] || [ "$DECISION_INSTALL" = "yes" ];then
				echo "A modulefile in the current work directory is provided."
				break
			fi
			if [ "$DECISION_INSTALL" = "n" ] || [ "$DECISION_INSTALL" = "no" ];then
				echo "Installing Environment variables now."
				installModule
				break
			fi
		done
	fi
		break
done


DECISION=

while [ "$DECISION" != "n" ] && [ "$DECISION" != "no" ] && [ "$DECISION" != "y" ] && [ "$DECISION" != "yes" ]; do
	echo "Do you want to clean the current directory? (yes|no)"
	read DECISION

	if [ "$DECISION" = "n" ] || [ "$DECISION" = "no" ]; then
		exit 1;
	fi

	if [ "$DECISION" = "y" ] || [ "$DECISION" = "yes" ]; then
		rm -f $ARCHIVE_FILE_SCOREP
		rm -f $ARCHIVE_FILE_PERISCOPE
		rm -f $ARCHIVE_FILE_SCOREP_DEV
		rm -f $ARCHIVE_FILE_RRL
		rm -f $ARCHIVE_FILE_PCPS
		rm -f $ARCHIVE_FILE_ATPS
		rm -f $ARCHIVE_FILE_CLUSTER_PREDICTION
		rm -f $ARCHIVE_FILE_CMAKE
		rm -f $ARCHIVE_FILE_ACE
		rm -f $ARCHIVE_FILE_BISON
		rm -f $ARCHIVE_FILE_BOOST
		rm -f $ARCHIVE_FILE_CEREAL
		rm -f $ARCHIVE_FILE_FLEX
		rm -f $ARCHIVE_FILE_PYTHON
		rm -f $ARCHIVE_FILE_MODULE


		rm -rf $DIR_SCOREP
		rm -rf $DIR_PERISCOPE
		rm -rf $DIR_SCOREP_DEV
		rm -rf $DIR_RRL
		rm -rf $DIR_PCPS
		rm -rf $DIR_ATPS
		rm -rf $DIR_CLUSTER_PREDICTION
		rm -rf $DIR_CMAKE
		rm -rf $DIR_ACE
		rm -rf $DIR_BISON
		rm -rf $DIR_BOOST
		rm -rf $DIR_CEREAL
		rm -rf $DIR_FLEX
		rm -rf $DIR_PYTHON
		rm -rf $DIR_PEEP
		rm -rf x86_adapt
		rm -rf $DIR_MODULE
	fi

done

