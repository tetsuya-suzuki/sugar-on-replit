#!/bin/bash

REPL_DIR=$(cd $(dirname $0); pwd)
BIN_DIR=${REPL_DIR}/bin
SUGAR_SCRIPT=${REPL_DIR}/sugar
MINISAT_SCRIPT=${REPL_DIR}/minisat

pushd ${REPL_DIR}

# initial setup
rm -r ${BIN_DIR}
mkdir ${BIN_DIR}

# wrapper scripts  
sed -e "s|_BIN_DIR_|${BIN_DIR}|" src/sugar.tmpl > ${SUGAR_SCRIPT}
chmod +x ${SUGAR_SCRIPT}

sed -e "s|_BIN_DIR_|${BIN_DIR}|" src/minisat.tmpl > ${MINISAT_SCRIPT}
chmod +x ${MINISAT_SCRIPT}

# patch file  
sed -e "s|_BIN_DIR_|${BIN_DIR}|" src/sugar.diff.tmpl > src/sugar.diff

# minisat
pushd ${BIN_DIR}
tar zxvf ${REPL_DIR}/src/minisat-2.2.0.tar.gz
cd minisat
export MROOT=${BIN_DIR}/minisat
cd simp
make rs
mv minisat_static minisat
popd

# Sugar
pushd ${BIN_DIR}
unzip ${REPL_DIR}/src/sugar-v2-2-1.zip
cd sugar-v2-2-1/bin
patch < ${REPL_DIR}/src/sugar.diff
popd


#
popd
