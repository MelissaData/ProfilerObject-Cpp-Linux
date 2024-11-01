#!/bin/bash

# Name:    MelissaProfilerObjectLinuxCpp
# Purpose: Use the MelissaUpdater to make the MelissaProfilerObjectLinuxCpp code usable

######################### Constants ##########################

RED='\033[0;31m' #RED
NC='\033[0m' # No Color

######################### Parameters ##########################

file=""
dataPath=""
license=""
quiet="false"

while [ $# -gt 0 ] ; do
    case $1 in
    --file) 
        file="$2"

        if [ "$file" == "--dataPath" ] || [ "$file" == "--license" ] || [ "$file" == "--quiet" ] || [ -z "$file" ];
        then
            printf "${RED}Error: Missing an argument for parameter \'file\'.${NC}\n"  
            exit 1
        fi  
        ;;
    --dataPath) 
        dataPath="$2"
        
        if [ "$dataPath" == "--file" ] || [ "$dataPath" == "--license" ] || [ "$dataPath" == "--quiet" ] || [ -z "$dataPath" ];
        then
            printf "${RED}Error: Missing an argument for parameter \'dataPath\'.${NC}\n"  
            exit 1
        fi 
        ;;
    --license) 
        license="$2"

        if [ "$license" == "--file" ] || [ "$license" == "--dataPath" ] || [ "$license" == "--quiet" ] || [ -z "$license" ];
        then
            printf "${RED}Error: Missing an argument for parameter \'license\'.${NC}\n"  
            exit 1
        fi    
        ;;
    --quiet) 
        quiet="true" 
        ;;
    esac
    shift
done

######################### Config ###########################

RELEASE_VERSION='2024.Q4'
ProductName="profiler_data"

# Uses the location of the .sh file 
CurrentPath=$(pwd)
ProjectPath="$CurrentPath/MelissaProfilerObjectLinuxCpp"

BuildPath="$ProjectPath/Build"
if [ ! -d "$BuildPath" ]; 
then
  mkdir -p "$BuildPath"
fi

if [ -z "$dataPath" ];
then
    DataPath="$ProjectPath/Data"
else
    DataPath=$dataPath
fi

if [ ! -d "$DataPath" ] && [ "$DataPath" == "$ProjectPath/Data" ];
then
    mkdir "$DataPath"
elif [ ! -d "$DataPath" ] && [ "$DataPath" != "$ProjectPath/Data" ];
then
    printf "\nData file path does not exist. Please check that your file path is correct.\n"
    printf "\nAborting program, see above.\n"
    exit 1
fi

# Config variables for download file(s)
Config1_FileName="libmdProfiler.so"
Config1_ReleaseVersion=$RELEASE_VERSION
Config1_OS="LINUX"
Config1_Compiler="GCC48"
Config1_Architecture="64BIT"
Config1_Type="BINARY"

Config2_FileName="mdProfiler.h"
Config2_ReleaseVersion=$RELEASE_VERSION
Config2_OS="ANY"
Config2_Compiler="C"
Config2_Architecture="ANY"
Config2_Type="INTERFACE"

Config3_FileName="mdProfilerEnums.h"
Config3_ReleaseVersion=$RELEASE_VERSION
Config3_OS="ANY"
Config3_Compiler="C"
Config3_Architecture="ANY"
Config3_Type="INTERFACE"

# ######################## Functions #########################

DownloadDataFiles()
{
    printf "================================ MELISSA UPDATER ==============================\n"
    printf "MELISSA UPDATER IS DOWNLOADING DATA FILE(S)...\n"

    ./MelissaUpdater/MelissaUpdater manifest -p $ProductName -r $RELEASE_VERSION -l $1 -t $DataPath 
    if [ $? -ne 0 ];
    then
        printf "\nCannot run Melissa Updater. Please check your license string!\n"
        exit 1
    fi     

    printf "Melissa Updater finished downloading data file(s)!\n"
}

DownloadSO() 
{
    printf "\nMELISSA UPDATER IS DOWNLOADING SO(S)...\n"
    
    # Check for quiet mode
    if [ $quiet == "true" ];
    then
        ./MelissaUpdater/MelissaUpdater file --filename $Config1_FileName --release_version $Config1_ReleaseVersion --license $1 --os $Config1_OS --compiler $Config1_Compiler --architecture $Config1_Architecture --type $Config1_Type --target_directory $BuildPath &> /dev/null     
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi

        printf "Melissa Updater finished downloading $Config1_FileName!\n"

        ./MelissaUpdater/MelissaUpdater file --filename $Config2_FileName --release_version $Config2_ReleaseVersion --license $1 --os $Config2_OS --compiler $Config2_Compiler --architecture $Config2_Architecture --type $Config2_Type --target_directory $ProjectPath &> /dev/null
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi

        printf "Melissa Updater finished downloading $Config2_FileName!\n"

        ./MelissaUpdater/MelissaUpdater file --filename $Config3_FileName --release_version $Config3_ReleaseVersion --license $1 --os $Config3_OS --compiler $Config3_Compiler --architecture $Config3_Architecture --type $Config3_Type --target_directory $ProjectPath &> /dev/null    
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi

        printf "Melissa Updater finished downloading $Config3_FileName!\n"
    else
        ./MelissaUpdater/MelissaUpdater file --filename $Config1_FileName --release_version $Config1_ReleaseVersion --license $1 --os $Config1_OS --compiler $Config1_Compiler --architecture $Config1_Architecture --type $Config1_Type --target_directory $BuildPath    
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi

        printf "Melissa Updater finished downloading $Config1_FileName!\n"
   
        ./MelissaUpdater/MelissaUpdater file --filename $Config2_FileName --release_version $Config2_ReleaseVersion --license $1 --os $Config2_OS --compiler $Config2_Compiler --architecture $Config2_Architecture --type $Config2_Type --target_directory $ProjectPath 
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi

        printf "Melissa Updater finished downloading $Config2_FileName!\n"

        ./MelissaUpdater/MelissaUpdater file --filename $Config3_FileName --release_version $Config3_ReleaseVersion --license $1 --os $Config3_OS --compiler $Config3_Compiler --architecture $Config3_Architecture --type $Config3_Type --target_directory $ProjectPath 
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi

        printf "Melissa Updater finished downloading $Config3_FileName!\n"
    fi
}

CheckSOs() 
{
    printf "\nDouble checking SO file(s) were downloaded...\n"
    FileMissing=0
    if [ ! -f $BuildPath/$Config1_FileName ];
    then
        printf "\n$Config1_FileName not found\n"
        FileMissing=1
    fi

    if [ $FileMissing -eq 1 ];
    then
        printf "\nMissing the above data file(s).  Please check that your license string and directory are correct."
        echo 0
    else
        echo 1
    fi
}

########################## Main ############################
printf "\n=========================== Melissa Profiler Object ===========================\n                            [ C++ | Linux | 64BIT ]\n"

# Get license (either from parameters or user input)
if [ -z "$license" ];
then
    printf "Please enter your license string: "
    read license
fi

# Check for License from Environment Variables 
if [ -z "$license" ];
then
    license=`echo $MD_LICENSE` 
fi

if [ -z "$license" ];
then
    printf "\nLicense String is invalid!\n"
    exit 1
fi

# Get data file path (either from parameters or user input)
if [ "$DataPath" = "$ProjectPath/Data" ]; then
    printf "Please enter your data files path directory if you have already downloaded the release zip.\nOtherwise, the data files will be downloaded using the Melissa Updater (Enter to skip): "
    read dataPathInput

    if [ ! -z "$dataPathInput" ]; then  
        if [ ! -d "$dataPathInput" ]; then  
            printf "\nData file path does not exist. Please check that your file path is correct.\n"
            printf "\nAborting program, see above.\n"
            exit 1
        else
            DataPath=$dataPathInput
        fi
    fi
fi

# Use Melissa Updater to download data file(s) 
# Download data file(s) 
DownloadDataFiles $license # Comment out this line if using own release

# Download SO(s)
DownloadSO $license 

#Check if all SO(s) have been downloaded. Exit script if missing
SOsAreDownloaded=$(CheckSOs)

if echo "$SOsAreDownloaded" | grep -q "0";
then
   echo "$SOsAreDownloaded" | sed 's/0$//'
   printf "\nAborting program, see above.\n"
   exit 1
fi

printf "\nAll file(s) have been downloaded/updated!\n"

# Start program
# Build project
printf "\n================================= BUILD PROJECT ===============================\n"

# Setting the path to the lib in the makefile
LibPath=$(grep '^LDLIBS = -L[^ ]*' $ProjectPath/makefile | sed 's/ -Wl,.*//')
NewLibPath="LDLIBS = -L$ProjectPath/Build"

sed -i -e "s|$LibPath|$NewLibPath|g" $ProjectPath/makefile

# Generate the executable file
cd MelissaProfilerObjectLinuxCpp
make &> /dev/null
cd ..

# Export the path to the lib so that the executable knows where to look
export LD_LIBRARY_PATH=$BuildPath

# Run Project
if [ -z "$file" ];
then
    cd MelissaProfilerObjectLinuxCpp
    $BuildPath/MelissaProfilerObjectLinuxCpp --license $license --dataPath $DataPath
    cd ..
else
    cd MelissaProfilerObjectLinuxCpp
    $BuildPath/MelissaProfilerObjectLinuxCpp --license $license --dataPath $DataPath --file "$file" 
    cd ..
fi
