**Description**


Этоn контейнер, основанный на CentOS 7, содержит wazuh-manager 3.2 (fork of ossec-manager смотри [wazuh.com](http://wazuh.com/)). Он предназначен для установки в комплекте [ESGuardin LittleBeat Wazuh Addon](https://github.com/ESGuardian/LittleBeat/wiki), но может быть использован совершенно самостоятельно. 

By default this container will create a volume to store configuration, log and agent key data 
under /var/ossec/data.  Additionally it is configured with a local instance of postfix to 
send alert notifications.

  
**Запуск:**

		docker volume create ossec-data
		docker run -d --restart=always -p 1514:1514/udp -p 1515:1515/tcp -v ossec-data:/var/ossec/data --name ossec-server esguardian/ossec-docker


**Остановка:**

       docker stop ossec-server

**Перезапуск:**

       docker start ossec-server


**Подключение внутрь контейнера:**

        docker exec -it ossec-server  bash
		
**Файлы конфигурации, логи, правила и т.п. лежат здесь:**
		
		/var/lib/docker/volumes/ossec-data/_data/


**Благодарности:**

        Это переделка atomicorp/ossec-docker от [Atomicorp](https://atomicorp.com/). За что им огромное спасибо.


