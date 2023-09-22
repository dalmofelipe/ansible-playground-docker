# Ansible Playground Docker

### Comandos

    cd ansible
    ssh-keygen -t rsa -b 2048 -N '' -f keys/ansible_key
    chown -R root:root keys/
    chmod 400 keys/ansible_key
    docker-compose up -d
    docker exec -it ansible sh
    ansible-playbook web.yml

<br>

[Giovanni Rossini](https://medium.com/grupo-tesseract/ansible-playground-with-docker-d85b81220b8d)
