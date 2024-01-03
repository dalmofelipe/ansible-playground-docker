## Ansible Playground In Docker

### GitPod

```sh
cd ansible
ssh-keygen -t rsa -b 2048 -N '' -f keys/ansible_key
```

Mudar permissão da chave privada 'ansible_key', para executar o playbook.

```sh
chown -R root:root keys/ # para liberar restrições do gitpod
chmod 400 keys/ansible_key # ssh
```

Subindo ambiente

```sh
docker-compose up -d
docker exec -it ansible sh
ansible-playbook web.yml
```

<br>

### Docker localhost/baremetal

Localmente, foi necessário gerar chaves SSH dentro container do ansible e salva-las na pasta ```/ansible/keys``` deste repo. 

Subindo ambiente

```sh
cd ansible
docker-compose up -d
```

1. Acesse o shell do container ansible

```sh
docker exec -it ansible sh
```

2. Gerar chaves ssh no diretorio do /etc/ansible

```sh
# shell ANSIBLE

cd /etc/ansible

ssh-keygen -t rsa -b 2048 -N '' -f ansible_key
```

3. Os arquivos seram gerados na raiz do repositório, em ```./ansible/config``` na maquina HOST

```sh
# shell HOST

cd ansible/config
ls 

ansible.cfg  hosts.yaml  playbooks  roles ansible_key ansible_key.pub
```

Mova para ```./ansible/keys``` para o bind de volumes no Docker

```sh
# shell HOST

mv ansible_key* ../keys
```

4. Verifique o permissionamento das chaves.

```sh
# shell HOST
cd ansible/keys
ls -la

-rw------- 1 root  root  1823 jan  3 15:18 ansible_key # 600
-rw-r--r-- 1 root  root   399 jan  3 15:18 ansible_key.pub # 644
```

5. RE Build do compose

```sh
# shell HOST

cd ansible
docker compose down
docker compose build
docker compose up
```

6. Pingando todos hosts

Acesse novamente o shell do container do ANSIBLE

```sh
# shell ANSIBLE

ansible all -m ping

webserver-centos | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
webserver-ubuntu | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

7. Aplicando Playbook

```sh
# shell ANSIBLE

cd /etc/ansible/playbooks 
ansible-playbook web.yaml 


PLAY [all] *************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************
Wednesday 03 January 2024  18:36:48 +0000 (0:00:00.007)       0:00:00.007 ***** 
ok: [webserver-ubuntu]
ok: [webserver-centos]

...
```

Comunicação ssh estabelecida!

<br>

***Artigo "Ansible Playground with Docker" de [Giovanni Rossini](https://medium.com/grupo-tesseract/ansible-playground-with-docker-d85b81220b8d)***

***https://www.server-world.info/en/***