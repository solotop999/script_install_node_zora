# script_install_node_zora
script_install_node_zora




### Command install: 


```
apt install git -y && git clone https://github.com/solotop999/script_install_node_zora.git && cd script_install_node_zora && chmod +x zora.sh && ./zora.sh
```

### Video Setup:

- My twitter: https://x.com/solotop999/status/1739267975889502478?s=20



### Change RPC:
- Create account and get RPC at: [Alchemy](https://alchemy.com/?r=DI0NjIwMzMyNzg3N)

- Change this link to your RPC link:
  
```
MY_RPC=https://eth-mainnet.g.alchemy.com/v2/foaJ7qz-aaaaaaaaaaaaaaaaaaaaaaaaaaaaa
```

- Continute run this command:
```
cd /opt/zora-node/node
export CONDUIT_NETWORK=zora-mainnet-0
docker-compose down
echo "OP_NODE_L1_ETH_RPC=$MY_RPC" > /opt/zora-node/node/.env
docker-compose up -d
docker ps -a
```


### Video Change RPC:
