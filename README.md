# dnsserver-x86
This project redirect the data to it's dns-server and get the domain's ip back.


## Usage
### Install project :
    ```
    ./dnssever-control.sh install [WAN] [PORT]
    ```
WAN:    the name of your machine's WAN interface
PORT:   
* this parameter is the port that accept data and redirect it to the machine's dns-server
* this port can be one number or a range,e.g :15350, 123, 15360:15370 


### Uninstall project :
    ```
    ./dnssever-control.sh uninstall
    ```

### Restart project :
    ```
    ./dnssever-control.sh restart
    ```

### Get status
    ```
    ./dnssever-control.sh status
    ```

