:<<!
****************************************************************
# $ ./framework_build.sh <framework_name> <config>
# e.g
# ./framework_build.sh Framework Debug
****************************************************************
!

#框架名称
FRAMEWORK_NAME=$1

#构建配置, Debug, Release, AdHoc, InHouse
CONFIG=$2
if [ -z "${CONFIG}" ]
then
CONFIG=Debug
fi

WORKSPACE_NAME=${FRAMEWORK_NAME}
SCHEME_NAME=${FRAMEWORK_NAME}

#framework 的输出目录
#在当前目录创建 .framework
DESTINATION_DIR=../${FRAMEWORK_NAME}/Framework/${FRAMEWORK_NAME}.framework

#echo $DESTINATION_DIR

# 进入到 Example 目录，否则找不到 ${WORKSPACE_NAME}.xcworkspace 文件
cd Example

#Build 目录，在framework 创建完成后删除
BUILD_DIR=Build
#framework 构建目录
DEVICE_DIR=${BUILD_DIR}/${CONFIG}-iphoneos/${FRAMEWORK_NAME}/${FRAMEWORK_NAME}.framework
SIMULATOR_DIR=${BUILD_DIR}/${CONFIG}-iphonesimulator/${FRAMEWORK_NAME}/${FRAMEWORK_NAME}.framework

#workspace architechture, clean build
xcodebuild -workspace ${WORKSPACE_NAME}".xcworkspace" -configuration "${CONFIG}" -scheme ${SCHEME_NAME} SYMROOT=$(PWD)/build -sdk iphoneos clean build
xcodebuild -workspace ${WORKSPACE_NAME}".xcworkspace" -configuration "${CONFIG}" -scheme ${SCHEME_NAME} SYMROOT=$(PWD)/build -sdk iphonesimulator clean build

#删除 构建目录
if [ -d "${DESTINATION_DIR}" ]
then
rm -rf "${DESTINATION_DIR}"
fi

mkdir -p "${DESTINATION_DIR}"
cp -R "${DEVICE_DIR}/" "${DESTINATION_DIR}/"
#Objective-C framework 中, 使用 lipo 合成 iphoneos 和 iphonesimulator 可执行文件后, .framework 即可正常工作, 不过在合成 Swift framework 后, 使用 .framework 会出现错误:
#'SomeClass' is unavailable: cannot find Swift declaration for this class
#这是因为 Swift framework 内包含有 .swiftmodule 文件, 其定义了 framework 所支持的 architecture,  所以对于 Swift framework, 我们除了将 .exec 文件合并外, 还需要将 .framework/Module/.swiftmodule 文件夹内的所有描述文件移动到一起
if [[ -e "${SIMULATOR_DIR}/Modules/${FRAMEWORK_NAME}/${FRAMEWORK_NAME}.swiftmodule/" ]]
then
cp -R "${SIMULATOR_DIR}/Modules/${FRAMEWORK_NAME}/${FRAMEWORK_NAME}.swiftmodule/" "${DESTINATION_DIR}/Modules/${FRAMEWORK_NAME}.swiftmodule/"
fi

lipo -create "${DEVICE_DIR}/${FRAMEWORK_NAME}" "${SIMULATOR_DIR}/${FRAMEWORK_NAME}" -output "${DESTINATION_DIR}/${FRAMEWORK_NAME}"
rm -r "${BUILD_DIR}"
