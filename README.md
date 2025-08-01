# Melissa - Profiler Object Linux C++

## Purpose
This code showcases the Melissa Profiler Object using C++.

Please feel free to copy or embed this code to your own project. Happy coding!

For the latest Melissa Profiler Object release notes, please visit: https://releasenotes.melissa.com/on-premise-api/profiler-object/

For further details, please visit: https://docs.melissa.com/on-premise-api/profiler-object/profiler-object-quickstart.html

The console will ask the user for:

- A csv that contains data that you would like to profile

And return 

- TableRecordCount
- ColumnCount
- ExactMatchDistinctCount
- ExactMatchDupesCount
- ExactMatchLargestGroup
- ContactMatchDistinctCount
- ContactMatchDupesCount
- ContactMatchLargestGroup
- HouseholdMatchDistinctCount
- HouseholdMatchDupesCount
- HouseholdMatchLargestGroup
- AddressMatchDistinctCount
- AddressMatchDupesCount
- AddressMatchLargestGroup
- States and Counts
- Postal Patterns and Counts

## Tested Environments
- Linux 64-bit g++ 9.4.0, Ubuntu 20.04.05 LTS
- GNU Make 4.2.1
- Melissa data files for 2025-Q3

## Required Files and Programs

#### Binaries
This is the c++ code of the Melissa Object.

- libmdProfiler.so

#### Data File(s)
- mdProfiler.cfg
- mdProfiler.dat
- mdProfiler.mc

#### Dependencies
- mdProfiler.h
- mdProfilerEnums.h

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

#### Install g++ and make
Before starting, make sure that both g++ and make have been correctly installed on your machine. If you are unsure, you can check by opening up your linux terminal, and proceed to execute the commands listed below.

To check your g++ version:

`g++ --version`

To check your make version:

`make --version`

If g++ and make are already installed, you should see something like the following:

![alt text](/screenshots/gppv.png)

![alt text](/screenshots/makev.png)

If you see the logs above that indicate that you have g++ and make installed, then you may skip to the next step. If you do not see them, then you will need to execute the commands below in order to install g++ and make.

First, execute the command: 

`sudo apt update`

To install g++:

`sudo apt install g++`

To install make:

`sudo apt install make`

Once you have finished the installations, you should be able to verify that they have been correctly installed by executing the `g++ --version` and `make --version` commands.

----------------------------------------

#### Download this project
```
git clone https://github.com/MelissaData/ProfilerObject-Cpp-Linux
cd ProfilerObject-Cpp-Linux
```

#### Set up Melissa Updater 
Melissa Updater is a CLI application allowing the user to update their Melissa applications/data. 

- In the root directory of the project, create a folder called `MelissaUpdater` by using the command: 

  `mkdir MelissaUpdater`

- Enter the newly created folder using the command:

  `cd MelissaUpdater`

- Proceed to install the Melissa Updater using the curl command: 

  `curl -L -O https://releases.melissadata.net/Download/Library/LINUX/NET/ANY/latest/MelissaUpdater`

- After the Melissa Updater is installed, you will need to change the Melissa Updater to an executable using the command:

  `chmod +x MelissaUpdater`

- Now that the Melissa Updater is set up, you can now proceed to move back into the project folder by using the command:
  
   `cd ..`

#### Different ways to get data file(s)
1.  Using Melissa Updater
    - It will handle all of the data download/path and .so file(s) for you. 
2.  If you already have the latest release zip, you can find the data file(s) in there
    - To pass in your own data file path directory, you may either use the '--dataPath' parameter or enter the data file path directly in interactive mode.
    - Comment out this line "DownloadDataFiles $license" in the bash script.
    - This will prevent you from having to redownload all the files.

#### Change Bash Script Permissions
To be able to run the bash script, you must first make it an executable using the command:

`chmod +x MelissaProfilerObjectLinuxCpp.sh`

As an indicator, the filename will change colors once it becomes an executable.

## Run Bash Script
Parameters:
- --file: a test csv file

  This is convenient when you want to get results for a specific csv file in one run instead of testing multiple csv files in interactive mode.

- --dataPath (optional): a data file path directory to test the Profiler Object
- --license (optional): a license string to test the Profiler Object
- --quiet (optional): add to command if you do not want to get any console output from the Melissa Updater

  When you have modified the script to match your data location, let's run the script. There are two modes:
- Interactive
    
  The script will prompt the user for a csv file, then use the provided csv file to test Profiler Object.  For example:
  ```
  ./MelissaProfilerObjectLinuxCpp.sh
  ```
  For quiet mode:
  ```
  ./MelissaProfilerObjectLinuxCpp.sh --quiet
  ```

- Command Line

  You can pass a csv file and a license string into the `--file` and `--license` parameters respectively to test Profiler Object. For example:

  With all parameters:
  ```
  ./MelissaProfilerObjectLinuxCpp.sh --file "MelissaProfilerObjectSampleInput.csv"
  ./MelissaProfilerObjectLinuxCpp.sh --file "MelissaProfilerObjectSampleInput.csv" --license "<your_license_string>"
  ```
  For quiet mode:
  ```
  ./MelissaProfilerObjectLinuxCpp.sh --file "MelissaProfilerObjectSampleInput.csv" --quiet
  ./MelissaProfilerObjectLinuxCpp.sh --file "MelissaProfilerObjectSampleInput.csv" --license "<your_license_string>" --quiet
  ```

This is the expected outcome of a successful setup for interactive mode:

![alt text](/screenshots/output.png)

## Troubleshooting
Troubleshooting for errors found while running your program.

### C# Errors:
| Error      | Description |
| ----------- | ----------- |
| ErrorRequiredFileNotFound      | Program is missing a required file. Please check your Data folder and refer to the list of required files above. If you are unable to obtain all required files through the Melissa Updater, please contact technical support below. |
| ErrorLicenseExpired   | Expired license string. Please contact technical support below. |

## Contact Us
For free technical support, please call us at 800-MELISSA ext. 4 (800-635-4772 ext. 4) or email us at tech@melissa.com.

To purchase this product, contact the Melissa sales department at 800-MELISSA ext. 3 (800-635-4772 ext. 3).
