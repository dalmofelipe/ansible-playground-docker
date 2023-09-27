### Ansible Playground Docker

    cd ansible
    ssh-keygen -t rsa -b 2048 -N '' -f keys/ansible_key
    chown -R root:root keys/

    ### Foi necessário mudar permissão da chave privada 'ansible_key', para executar o playbook.
    chmod 400 keys/ansible_key
    
    docker-compose up -d
    docker exec -it ansible sh
    ansible-playbook web.yml

<br>

Artigo "Ansible Playground with Docker" de [Giovanni Rossini](https://medium.com/grupo-tesseract/ansible-playground-with-docker-d85b81220b8d)
