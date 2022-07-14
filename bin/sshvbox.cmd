@echo off
REM
REM This script allows you to start an SSH connection to a VirtualBox virtual machine
REM which uses the name that you provided to the command. It is assumed that the machine
REM is running an SSH server and all you really need is to get its IP address.
REM
REM Handy as it doesn't require you to know VM's IP machine
REM as it's being fetched from VirtualBox automatically.
REM
REM After getting VM's IP address, this script will connect to the machine with command:
REM     ssh vm@%ip_address% command
REM
REM Usage: `sshvbox <machine name>`
REM
REM
REM Copyright 2021-present Jakub Kuczys (https://github.com/jack1142)
REM
REM Licensed under the Apache License, Version 2.0 (the "License");
REM you may not use this file except in compliance with the License.
REM You may obtain a copy of the License at
REM
REM     https://www.apache.org/licenses/LICENSE-2.0
REM
REM Unless required by applicable law or agreed to in writing, software
REM distributed under the License is distributed on an "AS IS" BASIS,
REM WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM See the License for the specific language governing permissions and
REM limitations under the License.

REM Get MAC address for Host-only adapter which we assume will be the second network card
FOR /F "tokens=* USEBACKQ" %%F IN (
    `vboxmanage showvminfo --machinereadable %1 ^| grep "macaddress2" ^| sed "s/macaddress2=//"`
) DO (
    SET mac_address=%%F
)

REM Get IP address for the MAC address
FOR /F "tokens=* USEBACKQ" %%F IN (
    `vboxmanage dhcpserver findlease --interface "VirtualBox Host-Only Ethernet Adapter" --mac-address %mac_address% ^| head -n 1 ^| sed "s/IP Address:  //"`
) DO (
    SET ip_address=%%F
)

ssh vm@%ip_address%
