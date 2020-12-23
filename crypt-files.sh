#!/bin/bash - 
#===============================================================================
#
#          FILE: crypt-files.sh
# 
#         USAGE: ./crypt-files.sh [FLAGS] -f <FILE> -p <PASSWORD>
#          
#       EXAMPLE: ./crypt-files.sh -e -f example.txt -p secret_password
# 
#   DESCRIPTION: 
#                   This shell script is ment to encrypt and decrypt files of
#                   any kind. If neither -e nor -d is specified, the target file will
#                   be encrypted by default.
#
#       OPTIONS: 
#                      -h              Print help menu.
#                   *  -f  <FILE>      Target file to de- or encrypt.
#                   *  -p  <PASSWORD>  Password to de- and encrypt target file with.
#                      -e              (Default) Encrypt target file.
#                      -d              Decrypt target file.
#
#                   * (required arguments)
#
#  REQUIREMENTS: openssl 
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Efeme Noserime, 
#       CREATED: 21.12.2020 21:24
#      REVISION:  ---
#===============================================================================

function usage () {
    echo -e "\n\tUSAGE: ./crypt-files.sh [FLAGS] -f example.txt -p secret_password\n"
}

function help {
    usage
    echo -e "\n\tDESCRIPTION:"
    echo -e "\n\t\tThis shell script is ment to encrypt and decrypt files of
                any kind. If neither -e nor -d is specified, the target file will
                be encrypted by default."
    echo -e "\n\tOPTIONS:" 
    echo -e "\t\t-h              Print this help menu."
    echo -e "\t\t-f  <FILE>      Target file to de- or encrypt."
    echo -e "\t\t-p  <PASSWORD>  Password to de- and encrypt target file with."
    echo -e "\t\t-e              (Default) Encrypt target file."
    echo -e "\t\t-e              Decrypt target file"
    echo -e "\n"

}
function encrypt () {
    local file_name="$1"
    local password="$2"
    local encrypted_file_name="${file}.enc"
    openssl enc -aes-256-cbc -pbkdf2  -salt -in $file_name -out $encrypted_file_name -k $password 
    
} 

function decrypt () {
    local file_name="$1"
    local password="$2"
    local decrypted_file_name="${file_name%.enc}"
    openssl enc -aes-256-cbc -d -pbkdf2 -in $file_name -out $decrypted_file_name -k $password
}

while getopts hdef:p: flag
do
    case "${flag}" in
        f) file=${OPTARG};;
        p) password=${OPTARG};;
        d) decrypt=true;;
        e) encrypt=true;;
        h) help && exit 0;;
    esac
done

# Check if required arguments have been passed
if [ -z $file ] || [ -z $password  ]; then
    usage
else
    # Throw error if encrypt and decrypt flag are set at the same time
    if [ $decrypt ] && [ $encrypt ]; then
        echo -e "\n\tERROR: Can not encrypt and decrypt at the same time.\n"
        usage
        exit 1
    # Otherwise check which of both flags is set & use appropriate function
    else
        # Decrypt file if flag is set
        if [ "$decrypt" = "true" ]; then
            echo "File will be decrypted"
            decrypt $file $password
            echo "Successfully decrypted file" && exit 0
        # Otherwise encrypt file (default)
        else
            echo "File will be encrypted"
            encrypt $file $password
            echo "Successfully encrypted file" && exit 0
        fi
    fi  
fi
