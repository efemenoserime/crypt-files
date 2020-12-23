# CryptFiles

This shell script is ment to encrypt and decrypt files of
any kind. Files will be encrypted by default.

## **Download**
<hr/>
<br/>

### **Quick start**
<br/>

#### Windows (Powershell)
```powershell
wget  https://raw.githubusercontent.com/efemenoserime/crypt-files/master/crypt-files.sh -OutFile crypt-files.sh
```

#### Linux (bash)
````bash
wget  https://raw.githubusercontent.com/efemenoserime/crypt-files/master/crypt-files.sh -O crypt-files.sh
````

<br/>

## Usage

<hr/>

```bash
# Encrypt file (default)
./crypt-files.sh -f test.txt -p password

# Decrypt file 
./crypt-files.sh -d -f test.txt -p password
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)